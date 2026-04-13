---
layout: article
cover: /articles/2026/april/fork-multilenguaje-cover.avif
author:
  name: Ever Burga
description: Lo que empezó como un fork para ajustar un tema terminó obligándome a ordenar contenido, publicar en dos registries y tratar el repositorio como producto.
date: 2026-04-13T10:00:00.000Z
---

# Cómo Volví Mi Fork Multilenguaje y Lo Publiqué Bien

Durante bastante tiempo traté este fork como se suelen tratar los forks: una copia útil, un poco de maquillaje, un par de cambios que “ya luego ordeno” y a seguir con otra cosa.

El problema es que esa mentira funciona mientras el proyecto vive encerrado en tu máquina. En el momento en que quise usarlo como una capa reusable para mi blog, darle soporte multilenguaje y además publicarlo de forma limpia en npmjs y GitHub Packages, el fork dejó de ser un experimento. Ahí ya no bastaba con que funcionara. Tenía que tener estructura, rutas predecibles y un pipeline que no dependiera de mi paciencia ni de copiar comandos a mano.

Y honestamente, ahí fue donde se puso interesante.

## El momento en que el fork dejó de ser “solo un fork”

La base era `Alpine`, el tema de Nuxt. Mi objetivo inicial era simple: castellanizarlo y adaptarlo a mi blog. Pero apenas apareció la necesidad de contenido bilingüe, la cosa cambió de escala.

Ya no era solamente traducir textos de interfaz. Había que pensar en rutas, organización de contenido, consultas por locale, navegación, fechas y, sobre todo, en cómo hacer que otro proyecto pudiera consumir este tema sin hacks raros.

> Placeholder de imagen: estructura de carpetas mostrando `content/es/` y `content/en/` con el mismo árbol de artículos.

Lo primero fue aceptar algo incómodo: si el contenido crece, una estructura improvisada te explota en la cara. Y si además quieres que el tema viva como paquete, el desorden deja de ser una molestia local y se convierte en deuda para cada deploy.

## La parte multilenguaje no era solamente traducir strings

Lo más obvio fue mover los textos de interfaz a archivos de locale. Eso sale relativamente rápido. Lo menos obvio fue asumir que el contenido también necesitaba una convención clara.

Terminé con una estructura por locale, algo así como `content/es/...` y `content/en/...`, y dentro de ambos árboles la misma jerarquía para artículos. Eso me dejó una conclusión práctica: para este proyecto, el nombre del mes funciona como un segmento de ruta, no como una pieza semántica que Nuxt traduzca por mí.

En otras palabras: si el folder se llama `april`, Nuxt lo va a tratar como `april` tanto en español como en inglés. No le importa si el locale es `es` o `en`; le importa que la ruta exista. Eso me gustó porque me permite una convención única para assets, contenido y URLs. Tiene un costo, claro: una URL en español puede terminar siendo algo como `/es/articles/2026/april/...`. A mí no me molesta. De hecho, prefiero esa consistencia antes que estar peleando con nombres de carpetas distintos para el mismo mes.

## Ordenar el contenido fue lo que hizo posible todo lo demás

Una vez que la estructura quedó clara, el resto empezó a caer por su propio peso.

Las consultas de contenido ya podían apuntar al locale correcto. La navegación podía filtrar por subárbol. El formateo de fechas podía depender del idioma activo. Y, algo que me importaba bastante, el proyecto consumidor ya no tenía que adivinar cómo debía organizar el contenido para que el tema funcionara.

Ese fue uno de esos momentos donde te das cuenta de que la “feature visible” era multilenguaje, pero la mejora real era otra: ahora el fork tenía una forma reconocible. Ya parecía un paquete, no una carpeta con suerte.

> Placeholder de imagen: captura del sitio mostrando cambio de idioma y listado de artículos funcionando por locale.

## El paso a paso para conectar GitHub con npmjs sin vivir pegado a un token

La segunda mitad del trabajo fue la publicación. Quería dos cosas al mismo tiempo:

1. Publicar el paquete en npmjs para instalarlo como cualquier dependencia normal.
2. Publicarlo también en GitHub Packages para que el repositorio mostrara su paquete en la sección `Packages`.

Y quería hacerlo sin la clásica receta de guardar un `NPM_TOKEN` eterno y rezar para no olvidarme de renovarlo.

Así quedó el flujo.

### 1. Define bien el paquete antes de pensar en CI

Antes de tocar workflows, el `package.json` tiene que decir la verdad. En mi caso el paquete quedó como `@4xeverburga/alpine-spanishplus`, con su campo `repository` apuntando al repo correcto.

