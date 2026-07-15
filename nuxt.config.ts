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

  // `/sitemap.xml` is a custom server route (server/routes/sitemap.xml.ts) that queries
  // content at request time - nothing on the site ever links to it with a real <a href>
  // (it's only referenced as plain text in robots.txt), so the theme's prerender crawler
  // can't discover it on its own. Without this, it stays a dynamic route and hits the same
  // Cloudflare D1 requirement the rest of the site's prerendering was added to avoid (see
  // the theme's own nuxt.config.ts for the full explanation).
  //
  // `preset: 'cloudflare_pages_static'` (only on real Cloudflare Pages builds) matters too:
  // the regular `cloudflare_pages` preset still ships a `_worker.js` function and gates every
  // route through a generated `_routes.json` allow/deny list — which has Cloudflare's own hard
  // cap of 100 entries. Once the number of prerendered pages here (articles, in particular)
  // exceeds that, extra pages silently fall through to the worker instead of being served as
  // static files, which hits the same D1 requirement all over again for just those pages. The
  // `_static` preset skips the worker/`_routes.json` entirely — every prerendered page is a
  // real static file Cloudflare serves directly, so this scales to any number of articles.
  // This nuxt.config's own `preset` setting wins over Cloudflare's auto-injected `NITRO_PRESET`
  // env var (Nitro resolves `configOverrides.preset` before any env var).
  nitro: {
    preset: process.env.CF_PAGES ? 'cloudflare_pages_static' : undefined,
    prerender: {
      routes: ['/sitemap.xml']
    }
  },

  css: ['~/assets/local.css'],

  compatibilityDate: '2024-09-06'
})