// https://github.com/nuxt-themes/alpine/blob/main/nuxt.schema.ts
export default defineAppConfig({
  alpine: {
    title: 'Blog - Ever Burga',
    // Sets the `og:site_name` meta tag, which Google (and other crawlers) can use as the
    // displayed site name in search results/link previews instead of falling back to the
    // bare domain (e.g. "kekeros.com"). Re-indexing by Google isn't instant/guaranteed.
    siteName: 'Ever Burga',
    // Feeds the WebSite structured data's alternateName on the home page (see
    // app/pages/index.vue in the theme) - fallback candidates Google may pick if "Ever Burga"
    // itself isn't selected. The bare domain is appended automatically as the last resort.
    siteAlternateNames: ['EverBurga', 'Ever Burga Peralta', '4verburga'],
    description: 'My Blog ',
    image: {
      // Note: og:image is ALWAYS rendered as a plain rectangle by Google/Facebook/LinkedIn/X -
      // they generate their own thumbnail from this file, there's no "circular" option here;
      // that styling only ever applied to the on-page hero photo, which is unrelated.
      // Dedicated 1200x630 crop (the standard og:image ratio) generated from homepage/me2.jpg -
      // much lighter (~82KB vs ~720KB) and properly framed instead of shipping the full-size
      // portrait photo as-is.
      src: '/homepage/me2-social.jpg',
      alt: 'Ever Burga',
      width: 1200,
      height: 630
    },
    header: {
      position: 'right', // possible value are : | 'left' | 'center' | 'right'
      logo: {
        path: '/chiffonstack-isotype-negative.svg', // path of the logo
        pathDark: '/chiffonstack-isotype.svg', // path of the logo in dark mode, leave this empty if you want to use the same logo
        alt: '', // alt of the logo
        href: 'https://chiffonstack.kekeros.com' // url the logo links to
      }
    },
    footer: {
      credits: {
        enabled: false, // possible value are : true | false
        repository: 'https://github.com/4xeverburga' // our github repository
      },
      navigation: true, // possible value are : true | false
      alignment: 'center', // possible value are : 'none' | 'left' | 'center' | 'right'
      message: {
        es: 'Encuéntrame en',
        en: 'Find me here'
      } // string that will be displayed in the footer (leave empty or delete to disable)
    },
    socials: {
      github: '4xeverburga',
      linkedin: {
        icon: 'uil:linkedin',
        label: 'LinkedIn',
        href: 'https://www.linkedin.com/in/everburga'
      }
    },
    form: {
      successMessage: {
        es: 'Mensaje Enviado. Gracias',
        en: 'Message sent. Thank you!'
      }
    }
  }
})
