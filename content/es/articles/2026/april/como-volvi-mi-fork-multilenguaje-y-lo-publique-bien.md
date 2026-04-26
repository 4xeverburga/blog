---
layout: article
cover: /articles/2026/april/portada_hablemos_manga.png
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: Este post marca el renacer de mi blog
date: 2026-04-13T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: nuxt theme, bilingual blog, npm publish, github actions, github workflows, npmjs, github, i18n, OIDC, trusted publishing, ci-cd, open source
---

# Cómo volví mi fork multilenguaje y lo publiqué bien

Este post marca el renacer de mi blog. No porque ahora tenga ideas a desbordar que contar al mundo; simplemente porque por fin volví a tocarlo en serio. 
Recuerdo ver una publicación sobre el creador de OpenClaw: decenas de repos, el primer viral fue OpenClaw.

Es como la vida, pensé. De muchos tiros alguno da en el blanco. Así que seguimos.

Ahora que he vuelto y ha salido Claude 4.6 y demás, todo es muy incierto. Mis propias correcciones que ahora te comparto fueron contribuidas en su mayor parte por Claude. No sé cuánto crédito debería tomar. Si por curiosidad sigues leyendo y te interesa cómo publicar a node, te dejo aquí abajo mi brief:

## Índice
1. [Lo que sí trabajé](#lo-que-si-trabaje)
2. [Las líneas que de verdad importan](#las-lineas-que-de-verdad-importan)
3. [Repo](#repo)


## Lo que sí trabajé

Miré el historial de mi rama y, para ser honesto, me di cuenta de que hubo un error en el que tuve que ser el human in the loop y cambiar el scope de mi cuenta de npmjs creando una organización. 

Lo que pasa es que debes tener el mismo handle en github y en npmjs (o en una org). Ese detalle te lo comparto.

## Las líneas que de verdad importan

Esto es lo principal de mi `publish.yml`:

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

- `dev` publica con sufijo en base al commit y sin ensuciar `latest`
- `main` publica limpio
- npm no depende de tokens eternos vulnerables
- GitHub Packages queda sincronizado
- el publish solo corre si CI pasó antes


<p align="center">
  <img src="/articles/2026/april/trusted_publisher_npmjs.png" alt="Configuración de trusted publisher en npmjs" title="Trusted publisher conectado con GitHub Actions">
  <em>No olvidar tener el mismo handle, así tienes tu publicación bonita sincronizada en Github</em>
</p>

## Repo

Estas son las fuentes.

- repo: [4xeverburga/nuxt-alpine-spanishplus](https://github.com/4xeverburga/nuxt-alpine-spanishplus)
- workflows: [`.github/workflows`](https://github.com/4xeverburga/nuxt-alpine-spanishplus/tree/main/.github/workflows)

