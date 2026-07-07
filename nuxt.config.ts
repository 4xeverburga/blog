export default defineNuxtConfig({
  // https://github.com/nuxt-themes/alpine
  extends: '@4xeverburga/alpine-spanishplus',

  modules: [
    // https://github.com/nuxt-modules/plausible
    '@nuxtjs/plausible',
    // https://github.com/nuxt/devtools
    '@nuxt/devtools',
    // https://github.com/johannschopplich/nuxt-gtag
    'nuxt-gtag'
  ],

  runtimeConfig: {
    public: {
      siteUrl: process.env.SITE_URL || 'https://4verburga.kekeros.com'
    }
  },

  gtag: {
    id: process.env.GOOGLE_ANALYTICS_ID
  },

  css: ['~/assets/local.css'],

  compatibilityDate: '2024-09-06'
})