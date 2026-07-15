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

  // Deployed on Cloudflare Pages: use Cloudflare's Image Resizing service instead of
  // the theme's default `ipx` provider (ipx relies on `sharp`, which doesn't run in the
  // Cloudflare Workers runtime). Other consumers of the theme choose their own provider here.
  image: {
    provider: 'cloudflare'
  },

  css: ['~/assets/local.css'],

  compatibilityDate: '2024-09-06'
})