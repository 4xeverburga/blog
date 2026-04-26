#!/usr/bin/env bash
# publish.sh — Publish a post to LinkedIn and/or X via PostPeer API.
#
# Usage:
#   ./publish/publish.sh <post-json>            # publish to all platforms in the JSON
#   ./publish/publish.sh <post-json> --schedule "2026-04-25T09:00:00" --timezone "America/Lima"
#   ./publish/publish.sh <post-json> --dry-run  # preview the payload without sending
#
# Post JSON structure (see publish/linkedin/ or publish/x/ for examples):
#   {
#     "content": "Post text here...",
#     "platforms": ["linkedin", "x"],
#     "images": ["/articles/2026/april/stitch_ejemplo.png"]
#   }
#
# Environment variables (from .env):
#   POSTPEER_API_KEY
#   POSTPEER_LINKEDIN_ACCOUNT_ID
#   POSTPEER_X_ACCOUNT_ID
#   BLOG_BASE_URL  (optional, defaults to https://everburga.dev)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Load .env
if [[ -f "$ROOT_DIR/.env" ]]; then
  set -a
  # shellcheck source=/dev/null
  source "$ROOT_DIR/.env"
  set +a
fi

BLOG_BASE_URL="${BLOG_BASE_URL:-https://everburga.dev}"
API_URL="https://api.postpeer.dev/v1/posts"
DRY_RUN=false
SCHEDULE_FOR=""
TIMEZONE="America/Lima"

# --- Argument parsing ---
POST_JSON=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --schedule) SCHEDULE_FOR="$2"; shift 2 ;;
    --timezone) TIMEZONE="$2"; shift 2 ;;
    *) POST_JSON="$1"; shift ;;
  esac
done

if [[ -z "$POST_JSON" ]]; then
  echo "Error: provide a post JSON file as argument." >&2
  echo "Usage: ./publish/publish.sh publish/linkedin/my-post.json [--schedule ISO8601] [--dry-run]" >&2
  exit 1
fi

if [[ ! -f "$POST_JSON" ]]; then
  echo "Error: file not found: $POST_JSON" >&2
  exit 1
fi

if [[ -z "${POSTPEER_API_KEY:-}" ]]; then
  echo "Error: POSTPEER_API_KEY not set. Check your .env file." >&2
  exit 1
fi

# --- Read post file ---
CONTENT=$(jq -r '.content' "$POST_JSON")
mapfile -t PLATFORMS < <(jq -r '.platforms[]' "$POST_JSON")
mapfile -t IMAGES < <(jq -r '.images // [] | .[]' "$POST_JSON")

# --- Build platform entries (platform + accountId only) ---
build_platform_entry() {
  local platform="$1"
  local account_var
  local api_platform="$platform"

  case "$platform" in
    linkedin) account_var="POSTPEER_LINKEDIN_ACCOUNT_ID" ;;
    x)
      account_var="POSTPEER_X_ACCOUNT_ID"
      # PostPeer API expects "twitter" as the platform name.
      api_platform="twitter"
      ;;
    *)
      echo "Warning: unknown platform '$platform', skipping." >&2
      return
      ;;
  esac

  local account_id="${!account_var:-}"
  if [[ -z "$account_id" ]]; then
    echo "Error: $account_var not set for platform '$platform'." >&2
    exit 1
  fi

  jq -n --arg platform "$api_platform" --arg accountId "$account_id" \
    '{platform: $platform, accountId: $accountId}'
}

PLATFORMS_JSON="[]"
for p in "${PLATFORMS[@]}"; do
  entry=$(build_platform_entry "$p")
  if [[ -n "$entry" ]]; then
    PLATFORMS_JSON=$(echo "$PLATFORMS_JSON" | jq --argjson e "$entry" '. + [$e]')
  fi
done

# --- Build top-level mediaItems from images ---
MEDIA_JSON="[]"
for img in "${IMAGES[@]}"; do
  [[ -z "$img" ]] && continue
  local_url="$img"
  if [[ "$img" == /* ]]; then
    local_url="${BLOG_BASE_URL}${img}"
  fi
  MEDIA_JSON=$(echo "$MEDIA_JSON" | jq --arg u "$local_url" '. + [{"url": $u, "type": "image"}]')
done

# --- Build final payload ---
PAYLOAD=$(jq -n \
  --arg content "$CONTENT" \
  --argjson platforms "$PLATFORMS_JSON" \
  --argjson mediaItems "$MEDIA_JSON" \
  '{content: $content, platforms: $platforms, mediaItems: $mediaItems}')

# Add scheduling or publishNow
if [[ -n "$SCHEDULE_FOR" ]]; then
  PAYLOAD=$(echo "$PAYLOAD" | jq \
    --arg s "$SCHEDULE_FOR" \
    --arg tz "$TIMEZONE" \
    '. + {scheduledFor: $s, timezone: $tz}')
else
  PAYLOAD=$(echo "$PAYLOAD" | jq '. + {publishNow: true}')
fi

# --- Confirm or dry-run ---
echo "========================================"
echo "POST PREVIEW"
echo "========================================"
echo "$PAYLOAD" | jq .
echo "========================================"

if [[ "$DRY_RUN" == true ]]; then
  echo "[dry-run] No request sent."
  exit 0
fi

read -rp "Publish this post? (y/N) " confirm
if [[ "$confirm" != [yY] ]]; then
  echo "Aborted."
  exit 0
fi

# --- Send ---
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL" \
  -H "x-access-key: $POSTPEER_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" -ge 200 && "$HTTP_CODE" -lt 300 ]]; then
  echo "Published successfully (HTTP $HTTP_CODE)"
  echo "$BODY" | jq . 2>/dev/null || echo "$BODY"
else
  echo "Error: HTTP $HTTP_CODE" >&2
  echo "$BODY" | jq . 2>/dev/null || echo "$BODY" >&2
  exit 1
fi
