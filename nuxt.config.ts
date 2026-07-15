export default defineNuxtConfig({
  // https://github.com/nuxt-themes/alpine
  extends: '@4xeverburga/alpine-spanishplus',

  modules: [
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

  // @nuxt/content only bundles Shiki grammars for bash/html/mdc/vue/yml/scss/ts/typescript by
  // default — any other fenced code language in an article (python, http, etc.) silently renders
  // as plain unhighlighted text (no error, no warning). Add every language actually used in
  // content/ here.
  content: {
    build: {
      markdown: {
        highlight: {
          langs: ['python', 'http', 'markdown']
        }
      }
    }
  },

  // Deployed on Cloudflare Pages: use Cloudflare's Image Resizing service instead of
  // the theme's default `ipx` provider (ipx relies on `sharp`, which doesn't run in the
  // Cloudflare Workers runtime). Other consumers of the theme choose their own provider here.
  // `CF_PAGES` is auto-injected by Cloudflare Pages builds only — locally (and in any other
  // environment) this stays unset, so `@nuxt/image` falls back to its default `ipx` provider,
  // which is the only one that actually resolves images outside of Cloudflare's own edge.
  image: {
    provider: process.env.CF_PAGES ? 'cloudflare' : undefined
  },

  css: ['~/assets/local.css'],

  compatibilityDate: '2024-09-06'
})