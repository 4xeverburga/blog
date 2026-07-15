export default defineNuxtConfig({
  // https://github.com/nuxt-themes/alpine
  extends: '@4xeverburga/alpine-spanishplus',

  modules: [
    // https://github.com/nuxt/devtools
    '@nuxt/devtools',
    // https://github.com/johannschopplich/nuxt-gtag
    'nuxt-gtag'
  ],

  gtag: {
    id: process.env.GOOGLE_ANALYTICS_ID
  },

  css: ['~/assets/local.css'],

  compatibilityDate: '2024-09-06'
})