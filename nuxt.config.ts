export default defineNuxtConfig({
  // https://github.com/nuxt-themes/alpine
  extends: '@4verburga/alpine-spanishplus',

  modules: [
    // https://github.com/nuxt-modules/plausible
    '@nuxtjs/plausible',
    // https://github.com/nuxt/devtools
    '@nuxt/devtools'
  ],

  compatibilityDate: '2024-09-06'
})