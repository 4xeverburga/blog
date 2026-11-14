---
title: "Simulando un Ataque de Phishing: IA vs Humano"
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
cover: /articles/2026/november/doppel-phishing-cover.webp
date: 2026-11-14T10:00:00.000Z
description: Writeup del challenge de phishing de 3b1b/doppel
layout: article
seo:
  title: Simulando un ataque de phishing, IA vs humano (challenge 3b1b/doppel)
  description: Resolví a mano el puzzle de phishing de 3Blue1Brown y Doppel, y lo comparé en una simulación con la solución de un modelo.
head:
  meta:
    - name: keywords
      content: phishing, 3blue1brown, doppel, divergencia KL, detector, simulación, optimización, ia vs humano
---

# Simulando un Ataque de Phishing: IA vs Humano

![Phishing expected payoff vs filter strength, humano e IA](/articles/2026/november/doppel-phishing-payoff.gif "Phishing expected payoff vs filter strength")

3Blue1Brown y Doppel publicaron un puzzle de phishing en la página de talento de 3b1b. Un atacante elige una distribución de frases para maximizar su retorno esperado, pero un detector lo vigila con una divergencia KL contra el correo legítimo y un filtro binario descarta ciertas palabras. El atacante no conoce ni el umbral ni el filtro.

## Las soluciones

Resolví el puzzle de dos formas:

- **A mano.** Mis [notas manuscritas originales](https://github.com/4xeverburga/doppel-phising-strat/tree/main/proofs/raw) son la fuente de todo lo demás.
- **Con un modelo.** [La solución de la IA](/articles/2026/november/doppel-phishing-solucion-ia.pdf) la desarrolló un modelo por su cuenta, sin mi supuesto de que el atacante conoce la distribución del defensor.

Explorando a mano algunas soluciones, llegué a una estrategia que me gustó bastante: mientras el atacante todavía estima el umbral y el filtro, conviene inyectar un solo token.

## Conclusiones del paper

Las conclusiones de mi solución:

- Mientras el atacante estima $C$ y $f$, la mejor estrategia es inyectar un único token ($n = 1$).
- Una vez conocidos $C$ y $f$, queda un problema clásico de optimización: elegir cuántas veces usar cada token bajo el presupuesto de divergencia.
- En un escenario real, el defensor probablemente actualiza los parámetros del filtro con frecuencia. Esa actualización de información es un tema de investigación, tanto para diseñar estrategias del atacante como del defensor.

Pueden leer el desarrollo completo en [la solución humana (PDF)](/articles/2026/november/doppel-phishing-solucion-humana.pdf).

## La simulación

![Uso del presupuesto de divergencia de cada estrategia según la tasa de falsos positivos](/articles/2026/november/doppel-phishing-budget.gif "Qué fracción del presupuesto de divergencia usa cada estrategia")

Para comparar las dos soluciones las enfrenté en una simulación sobre correos de verdad:

- **Defensor.** Mide la divergencia de cada mensaje contra Enron, calibra su umbral $C$ para no bloquear más de cierto porcentaje de correo legítimo (de 1 % a 20 %) y arma un filtro $f$ con el 10 % de los tokens maliciosos de mayor retorno.
- **Atacante.** Parte de una distribución pública distinta de Enron (SpamAssassin y listas de Python y Emacs), 155 tokens maliciosos y plantillas de correo inocuo que reescribe. Solo observa si el usuario convirtió, nunca si lo detectaron.
- **Humano e IA** corren sus estrategias en 25 mundos (5 tasas de falsos positivos y 5 longitudes de mensaje, de 100 a 500 tokens).

El retorno medio quedó casi empatado: 0.953 para la estrategia humana y 0.948 para la IA. La IA ganó en 7 de los 25 mundos, sobre todo con mensajes cortos y un filtro laxo, donde el humano llegó a 0.595 frente a 0.760 de la IA. Con mensajes largos, el humano suele ir por delante.

El código, los datos y la simulación completa están en [github.com/4xeverburga/doppel-phising-strat](https://github.com/4xeverburga/doppel-phising-strat). El corpus de phishing usado para los tokens maliciosos es de Jose Nazario (CC-BY-4.0).
