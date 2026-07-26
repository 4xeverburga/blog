---
title: Espiar a Tu Competencia de Manera Legal es Posible
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
  avatarUrl: https://www.linkedin.com/
cover: /articles/2026/july/spying-on-your-rivals-cover.svg
date: 2026-07-20T10:00:00.000Z
description: Rastrea a tu competencia con datos abiertos es una tarea... no tan difícil.
layout: article
seo:
  title: Rastreando a Los Usuarios de Tu Competencia
  description: Rastrear a tu competencia con datos públicos es sencillo.
head:
  meta:
    - name: keywords
      content: agentes, microsoft teams, m365 agents toolkit, azure bot service, sharepoint, rag engine, máquina de estados, chatbots, mesa de ayuda
---

# Espiar a Tu Competencia de Manera Legal es Posible

::div{.hero-breakout}
  :::div{.hero-breakout-inner}
  ![Diagrama del flujo de rastreo de la competencia con datos abiertos](/articles/2026/july/spying-on-your-rivals-hero.svg)
  :::
::

¿Cómo se obtiene datos de usuario de páginas que te interesa monitorear?

Usando datos públicos de Google!

No es necesario un scraper o suscripciones costosas a wappalyzer.

Solo necesitas 

- La base de datos en bq y api de crux.
- La base de datos de http archive en bq.

## Decisiones de Arquitectura

### Primero veamos la naturaleza de las fuentes de datos

Las BD de crux y http archive se actualizan mensualmente. Crux tiene un retraso de 2 meses, mientras que http archive de solo 1 mes. Esta diferencia tiene impacto para el análisis de datos. Por eso conviene etiquetar el mes de provenance de cada dato que ingrese a nuestro data lake. 

Por otro lado, para el usuario final que solo quiere ver reportes, la diferencia de 1 mes no importa mucho. Incluso se podría interpretar como un retraso de procesamiento o algun desfase insignificante entre los gráficos históricos. 

Ahora, si nos enfocamos en el volumen de datos, cada base de datos utiliza como identificador un campo llamado origin, que podríamos interpretar como el dominio 

## Transformación De Datos

Partimos de una tabla cruda con lo que detectamos en cada sitio: el origen (dominio), el nombre de la tecnología y una lista de categorías tal cual las reporta la fuente (por ejemplo, una tecnología puede venir etiquetada como `cms`, `blogs` y `page builders` al mismo tiempo). Esa granularidad es demasiado ruidosa para comparar competidores entre sí, así que la pipeline la reduce en dos etapas.

### Etapa 1: Remapeo a Macrocategorías

![Diagrama del remapeo de categorías crudas a macrocategorías normalizadas](/articles/2026/july/spying-on-your-rivals-remapping.svg)*Remapeo de categorías crudas a macrocategorías normalizadas.*

`Origin_Technologies` sale directo del catálogo (Iceberg sobre R2) con una lista de categorías por tecnología. Como esas categorías vienen de la fuente original y no están estandarizadas, un diccionario estático, `MacroCategoriesMap`, agrupa variantes como `cms`, `blogs` y `page builders` bajo una única macrocategoría (`cms`), o `hosting`, `paas`, `iaas` y `lb` bajo `hosting`. El resultado es `Origin_Technologies_Norm`: origen, tecnología y una sola macrocategoría por fila, donde cada fila completa actúa como llave primaria.

### Etapa 2: Limpiando empates.

![Diagrama del proceso LinearUntie para colapsar tecnologías atadas a una misma macrocategoría](/articles/2026/july/spying-on-your-rivals-linear-untie.svg)*LinearUntie: colapsando tecnologías atadas a una misma macrocategoría.*

Con las tecnologías ya normalizadas, sigue un problema distinto: un mismo origen puede tener varias tecnologías detectadas dentro de la misma macrocategoría (varios candidatos de CMS, o varios frameworks de frontend a la vez). `LinearUntie` agrupa por origen y macrocategoría con `STRING_AGG` para atar esos candidatos en una sola fila. Después, `MacrocatLinearOrders` define, por macrocategoría, un orden fijo de preferencia entre tecnologías (por ejemplo, Wordpress antes que Magento dentro de `cms`, o Next.js antes que Express dentro de su categoría), y ese orden se usa para deshacer el empate y quedarnos con una única tecnología representativa por origen y macrocategoría.

##
