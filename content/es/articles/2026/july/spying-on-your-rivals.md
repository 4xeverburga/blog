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
      content: crux, http archive, bigquery, análisis competitivo, tecnologías web, wappalyzer, cloudflare r2, data lake, seo, analítica web
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

[theuxreport](https://theuxreport.kekeros.com)


## Decisiones de Arquitectura

### Primero veamos la naturaleza de las fuentes de datos

Las BD de crux y http archive se actualizan mensualmente. Crux tiene un retraso de 2 meses, mientras que http archive de solo 1 mes. Esta diferencia tiene impacto para el análisis de datos. Por eso conviene etiquetar el mes de provenance de cada dato que ingrese a nuestro data lake. 

Por otro lado, para el usuario final que solo quiere ver reportes, la diferencia de 1 mes no importa mucho. Incluso se podría interpretar como un retraso de procesamiento o algun desfase insignificante entre los gráficos históricos. 

Ahora, si nos enfocamos en el volumen de datos, cada base de datos utiliza como identificador un campo llamado origin, que podemos interpretar como el dominio web del que se sirve el contenido y las aplicaciones. 

Cada origin tiene decenas de columnas en total. Pero al fin de al cabo, un tamaño fijo de datos. Esto significa que el volumen de datos crece, dados los parámetros

- N: número de origins a analizar
- T: cantidad de unidades temporales a analizar,

... con complejidad O(NT). Para mi lista inicial de dominios peruanos registré 20mil dominios y mi objetivo es mantener una ventana de 24 semanas en el reporte. Dudo que en el futuro supere los 100mil dominios, así que tenemos un volumen modesto de datos que se puede procesar en un solo nodo, o mi computadora.

### Requisitos y restricciones

Entre otros requisitos más específicos,

- Quiero almacenar los datos históricos y enrichment en un formato de bajo costo de almacenamiento pero con alta garantía de integridad de datos.
- Mi página de reportes debe tener alta disponibilidad y presentar una experiencia de usuario fluida.
- Quiero mantener costos de mantenimiento mínimos.

AWS S3 + Athena, GCP BigQuery Iceberg Catalog... hay muchas soluciones en el mercado. Esta vez decidí usar Cloudfare R2 Data Catalog, con una generosa cuota de 10GB de almacenamiento gratis y alto número de lecturas y escrituras. 

En cuanto a la página, Astro es mi opción preferida en estos casos. Y la CDN será CloudFare para mantener sencillez de administración.

## Transformación De Datos

Las etapas de extracción, filtro y enrichment son sencillas. 

Sin embargo, http archive no entrega categorías tecnológicas normalizadas. Como usa el motor de firmas de wappalyzer, simplemente entrega categorías de lo que sea que detecte. Puedes tener React.js y Next.js a la vez, incluso cuando sabemos que Next.js es un meta-framework de React y no existe sin este.

### Etapa 1: Remapeo a Macrocategorías

![Diagrama del remapeo de categorías crudas a macrocategorías normalizadas](/articles/2026/july/spying-on-your-rivals-remapping.svg)*Remapeo de categorías crudas a macrocategorías normalizadas.*

Origin\_Technologies de R2 con una lista de categorías por tecnología. Después de agruparlas tenemos menos complejidad con la que trabajar. Pero es en esta etapa en la que hacemos el trabajo sucio.

### Etapa 2: Limpiando empates.

![Diagrama del proceso LinearUntie para colapsar tecnologías atadas a una misma macrocategoría](/articles/2026/july/spying-on-your-rivals-linear-untie.svg)*LinearUntie: colapsando tecnologías atadas a una misma macrocategoría.*

Un origen puede tener varias tecnologías para la misma categoría. Esto es una consecuencia de lo que te conté antes. Puedes tener Next.js y Next App Router clasificados dentro de la misma categoría de Web Frameworks.

Para colapsar estos empates uso un ordenamiento lineal de las tecnologías de acuerdo a categoría. Si encuentro Nest.js y Express a la vez, Nest.js es la opción que agrupa ambos conceptos. 

Una mejora directa a este modelo es realizar ordenamientos no solo por categoría, sino por categoría + framework. Pero esto requiere una tarea de relacionamiento costosa y de todas maneras hay excepciones que parten de la naturaleza con la que http archive genera los datos. 

Las excepciones menores o tecnologías mal categorizadas las voy agregando manualmente a una estructura en disco. Es un trabajo inevitable

## Ranking

Una vez que ya tienes los conjuntos de datos normalizados el ranking se vuelve una tarea de estadística, y la página de reportes un proceso de diseño y UI.

## The UX Report

Si te interesa validar los resultados que ves en la web o alguna publicación, estos son los pasos.

### Cómo reproducir tu **severity** y tu **score** con la API pública de CrUX

 Lo que se muestra en la sección Core Web Vitals sale directo de la [Chrome UX Report API](https://developer.chrome.com/docs/crux/api) de Google y que se usan en su ranking de SEO. 

#### 1. Pide un histograma a través de la CrUX API

```bash
curl --request POST \
  'https://chromeuxreport.googleapis.com/v1/records:queryRecord?key=TU_API_KEY' \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{"origin":"https://tu-dominio.pe"}'
```

La respuesta trae, por cada métrica, un **histogram** de 3 bins: bueno / necesita mejora / malo — cada uno con una **density** (fracción real de visitas de usuarios reales en ese rango, no un promedio sintético):

```json
"largest_contentful_paint": {
  "histogram": [
    { "start": 0,    "end": 2500, "density": 0.82 },
    { "start": 2500, "end": 4000, "density": 0.11 },
    { "start": 4000,               "density": 0.07 }
  ],
  "percentiles": { "p75": 2380 }
}
```

Las tres métricas que importan son **largest_contentful_paint** (LCP), **cumulative_layout_shift** (CLS) e **interaction_to_next_paint** (INP). Los core web vitals oficiales de Google.

#### 2. Calcula el severity de cada métrica

Por cada métrica, el severity es un promedio ponderado por la densidad real de cada banda:

```
severity_métrica = poor × 1.0 + needs_improvement × 0.5 + good × 0.0
```

Con el ejemplo de arriba: 0.07 × 1.0 + 0.11 × 0.5 + 0.82 × 0.0 = 0.125.

¿Por qué ponderado y no "banda dominante"? Porque un origen con 51% good / 49% needs-improvement y otro con 99% good / 1% needs-improvement son historias reales muy distintas 

#### 3. Promedia las tres métricas

```python
def metric_severity(good: float, ni: float, poor: float) -> float:
    return poor * 1.0 + ni * 0.5 + good * 0.0

severity = (
    metric_severity(*lcp_densities)
    + metric_severity(*cls_densities)
    + metric_severity(*inp_densities)
) / 3
```

**severity** queda entre 0 (perfecto) y 1 (el peor caso posible). Si a tu origen le falta alguna de las tres métricas en esta ventana (CrUX exige un mínimo de tráfico por métrica para publicarla) lo que hago es completar el dato con el promedio del cohorte de esa ventana de datos. En ese caso sí tendrías problemas para reproducir tu score completo, pero puedes usar un valor placeholder de 50% para llegar a un aproximado.

#### 4. Tu score

```python
score = round((1 - severity) * 100)
```

Con **severity = 0.125**, el score es **87/100**. Este número es 100% reproducible por cualquiera con solo la API pública de Google.

Espero que te haya gustado el artículo. Recuerda que cada mes actualizo el reporte de páginas. Te veo en mis métricas de analytics pronto!

## Colaboración

Tengo planeado liberar de manera open source el proyecto cuando entre en una etapa estable. Si quieres apoyar con alguna lista de URLs que consideras necesarias o una métrica que te gustaría tener escríbeme a mis redes con gusto.
