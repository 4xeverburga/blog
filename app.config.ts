// https://github.com/nuxt-themes/alpine/blob/main/nuxt.schema.ts
export default defineAppConfig({
  alpine: {
    title: 'Blog - EverB',
    description: 'The minimalist blog theme',
    image: {
      src: '/social-card-preview.png',
      alt: 'An image showcasing my project.',
      width: 400,
      height: 300
    },
    header: {
      position: 'right', // possible value are : | 'left' | 'center' | 'right'
      logo: {
        path: '/banner.png', // path of the logo
        pathDark: '/banner.png', // path of the logo in dark mode, leave this empty if you want to use the same logo
        alt: '' // alt of the logo
      }
    },
    footer: {
      credits: {
        enabled: false, // possible value are : true | false
        repository: 'https://github.com/4xeverburga' // our github repository
      },
      navigation: true, // possible value are : true | false
      alignment: 'center', // possible value are : 'none' | 'left' | 'center' | 'right'
      message: 'Sígueme en' // string that will be displayed in the footer (leave empty or delete to disable)
    },
    socials: {
      github: '4xeverburga',
      linkedin: {
        icon: 'uil:linkedin',
        label: 'LinkedIn',
        href: 'https://www.linkedin.com/in/ever-alexis-burga-peralta-87ba5b160/'
      }
    },
    form: {
      successMessage: 'Mensaje Enviado. Gracias'
    }
  }
})
