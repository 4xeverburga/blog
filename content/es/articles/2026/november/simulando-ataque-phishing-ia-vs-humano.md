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
  title: Simulando un ataque de phishing, IA vs humano (challenge 3b1b/doppel)
  description: Resolví a mano el puzzle de phishing de 3Blue1Brown y Doppel, y lo comparé en una simulación con la solución de un modelo.
head:
  meta:
    - name: keywords
      content: phishing, 3blue1brown, doppel, divergencia KL, detector, simulación, optimización, ia vs humano
---

# Simulando un Ataque de Phishing: IA vs Humano

![Phishing expected payoff vs filter strength, humano e IA](/articles/2026/november/doppel-phishing-payoff.gif "Phishing expected payoff vs filter strength")

3Blue1Brown y Doppel publicaron un challenge en [https://www.3blue1brown.com/talent/.](https://www.3blue1brown.com/talent/)   
  
Actualmente me encuentro estudiando conceptos de estadística y teoría de información. Se veía como un buen entrenamiento, así que me di a hacerlo a mano primero.   
  
\<adjuntar imagen de fotos a mano>  
\<enlace a fotos raw>  
  
En mi solución propuesta no asumimos que el defensor no actualiza los parámetros de los filtros de phishing. Considerar que los parámetros también son variables probablemente introduzca nueva superficie de investigación y canales de información, pero no ha sido considerado en este writeup.

## Conclusiones 

Las conclusiones de mi solución:

- Mientras el atacante estima los parámetros C y f (supervivencia ante las flags) la mejor estrategia es enviar mensajes con únicamente n=1 frases/tokens maliciosos.
- Una vez conocidos $C$ y $f$ el problema es de optimización: elegir cuántas veces usar cada token de modo que no se supere el filtro C.

Revisen la solución completa! [la solución humana (PDF)](/articles/2026/november/doppel-phishing-solucion-humana.pdf).

## Simulación 

![Uso del presupuesto de divergencia de cada estrategia según la tasa de falsos positivos](/articles/2026/november/doppel-phishing-budget.gif "Qué fracción del presupuesto de divergencia usa cada estrategia")  
En estos tiempos en los que la IA puede razonar de manera increíble es fácil perder motivación. Decidí aprovechar para hacer una comparación entre mi solución y Fable trabajando de manera autónoma en una propuesta.

Obviamente, un must fue desarrollar un engine con interfaces que separen claramente la información que puede recibir el atacante y a la que tiene acceso el defensor. De ese modo se mantiene una comparación juta entre ambas estrategias. 

La ganancia esperada de los mensajes de phishing quedó ajustada, como vieron en el primer gif. Pero Fable encontró una mejor estrategia para extraer información del canal Z de respuesta de un mensaje de phishing.  
  
¿Podría haber obtenido mejores resultados dejando iterar a Fable sobre la simulación y sus resultados?. O podría haber hecho un modelo con overfit. Difícil de saber. 

El código de la simulación lo encuentran en [github.com/4xeverburga/doppel-phising-strat](https://github.com/4xeverburga/doppel-phising-strat).
