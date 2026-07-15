# Agents

This workspace uses custom agents for blog content creation and social media publishing.

## Extra
You can compress mov videos with ffmpeg -i input.mov -vcodec libx264 -crf 28 -preset slow -acodec aac -b:a 96k output.mp4

## Deployment

- Deployed on **Cloudflare Pages** (project `blog-everb`), auto-deploying from `main` (production) — `dev` pushes also trigger a Cloudflare Pages preview deployment that can be checked independently without touching `main`.
- Node version is pinned via `.nvmrc` (currently `22.14.0`) and `engines.node` in `package.json`. Cloudflare Pages reads `.nvmrc`/`.node-version`/`engines.node` to pick its build Node version — without it, it silently falls back to an old default (observed: Node 18.17.1), which is incompatible with this project's deps (Nuxt 4, Vite 7/8, etc. all require Node >=20/22).
- **Lockfile must be regenerated with the same Node/npm version Cloudflare uses** (i.e. whatever `.nvmrc` pins — check with `nvm install $(cat .nvmrc) && nvm use $(cat .nvmrc)` first). Cloudflare Pages runs `npm ci`, which is strict about `package-lock.json` matching `package.json` exactly. A lockfile regenerated with a newer local npm (e.g. npm 11.x bundled with a newer Node than `.nvmrc` specifies) can resolve dependencies slightly differently than Cloudflare's pinned npm version and pass `npm ci` locally while still failing on Cloudflare with "Missing: X from lock file" errors — even though `package.json` and `package-lock.json` look consistent. Always regenerate (`rm -rf node_modules package-lock.json && npm install`) and verify (`rm -rf node_modules && npm ci`) using the exact `.nvmrc`-pinned version before pushing dependency changes.


## Available Agents

### Article Writer
- **File**: `.github/agents/article-writer.agent.md`
- **Invoke**: `@Article Writer`
- **Purpose**: Draft, edit, and brainstorm blog articles in Ever's conversational style.
- **Skills**: Reads article files, generates frontmatter, places images with centered HTML blocks, follows the blog's narrative arc (hook → context → discovery → analysis → takeaway).
- **Scope**: Only edits files under `content/` and `public/`.

### Post Writer
- **File**: `.github/agents/post-writer.agent.md`
- **Invoke**: `@Post Writer`
- **Purpose**: Generate LinkedIn and X (Twitter) posts from blog articles, ready for publishing via PostPeer.
- **Skills**: Reads articles (ES/EN), selects images, writes platform-appropriate copy, outputs JSON post files.
- **Scope**: Only writes files under `publish/`.

### Article Editor
- **File**: `.github/agents/article-editor.agent.md`
- **Invoke**: `@Article Editor`
- **Purpose**: Line-edit and polish drafts that are already substantively complete — grammar, resolving inline author notes/TODOs, redacting secrets/PII/company-identifying strings, normalizing code blocks and image references.
- **Skills**: Does not brainstorm or restructure content; only cleans up and redacts. Reports every redaction and resolved note back for the author to validate.
- **Scope**: Only edits files under `content/` and `public/`.

## Typical Workflow

1. **Write an article** using `@Article Writer` with a topic or existing draft.
2. **Polish the draft** using `@Article Editor` once the content is complete but rough (grammar, redaction, formatting).
3. **Generate social posts** using `@Post Writer` with the article path(s).
4. **Review and publish**:
   ```bash
   # Preview without sending
   ./publish/publish.sh publish/linkedin/<slug>.json --dry-run

   # Publish immediately
   ./publish/publish.sh publish/linkedin/<slug>.json

   # Schedule for later
   ./publish/publish.sh publish/x/<slug>.json --schedule "2026-04-25T15:00:00Z"

   # Cross-post an English article to dev.to as a draft, then review before publishing
   ./publish/devto/publish-devto.sh content/en/articles/2026/july/<slug>.md --dry-run
   ./publish/devto/publish-devto.sh content/en/articles/2026/july/<slug>.md
   ```

## Publishing Infrastructure

- **API**: [PostPeer](https://postpeer.dev) — posts to LinkedIn and X from a single API call.
- **Config**: API key and account IDs live in `.env` (git-ignored).
- **Folder structure**:
  ```
  publish/
  ├── publish.sh          # CLI to send posts via PostPeer
  ├── linkedin/           # LinkedIn post JSONs
  ├── x/                  # X (Twitter) post JSONs
  └── devto/
      └── publish-devto.sh   # CLI to cross-post an article markdown file to dev.to
  ```
- **dev.to**: Reads a Nuxt Content article file directly (frontmatter + body), rebuilds it with
  dev.to's own frontmatter (title, tags, cover_image, canonical_url, description), expands
  relative image paths to `BLOG_BASE_URL`, and posts via the Forem API (`DEVTO_API_KEY`). Creates
  drafts by default (`published: false`); pass `--publish` to publish immediately. English
  articles only for now — dev.to's audience is mostly English-speaking.
