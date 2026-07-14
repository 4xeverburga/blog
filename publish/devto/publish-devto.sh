#!/usr/bin/env bash
# publish-devto.sh — Publish/cross-post a blog article to dev.to via the Forem API.
#
# Usage:
#   ./publish/devto/publish-devto.sh <article.md>                   # create as draft (published: false)
#   ./publish/devto/publish-devto.sh <article.md> --publish         # publish immediately
#   ./publish/devto/publish-devto.sh <article.md> --tags a,b,c,d     # override auto-derived tags
#   ./publish/devto/publish-devto.sh <article.md> --dry-run          # preview payload, no request sent
#   ./publish/devto/publish-devto.sh <article.md> --yes              # skip the confirmation prompt
#
# Reads the Nuxt Content markdown file directly (frontmatter + body), converts it into
# dev.to's own frontmatter flavor (title, published, tags, cover_image, canonical_url,
# description), expands relative image paths to absolute URLs, and sends it via the Forem
# API. Looks up any existing dev.to article with the same canonical_url first: if found,
# it's updated in place (PUT), otherwise a new one is created (POST) — this makes re-runs
# idempotent and lets --publish promote an existing draft instead of duplicating it.
#
# Environment variables (from .env):
#   DEVTO_API_KEY   (Settings > Extensions > DEV Community API Keys)
#   BLOG_BASE_URL   (optional, defaults to https://everburga.dev)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Load .env
if [[ -f "$ROOT_DIR/.env" ]]; then
  set -a
  # shellcheck source=/dev/null
  source "$ROOT_DIR/.env"
  set +a
fi

BLOG_BASE_URL="${BLOG_BASE_URL:-https://everburga.dev}"
API_URL="https://dev.to/api/articles"
DRY_RUN=false
PUBLISH=false
SKIP_CONFIRM=false
TAGS_OVERRIDE=""

# --- Argument parsing ---
ARTICLE_PATH=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --publish) PUBLISH=true; shift ;;
    --yes|-y) SKIP_CONFIRM=true; shift ;;
    --tags) TAGS_OVERRIDE="$2"; shift 2 ;;
    *) ARTICLE_PATH="$1"; shift ;;
  esac
done

if [[ -z "$ARTICLE_PATH" ]]; then
  echo "Error: provide an article markdown file as argument." >&2
  echo "Usage: ./publish/devto/publish-devto.sh content/en/articles/2026/july/my-post.md [--publish] [--dry-run]" >&2
  exit 1
fi

if [[ ! -f "$ARTICLE_PATH" ]]; then
  echo "Error: file not found: $ARTICLE_PATH" >&2
  exit 1
fi

if [[ -z "${DEVTO_API_KEY:-}" ]]; then
  echo "Error: DEVTO_API_KEY not set. Check your .env file." >&2
  exit 1
fi

# --- Locate frontmatter boundaries (lines with just "---") ---
mapfile -t DELIM_LINES < <(grep -n '^---[[:space:]]*$' "$ARTICLE_PATH" | cut -d: -f1)
if [[ "${#DELIM_LINES[@]}" -lt 2 ]]; then
  echo "Error: could not find a frontmatter block (---...---) in $ARTICLE_PATH" >&2
  exit 1
fi
FM_START="${DELIM_LINES[0]}"
FM_END="${DELIM_LINES[1]}"

FRONTMATTER=$(sed -n "$((FM_START + 1)),$((FM_END - 1))p" "$ARTICLE_PATH")
BODY_RAW=$(tail -n "+$((FM_END + 1))" "$ARTICLE_PATH")

# --- Extract fields from frontmatter ---
COVER=$(echo "$FRONTMATTER" | grep -m1 '^cover:' | sed -E 's/^cover:[[:space:]]*//' | sed -E 's/^["'"'"']|["'"'"']$//g')
DESCRIPTION=$(echo "$FRONTMATTER" | grep -m1 '^description:' | sed -E 's/^description:[[:space:]]*//' | sed -E 's/^["'"'"']|["'"'"']$//g')
KEYWORDS=$(echo "$FRONTMATTER" | grep -A1 'name: keywords' | grep 'content:' | sed -E 's/^[[:space:]]*content:[[:space:]]*//')

# --- Title: first H1 in the body ---
TITLE=$(echo "$BODY_RAW" | grep -m1 '^# ' | sed -E 's/^#[[:space:]]*//' | sed -E 's/<[^>]*>//g')
if [[ -z "$TITLE" ]]; then
  echo "Error: could not find a top-level '# Title' heading in $ARTICLE_PATH" >&2
  exit 1
fi

# Strip only the first H1 line from the body (dev.to shows title from frontmatter).
BODY=$(echo "$BODY_RAW" | awk '!found && /^# / { found=1; next } { print }')

