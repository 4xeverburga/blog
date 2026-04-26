---
layout: article
cover: /articles/2026/april/el_blog_renace.png
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: This post marks the rebirth of my blog, even if an awkward part of the credit probably belongs to AI.
date: 2026-04-13T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: nuxt theme, bilingual blog, npm publish, github actions, github workflows, npmjs, github, i18n, OIDC, trusted publishing, ci-cd, open source
---

# How I Made My Fork Bilingual and Published It Right

This post marks the rebirth of my blog. Not because I suddenly have a grand editorial vision or a pressing need to share wisdom with the world. I just finally touched it again seriously.

I remember seeing a post about the creator of OpenClaw: dozens of repos, and the first viral one was OpenClaw.

That felt a lot like life. You take enough shots, one of them lands. So here we are.

Now that I am back and Claude 4.6 showed up and all that, the whole thing feels a bit blurry. A big part of the corrections I am sharing here were contributed by Claude. I still do not know how much credit I should take. If you are only here out of curiosity and want the npm publishing angle, here is the brief.

## Index
1. [What I actually worked on](#what-i-actually-worked-on)
2. [The lines that actually matter](#the-lines-that-actually-matter)
3. [Repo](#repo)

## What I actually worked on

I looked at my branch history and, to be fair, there was at least one moment where I had to be the human in the loop and fix the npm scope by creating an organization.

The annoying detail is simple: your handle on GitHub and npmjs should match, or you need an org that does. That part is boring, but it is also the part that breaks the nice story if you ignore it.

## The lines that actually matter

This is the core of my `publish.yml`:

```yaml
on:
  workflow_run:
    workflows: ["ci-main", "ci-dev"]
    types: [completed]
    branches: [main, dev]

jobs:
  publish:
    if: ${{ github.event.workflow_run.conclusion == 'success' }}

    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.workflow_run.head_branch }}

      - uses: actions/setup-node@v4
        with:
          node-version: 22.14
          registry-url: https://registry.npmjs.org

      - name: Upgrade npm
        run: npm install -g npm@latest

      - name: Install dependencies
        run: pnpm install --ignore-scripts

      - name: Bump version with dev suffix
        if: ${{ github.event.workflow_run.head_branch == 'dev' }}
        run: |
          COMMIT=$(git rev-parse --short HEAD)
          VERSION=$(node -p "require('./package.json').version")
          npm version "${VERSION}-dev.${COMMIT}" --no-git-tag-version

      - name: Publish to npm
        run: npm publish --access public

      - name: Publish to GitHub Packages
        env:
          NODE_AUTH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: npm publish --access public
```

- `dev` publishes with a commit-based suffix and does not pollute `latest`
- `main` publishes cleanly
- npm does not depend on long-lived tokens lying around
- GitHub Packages stays in sync
- publish only runs after CI passes

<p align="center">
  <img src="/articles/2026/april/trusted_publisher_npmjs.png" alt="Trusted publisher setup in npmjs" title="Trusted publisher connected to GitHub Actions">
  <em>the boring part, which is usually where the real problems live</em>
</p>

## Repo

These are the sources:

- repo: [4xeverburga/nuxt-alpine-spanishplus](https://github.com/4xeverburga/nuxt-alpine-spanishplus)
- workflows: [`.github/workflows`](https://github.com/4xeverburga/nuxt-alpine-spanishplus/tree/main/.github/workflows)