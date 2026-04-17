---
layout: article
cover: /articles/2026/april/fork-multilenguaje-cover.avif
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: Desplegando las updates de mi blog a npmjs con github actions
date: 2026-04-13T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: nuxt theme, bilingual blog, npm publish, github actions, github workflows, npmjs, github, i18n, OIDC, trusted publishing, ci-cd, open source
---

# Un Pequeño Fork

Quise expandir mi proyecto para soporte multilenguaje. Y en el camino terminé los cambios necesarios para que tú también disfrutes del proyecto por completo.


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