Eso parece detalle menor, pero no lo es. Si el nombre, el scope y el repositorio no están alineados, después todo se siente parchado: la publicación, el consumo y hasta la asociación del paquete con GitHub.

### 2. Haz que la publicación dependa de CI exitoso

En lugar de publicar directo en cada push, armé el workflow para que escuche el resultado de los workflows de CI. Es decir: primero valida, luego publica. No al revés.

Eso baja bastante el riesgo de empujar una versión rota por apuro. El workflow de publicación solo corre cuando la ejecución previa termina bien.

### 3. Dale a GitHub Actions los permisos que realmente necesita

Para este flujo necesité tres permisos claves en el job de publicación:

1. `contents: read`
2. `id-token: write`
3. `packages: write`

El importante aquí es `id-token: write`, porque eso habilita trusted publishing con npmjs usando OIDC. Traducido: GitHub puede demostrarle a npm quién es, sin que yo tenga que guardar un token manual en secrets.

### 4. Configura Trusted Publisher en npmjs

Este paso no está en el repo; está en npmjs. Hay que ir a la configuración del paquete y registrar a GitHub Actions como trusted publisher.

En mi caso la conexión quedó apuntando al repositorio y al workflow de publicación. Si ese nombre de repo o ese filename no coinciden exactamente, npm no confía y la publicación falla.

> Placeholder de imagen: pantalla de npmjs configurando `Trusted Publisher` con GitHub Actions.

### 5. Publica primero a npmjs

En el workflow, la primera configuración de Node apunta a `https://registry.npmjs.org`. Después de eso, el paquete se publica con `npm publish --access public`.

Para la rama `dev` además le agregué un sufijo tipo `-dev.<hash>` y publiqué con el dist-tag `dev`. Eso me da una salida bastante cómoda: `main` publica estable y `dev` publica una variante instalable sin pisar la versión final.

Ese detalle me encantó porque resuelve un problema muy real: querer probar el tema desde otro proyecto sin convertir cada experimento en release oficial.

### 6. Reconfigura Node y publícalo también a GitHub Packages

Después del publish a npmjs, vuelvo a ejecutar `actions/setup-node`, pero esta vez apuntando a `https://npm.pkg.github.com` y con el scope `@4xeverburga`.

Ahí sí uso `GITHUB_TOKEN` y vuelvo a hacer `npm publish`. Mismo paquete, mismo flujo, segundo registry.

Lo bueno de ese segundo publish no es solamente redundancia. Lo bueno es que GitHub ya tiene un paquete asociado al repo y lo muestra en la sección `Packages`, que visualmente le da al proyecto ese aire de “esto ya no es un fork tirado por ahí; esto ya se distribuye”.

### 7. Verifica el resultado desde el proyecto consumidor

La prueba de verdad no es ver el workflow verde. La prueba de verdad es instalar el paquete desde el proyecto que lo consume y confirmar que todo levanta bien.

En mi caso eso significó usar el tema desde el blog y comprobar que el contenido bilingüe seguía funcionando como esperaba. Si esa última parte falla, todo lo demás es decoración.

## La cereza del pastel: ver el paquete en la sección Packages del repo

No voy a fingir humildad aquí: esa parte da gusto.

Hay algo muy satisfactorio en entrar al repositorio y ver que, además del código, también está el paquete publicado. No cambia la arquitectura. No mejora el performance. No te arregla bugs. Pero sí cambia la sensación del proyecto.

Porque ahí ya no estás viendo solo commits. Estás viendo distribución.

> Placeholder de imagen: sección `Packages` del repositorio mostrando `@4xeverburga/alpine-spanishplus`.

Y eso, para un fork que empezó como una personalización, me parece una buena señal. Quiere decir que el proyecto ya cruzó esa línea donde deja de ser “mi copia modificada” y empieza a comportarse como una pieza reutilizable.

## Lo que me llevaría de todo esto

Si hoy tuviera que resumir la experiencia en una sola frase, sería esta: dar soporte multilenguaje fue la excusa; ordenar el proyecto y profesionalizar la publicación fue el trabajo real.

Traducir botones es fácil. Definir una convención de contenido que no se rompa, publicar sin depender de rituales manuales y hacer que el paquete viva bien fuera del repo, eso ya es otro nivel de disciplina.

Y creo que esa es la parte que más me gusta de este tipo de cambios: empiezas persiguiendo una feature pequeña y terminas arreglando la forma en que piensas el proyecto.

Si un fork va a vivir más de una semana, mejor tratarlo desde temprano como producto. Te ahorras caos. Y, de paso, te regalas ese pequeño gusto de verlo publicado como se debe.