---
layout: article
cover: /articles/2026/april/portada_hablemos_manga.png
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: Un sistema de diseño estandarizado para LLMs
date: 2026-04-16T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: nuxt theme, bilingual blog, npm publish, github actions, github workflows, npmjs, github, i18n, OIDC, trusted publishing, ci-cd, open source
---

# Mejorando las <span aria-label="VIBES"><span style="color:#ff5c8a;">V</span><span style="color:#ff9f43;">I</span><span style="color:#ffd166;">B</span><span style="color:#2ec4b6;">E</span><span style="color:#3a86ff;">S</span></span> de mi aplicación con DESIGN.md

<p align="center">
<span aria-label="VIBES"><span style="color:#ff5c8a;">V</span><span style="color:#ff9f43;">I</span><span style="color:#ffd166;">B</span><span style="color:#2ec4b6;">E</span><span style="color:#3a86ff;">S</span></span>
</p>

El diseño de interfaces es complejo. A pesar de que me gusta mucho la pintura y el aspecto visual de las cosas, como a muchos desarrolladores, mis esfuerzos no dan para aprender tanto.

Antes, con ayuda de Claude y una gran lista de requerimientos, logré desplegar mi aplicación [HablemosManga](https://hablemosmanga.kekeros.com). Con un diseño frío y genérico. Robótico. 

<p align="center">
  <video src="/articles/2026/april/hablemos_manga_antes.mp4" controls></video>
  <em>HablemosManga antes del rediseño con DESIGN.md</em>
</p>

No es novedad. Desde que uso herramientas de LLM para desarrollar la ejecución se ha acelerado muchísimo pero la experiencia de usuario y la inferfaz no tanto. 

Tal vez sea mi culpa, pero siempre termino dándole un montón de prompts y trabajando en diseñar a mi manera un sistema de diseño para mi proyecto. 

Scrolleando por internet encontré [DESIGN.md](https://stitch.withgoogle.com/docs/design-md/overview) y resulta que hay muchos repos implementado sus sitemas de diseño. Simple, replicable y con buenos resultados. Vi que viene de Google Stitch, y aprovechando que tengo Gemini Pro me fui a quemar tokens:

<p align="center">
  <img src="/articles/2026/april/stitch_ejemplo.png" alt="Google Stitch generando un sistema de diseño">
  <em>Google Stitch generando un sistema de diseño para mi proyecto</em>
</p>

Intenté darle contexto sobre mi proyecto, pero el diseño de Gemini me parece sobresaturado. No convence. Pero mira, te genera un design.md!

<p align="center">
  <img src="/articles/2026/april/stitch_designmd.png" alt="DESIGN.md generado por Stitch">
  <em>El DESIGN.md que genera Stitch — simple y estructurado</em>
</p>

En fin. Luego encontré [getdesign.md/shopify/design-md](https://getdesign.md/shopify/design-md) y estoy usando ahora la plantilla de Shopify, que es un negocio de e-commerce, similar a mi aplicación. Luego le pedí a Claude que aplique el nuevo sistema de diseño al proyecto y estos son los resultados...

<p align="center">
  <video src="/articles/2026/april/hablemos_manga_despues.mp4" controls></video>
  <em>HablemosManga tras rediseño con DESIGN.md</em>
</p>

Luego mientras estoy escribiendo salió Claude Design. Se ve prometedor. Y también salió Claude 4.7, que al parecer es el 4.6 antes de que le redujeran capacidad de pensamiento, así que este artículo sigue vigente. 

Claude Design también genera un DESIGN.ms y Claude Code es compatible con el estándar.


