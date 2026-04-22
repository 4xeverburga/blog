# Agents

This workspace uses custom agents for blog content creation and social media publishing.

## Available Agents

### Article Writer
- **File**: `.github/agents/article-writer.agent.md`
- **Invoke**: `@Article Writer`
- **Purpose**: Draft, edit, and brainstorm blog articles in Ever's conversational Spanish style.
- **Skills**: Reads article files, generates frontmatter, places images with centered HTML blocks, follows the blog's narrative arc (hook → context → discovery → analysis → takeaway).
- **Scope**: Only edits files under `content/` and `public/`.

### Post Writer
- **File**: `.github/agents/post-writer.agent.md`
- **Invoke**: `@Post Writer`
- **Purpose**: Generate LinkedIn and X (Twitter) posts from blog articles, ready for publishing via PostPeer.
- **Skills**: Reads articles (ES/EN), selects images, writes platform-appropriate copy, outputs JSON post files.
- **Scope**: Only writes files under `publish/`.

## Typical Workflow

1. **Write an article** using `@Article Writer` with a topic or existing draft.
2. **Generate social posts** using `@Post Writer` with the article path(s).
3. **Review and publish**:
   ```bash
   # Preview without sending
   ./publish/publish.sh publish/linkedin/<slug>.json --dry-run

   # Publish immediately
   ./publish/publish.sh publish/linkedin/<slug>.json

   # Schedule for later
   ./publish/publish.sh publish/x/<slug>.json --schedule "2026-04-25T15:00:00Z"
   ```

## Publishing Infrastructure

- **API**: [PostPeer](https://postpeer.dev) — posts to LinkedIn and X from a single API call.
- **Config**: API key and account IDs live in `.env` (git-ignored).
- **Folder structure**:
  ```
  publish/
  ├── publish.sh          # CLI to send posts via PostPeer
  ├── linkedin/           # LinkedIn post JSONs
  └── x/                  # X (Twitter) post JSONs
  ```
- Future: `publish/devpost/` for DevPost integration.
