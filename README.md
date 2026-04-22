# Mi Blog

Mi fork de ```@nuxt-themes/alpine``` utilizado aquí es ```https://github.com/4xeverburga/nuxt-alpine-spanishplus```, pero  funciona solo con pnpm, asi que tienes 
que usar ```pnpm install``` y la suit de comandos de pnpm para generar el proyecto.

Si necesitas usar npm (como para cloudfare pages) el roundabout que uso es tomar el archivo generado por ```pnpm pack``` directamente: ```./nuxt-themes-alpine-1.6.6.tgz```.

El work TODO es encontrar la manera de configurar ```https://github.com/4xeverburga/nuxt-alpine-spanishplus``` para que funcione con npm.
Una alternativa es crear una rama /release en la que descomprimir el resultado de ```pnpm pack```, pero no es la solucion al problema raíz.

---

## Social Publishing

Posts a LinkedIn y X se generan como JSON y se publican vía [PostPeer](https://postpeer.dev).

### Setup

1. Copia `.env.example` a `.env` (o edita `.env` directamente):
   ```
   POSTPEER_API_KEY=<tu api key de postpeer>
   POSTPEER_LINKEDIN_ACCOUNT_ID=<id de la cuenta linkedin en postpeer>
   POSTPEER_X_ACCOUNT_ID=<id de la cuenta x en postpeer>
   BLOG_BASE_URL=https://everburga.dev   # opcional, default
   ```

2. Obtén los account IDs conectados:
   ```bash
   curl https://api.postpeer.dev/v1/connect/integrations \
     -H "x-access-key: $POSTPEER_API_KEY"
   ```

### Estructura de un post JSON

```json
{
  "content": "Texto del post...",
  "platforms": ["linkedin"],
  "images": ["/articles/2025/octubre/latenciaup.jpg"]
}
```

- `platforms`: `"linkedin"`, `"x"`, o ambos.
- `images`: rutas relativas a `public/` (sin el prefijo `/public`). Se convierten a URL completa usando `BLOG_BASE_URL`.

Los archivos van en `publish/linkedin/<slug>.json` o `publish/x/<slug>.json`.

### Publicar

```bash
# Preview sin enviar
./publish/publish.sh publish/linkedin/mi-post.json --dry-run

# Publicar inmediatamente
./publish/publish.sh publish/linkedin/mi-post.json

# Programar (hora local Lima, -05:00)
./publish/publish.sh publish/linkedin/mi-post.json \
  --schedule "2026-04-23T10:00:00-05:00" \
  --timezone "America/Lima"
```

El script muestra el payload completo y pide confirmación antes de enviar.

### Agentes

- **`@Article Writer`** — redacta y edita artículos en estilo narrativo español.
- **`@Post Writer`** — genera los JSON de posts a partir de un artículo; escribe los archivos solo tras confirmación.

Ver [AGENTS.md](./AGENTS.md) para el workflow completo.

