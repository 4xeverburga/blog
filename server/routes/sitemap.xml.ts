import { queryCollection } from '@nuxt/content/server'
import { defineEventHandler, setHeader } from 'h3'

const SITE_URL = process.env.SITE_URL || 'https://4verburga.kekeros.com'

export default defineEventHandler(async (event) => {
  const docs = await queryCollection(event, 'content').all()

  const urls = docs
    .filter(doc => doc.path && !doc.path.includes('/__'))
    .map((doc) => {
      const path = doc.path
      const lastmod = (doc.date as string) || new Date().toISOString()
      return `  <url>\n    <loc>${SITE_URL}${path}</loc>\n    <lastmod>${new Date(lastmod).toISOString()}</lastmod>\n  </url>`
    })
    .join('\n')

  const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>`

  setHeader(event, 'content-type', 'application/xml; charset=UTF-8')
  return xml
})
