import { defineCollection, defineContentConfig, z } from '@nuxt/content'

export default defineContentConfig({
  collections: {
    content: defineCollection({
      type: 'page',
      source: '**/*.md',
      schema: z.object({
        layout: z.string().optional(),
        date: z.string().optional(),
        cover: z.string().optional(),
        canonical: z.string().optional(),
        author: z.object({
          name: z.string(),
          avatarUrl: z.string().optional(),
          link: z.string().optional()
        }).optional(),
        badges: z.array(z.object({
          bg: z.string(),
          text: z.string(),
          content: z.string()
        })).optional()
      })
    })
  }
})
