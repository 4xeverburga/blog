---
title: 'Simulando un Ataque de Phishing: IA vs Humano'
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
cover: /articles/2026/november/doppel-phishing-cover.webp
date: '2026-11-14T10:00:00.000Z'
description: Writeup del challenge de phishing de 3b1b/doppel
layout: article
seo:
  title: Simulando un ataque de phishing, IA vs humano (3b1b/Doppel challenge )
  description: Resolví a mano el puzzle de phishing de 3Blue1Brown y Doppel, y lo comparé en una simulación con la solución de un modelo.
head:
  meta:
    - name: keywords
      content: phishing, 3blue1brown, doppel, divergencia KL, detector, simulación, optimización, ia vs humano
---

# Simulando un Ataque de Phishing: IA vs Humano

::div{.hero-breakout}
  :::div{.hero-breakout-inner}
  ![Phishing expected payoff vs filter strength, humano e IA](/articles/2026/november/doppel-phishing-payoff.gif "Phishing expected payoff vs filter strength")
  :::
::

3Blue1Brown y Doppel publicaron un challenge en [3blue1brown.com/talent](https://www.3blue1brown.com/talent/).

Actualmente estoy estudiando estadística y teoría de la información. El challenge se veía como un buen entrenamiento, así que decidí resolverlo primero a mano.

![Notas manuscritas de la solución, página 1 de 7](/articles/2026/november/doppel-phishing-notas.png)

En mi solución asumo que el defensor no actualiza los parámetros de los filtros de phishing. Considerar que esos parámetros también son variables probablemente abriría nuevas líneas de investigación y nuevos canales de información, pero no lo contemplo en este writeup.

## Conclusiones

Las conclusiones de mi solución:

- Mientras el atacante estima los parámetros  C  y  f  (la supervivencia ante los flags), la mejor estrategia es enviar mensajes con una sola frase/token malicioso ( n=1 ).
- Una vez conocidos  C  y  f , el problema es de optimización: elegir cuántas veces usar cada token sin superar el umbral  C  del filtro.

[¡Revisen la solución completa!](https://github.com/4xeverburga/doppel-phising-strat/blob/main/proofs/pdf/solution_human_en.pdf).

## Simulación

![Uso del presupuesto de divergencia de cada estrategia según la tasa de falsos positivos](/articles/2026/november/doppel-phishing-budget.gif "Qué fracción del presupuesto de divergencia usa cada estrategia")

En estos tiempos en que la IA razona de manera increíble, es fácil perder la motivación. Decidí aprovecharlo para comparar mi solución con la de Fable, trabajando de forma autónoma en su propia propuesta ([PDF](https://github.com/4xeverburga/doppel-phising-strat/blob/main/proofs/pdf/solution_ai_en.pdf)).

Un must fue desarrollar un motor con interfaces que separen claramente la información que recibe el atacante de la que tiene el defensor. Así la comparación entre ambas estrategias es justa.

La ganancia esperada de los mensajes de phishing quedó muy pareja, como vieron en el primer gif. Pero Fable encontró una mejor estrategia para extraer información del canal Z de respuesta a un mensaje de phishing.

¿Habría obtenido mejores resultados dejando iterar a Fable sobre la simulación y sus resultados? ¿O habría terminado con un modelo en overfit? Difícil de saber.

El código de la simulación está en [github.com/4xeverburga/doppel-phising-strat](https://github.com/4xeverburga/doppel-phising-strat).
