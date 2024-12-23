# Mi Blog

Mi fork de ```@nuxt-themes/alpine``` utilizado aquí es ```https://github.com/4xeverburga/nuxt-alpine-spanishplus```, pero  funciona solo con pnpm, asi que tienes 
que usar ```pnpm install``` y la suit de comandos de pnpm para generar el proyecto.

Si necesitas usar npm (como para cloudfare pages) el roundabout que uso es tomar el archivo generado por ```pnpm pack``` directamente: ```./nuxt-themes-alpine-1.6.6.tgz```.

El work TODO es encontrar la manera de configurar ```https://github.com/4xeverburga/nuxt-alpine-spanishplus``` para que funcione con npm.
Una alternativa es crear una rama /release en la que descomprimir el resultado de ```pnpm pack```, pero no es la solucion al problema raíz.