# --- Expand relative asset paths (src="/..." and markdown images) to absolute URLs ---
BODY=$(echo "$BODY" | sed -E "s#(src=\")(/[^\"]*)#\1${BLOG_BASE_URL}\2#g; s#(\]\()(/[^)]*)#\1${BLOG_BASE_URL}\2#g")

COVER_IMAGE=""
if [[ -n "$COVER" ]]; then
  if [[ "$COVER" == /* ]]; then
    COVER_IMAGE="${BLOG_BASE_URL}${COVER}"
  else
    COVER_IMAGE="$COVER"
  fi
fi

# --- Canonical URL: mirror the Nuxt Content _path (content/<locale>/articles/...) ---
REL_PATH="${ARTICLE_PATH#*content}"
CANONICAL_PATH="${REL_PATH%.md}"
CANONICAL_URL="${BLOG_BASE_URL}${CANONICAL_PATH}"

# --- Tags: dev.to allows up to 4, alphanumeric only, no spaces ---
if [[ -n "$TAGS_OVERRIDE" ]]; then
  TAGS_SOURCE="$TAGS_OVERRIDE"
else
  TAGS_SOURCE="$KEYWORDS"
fi

TAGS_CSV=$(echo "$TAGS_SOURCE" \
  | tr ',' '\n' \
  | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]//g' \
  | awk 'NF && !seen[$0]++' \
  | head -n 4 \
  | paste -sd, -)

PUBLISHED_VALUE="false"
[[ "$PUBLISH" == true ]] && PUBLISHED_VALUE="true"

# --- Look up an existing article by canonical_url so re-runs update in place ---
EXISTING_ID=$(curl -s "https://dev.to/api/articles/me/all?per_page=1000" \
  -H "api-key: $DEVTO_API_KEY" \
  | jq -r --arg url "$CANONICAL_URL" '.[] | select(.canonical_url == $url) | .id' | head -n1)

if [[ -n "$EXISTING_ID" ]]; then
  SEND_METHOD="PUT"
  SEND_URL="${API_URL}/${EXISTING_ID}"
else
  SEND_METHOD="POST"
  SEND_URL="$API_URL"
fi

# --- Build dev.to-flavored frontmatter + body ---
{
  echo "---"
  echo "title: ${TITLE}"
  echo "published: ${PUBLISHED_VALUE}"
  [[ -n "$TAGS_CSV" ]] && echo "tags: ${TAGS_CSV}"
  [[ -n "$COVER_IMAGE" ]] && echo "cover_image: ${COVER_IMAGE}"
  echo "canonical_url: ${CANONICAL_URL}"
  [[ -n "$DESCRIPTION" ]] && echo "description: ${DESCRIPTION}"
  echo "---"
  echo ""
  echo "$BODY"
} > /tmp/devto-body-$$.md

FULL_MD_FILE="/tmp/devto-body-$$.md"

PAYLOAD=$(jq -n --rawfile body "$FULL_MD_FILE" '{article: {body_markdown: $body}}')
rm -f "$FULL_MD_FILE"

# --- Confirm or dry-run ---
echo "========================================"
echo "DEV.TO ARTICLE PREVIEW"
echo "========================================"
echo "Action:        $SEND_METHOD $( [[ -n "$EXISTING_ID" ]] && echo "(existing article #$EXISTING_ID)" || echo "(new article)" )"
echo "Title:         $TITLE"
echo "Published:     $PUBLISHED_VALUE"
echo "Tags:          $TAGS_CSV"
echo "Cover image:   $COVER_IMAGE"
echo "Canonical URL: $CANONICAL_URL"
echo "----------------------------------------"
echo "$PAYLOAD" | jq -r '.article.body_markdown'
echo "========================================"

if [[ "$DRY_RUN" == true ]]; then
  echo "[dry-run] No request sent."
  exit 0
fi

if [[ "$SKIP_CONFIRM" != true ]]; then
  read -rp "Send this article to dev.to? (y/N) " confirm
  if [[ "$confirm" != [yY] ]]; then
    echo "Aborted."
    exit 0
  fi
fi

# --- Send ---
RESPONSE=$(curl -s -w "\n%{http_code}" -X "$SEND_METHOD" "$SEND_URL" \
  -H "api-key: $DEVTO_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY_RESPONSE=$(echo "$RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" -ge 200 && "$HTTP_CODE" -lt 300 ]]; then
  echo "Sent successfully (HTTP $HTTP_CODE)"
  echo "$BODY_RESPONSE" | jq -r '"URL: " + (.url // "n/a")'
else
  echo "Error: HTTP $HTTP_CODE" >&2
  echo "$BODY_RESPONSE" | jq . 2>/dev/null || echo "$BODY_RESPONSE" >&2
  exit 1
fi
