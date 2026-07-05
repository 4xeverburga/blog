---
layout: article
# cover: pendiente — este artículo todavía no tiene imagen de portada propia bajo public/articles/2026/july/
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: Un agente que muestra una animación de pensamiento, carga de imágenes y más! ...
date: 2026-07-07T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: agentes, microsoft teams, m365 agents toolkit, azure bot service, sharepoint, rag engine, máquina de estados, chatbots, mesa de ayuda
---


agent toolkit dev flow.png 

-- Tomado de https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals

# De Idea a Ms Teams: Desplegando un Agente Con el Que Tu Organización Puede Interactuar

A la fecha existe una creciente cantidad de servicios y vías de entrada para desplegar un agente en Ms Teams. Puede ser a través de Copilot, Microsoft 365 o con los servicios de AI Foundry.
En el fondo todos ellos usan las APIs de Azure Bot Services. 

Si quieres máxima personalización, este tutorial te va a gustar. 

## Prerrequisitos.

Si tienes problemas con que tu administrador de Azure te otorgue permisos documentados en un artículo de un don nadie, este blog de Microsoft realiza pasos similares a los de estos artículos [1] https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals. 

- Rol de Application Developer en la suscripción de Azure donde estará asignado tu proyecto.
- Licencia de MS Teams Corporativa. Como alternativa existe un programa de prueba de Microsoft 365 Dev que puedes probar, pero son 90 días y de todas maneras necesitas usar una suscripción activa de Azure. 
Resulta redundante hacer todo el trabajo allí en lugar de aislar un grupo de usuarios en la consola de admin de 365 de tu organización.

## Contenido 
Lo que este tutorial cubre:

- Creación de la App en Azure Entra ID. Aquí se gestionan los permisos y es la cara visible de tu Agente para todo Microsoft en el mismo tenant.
- Configuración de Azure Bot services. Esta es la API de integración para la suite de MS 365.
- Integración con tu Agente en GCP, Azure, LangGraph self-hosted o lo que sea que hayas desarrollado. Aquí vemos cómo lo conectas con Azure Bot Services.
- Publicación en Teams: Reglas de exclusión de usuarios, íconos, logos y versionamiento.
- Detallitos de CX, D:

No vamos a ver la lógica del agente. Lo que te interesa, como a mí en su momento, es saber cómo lo despliego en mi suite corporativa. 


## Entra ID 

Azure a veces es una pesadilla. Veamos paso a paso. 

Primero, crea una app con un nombre y un sufijo 'dev' o 'prd'. Necesitarás hacer esta distinción para poder segregar los usuarios más adelante.

1.

<p align="center">
  <img src="/articles/2026/july/entra-id-tuto.png" alt="Ingresa al servicio de Entra ID" title="Ingresa al servicio">
  <em>Ingresa al servicio</em>
</p>

2.

<p align="center">
  <img src="/articles/2026/july/app-registration-add-new.png" alt="Registro de una nueva app" title="Dale a crear">
  <em>Dale a crear. Single tenant es suficiente para la mayoría de casos de uso.</em>
</p>

3.

<p align="center">
  <img src="/articles/2026/july/app-registration-panel.png" alt="Panel de registro de la app" title="Apunta la App Id">
  <em>Apunta la App Id.</em>
</p>

Si necesitas que tu agente interactúe con servicios de Microsoft, la sección de API Permissions será tu amiga. En caso tu Agente no se encuentre en el ecosistema de Azure, una solución rápida es crear un certificado en la sección de Certificates y Secrets. En ese caso te apuntas el Secret que generes.


## Azure Bot Services

Crea un Bot con la misma App Id que usaste para Entra Id. No estoy seguro de la razón de esto, pero cuando usaba la Id automática hubo problemas con la aparición del bot en la consola de Admin Microsoft 365.

azure bot services config panel.png
Aquí los dos elementos más importantes tienen flechas.

El campo de URL endpoint es el endpoint del middleware que construiras a continuación. 

La sección de 'prueba web' te permite probar que tu agente y tu middleware de integración efectivamente funcionan y responden correctamente.

## Integración

1. Esto es una versión simplificada de un adaptador que me funciona.

```python
import os
from dotenv import load_dotenv, find_dotenv
load_dotenv(find_dotenv(".prd.env"))

from botbuilder.integration.aiohttp import CloudAdapter, ConfigurationBotFrameworkAuthentication

from src.ext.http_adapter import HTTPAdapter
from src.ext.agent_engine_adapter import AgentEngineAdapter
from src.ext.feedback_adapter import DefaultFeedbackHandler
from src.ext.teams_incoming_adapter import BotInconmingEventsHandler
from src.app.bot_service.service import BotService
from src.ext.firestore_session_adapter import FirestoreAdapter
from src.app.session_watcher_service.service import SessionWatcher
from src.ext.feedback_adapter import BigQueryFeedbackRepository

import logging

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,  # Set to DEBUG, INFO, WARNING, ERROR, or CRITICAL
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

PORT = int(os.environ.get("PORT", "3978"))
APP_ID = os.environ.get("MICROSOFT_APP_ID", "")
APP_PASSWORD = os.environ.get("MICROSOFT_APP_PASSWORD", "")
APP_TYPE = os.environ.get("MICROSOFT_APP_TYPE", "")
APP_TENANTID = os.environ.get("MICROSOFT_APP_TENANT_ID", "")
MAX_IDLE_TIME = int(os.environ.get("APP_MAX_IDLE_TIME"))  # secs
ALERT_TIME = int(os.environ.get("APP_ALERT_TIME"))
BQ_DATASET_ID = os.environ.get("BIGQUERY_DATASET_ID")
PROJECT_ID= os.environ.get("PROJECT_ID")

print(f"Configuration loaded. App ID: {APP_ID}, Port: {PORT}")
logger.info(f"✓ App ID: {APP_ID}")
logger.info(f"✓ App Type: {APP_TYPE}")
logger.info(f"✓ Tenant ID: {APP_TENANTID}")
logger.info(f"✓ Password length: {len(APP_PASSWORD) if APP_PASSWORD else 0}")

if not APP_PASSWORD:
    logger.error("❌ MICROSOFT_APP_PASSWORD is EMPTY!")
if not APP_ID:
    logger.error("❌ MICROSOFT_APP_ID is EMPTY!")

class BotConfig:
    PORT = PORT
    APP_TYPE = APP_TYPE
    APP_ID = APP_ID
    APP_PASSWORD = APP_PASSWORD
    APP_TENANTID = APP_TENANTID

config = BotConfig()
# Cloud Adapter is a bot
BOT_CLOUD_ADAPTER = CloudAdapter(ConfigurationBotFrameworkAuthentication(config, logger=logger))


agent_backend = os.environ.get("AGENT_BACKEND", "cloud_run").strip().lower()
return_last_message_only = os.environ.get("AGENT_RETURN_LAST_MESSAGE_ONLY", "true").strip().lower() in ("1", "true", "yes", "on")
query_url = os.environ.get("AGENT_ENGINE_QUERY_URL")
if not query_url:
    raise ValueError("AGENT_ENGINE_QUERY_URL is required when AGENT_BACKEND=agent_engine_rest")

chatbot_adapter = AgentEngineAdapter(
    query_url=query_url,
    timeout_seconds=float(os.environ.get("AGENT_ENGINE_TIMEOUT_SECONDS", "60")),
    return_last_message_only=return_last_message_only,
    class_method=os.environ.get("AGENT_ENGINE_CLASS_METHOD", "async_stream_query"),
)
logger.info("Agent Engine REST adapter initialized as primary chatbot adapter")

data_store = None
firestore_db = os.environ.get("FIRESTORE_DB")

data_store = FirestoreAdapter(
    project_id=PROJECT_ID,
    database_id=firestore_db,
)
logger.info("FirestoreAdapter initialized for session storage")

feedback_repository = BigQueryFeedbackRepository(
    project_id=PROJECT_ID,
    dataset_id=BQ_DATASET_ID,
    table_id="feedback_table"
)


feedback_handler = DefaultFeedbackHandler(feedback_repository)

bot_service = BotService(
    chatbot_adapter=chatbot_adapter,
    data_store=data_store,
    fallback_adapter=None,
    bot_adapter=BOT_CLOUD_ADAPTER,
    app_id=APP_ID,
    feedback_handler=feedback_handler,
    alert_idle_seconds=ALERT_TIME,
    close_idle_seconds=MAX_IDLE_TIME,
)

incoming_events_handler = BotInconmingEventsHandler(APP_ID, APP_PASSWORD, bot_service)

http_adapter = HTTPAdapter(BOT_CLOUD_ADAPTER, incoming_events_handler)
app = http_adapter.get_app()

# Start session watcher if data store is available
if data_store is not None:
    try:
        watcher = SessionWatcher(data_store, bot_service, alert_idle_seconds=ALERT_TIME,
                                 close_idle_seconds=MAX_IDLE_TIME)
        watcher.start()
    except Exception as e:
        print(f"Warning: could not start session watcher: {e}")

if __name__ == "__main__":
    from aiohttp import web
    try:
        web.run_app(app, host="0.0.0.0", port=PORT)
    except Exception as error:
        raise error
```

Puedes revisar más implementaciones en el Quickstart de Microsoft [2].
En mi opinión la página está abandonada, así que no asumas que funcionará tal cual.



2. Antes de dar por terminada tu integración no olvides recopilar estas variables correctamente. Son necesarias para desencriptar la comunicación de Azure en el entorno productivo. 

```bash
MicrosoftAppType= SingleTenant
MicrosoftAppId= # client id you just used for entra id and bot services
MicrosoftAppPassword= # client secret
MicrosoftAppTenantId=
```

El client secret solo es necesario para integraciones fuera del ecosistema de Azure. Es preferible usar OAuth2 o un método libre de secretos.

### Y también tienes un bonito playground para que pruebes tu agente incluso antes de tenerlo en Microsoft 365

Para que no falle debes dejar vacías las variables que vimos en el paso #2. 
Si no lo haces el playground no podrá desencriptar las comunicaciones. Y en mi experiencia ha sido complicado debuggear cuando falla.

<p align="center">
  <img src="/articles/2026/july/microsoft-365-playground.png" alt="Playground de Microsoft 365" title="Playground de Microsoft 365">
  <em>Playground de Microsoft 365</em>
</p>


## Publicación en Teams

### Carga el Archivo Exportado de 365 Toolkit

El proyecto que has configurado previamente genera un bundle. Lo puedes personalizar con el logo que quieres que se muestre. 
Una versión a color y otra simplificada para las sidebards e íconos pequeños. 

upload app to teams request.png

### Contacta con Tu Administrador de MS 365

Dirígelo a estos enlaces:
- https://admin.teams.microsoft.com
- https://admin.microsoft.com

No he podido cargarte pantallas de cómo se ve la consola de administrador y exactamente qué pasos debe tomar tu administrador.
Pero hazle saber que puede crear lsitas de acceso para la aplicación. 

En específico debería tener una lista de acceso para la aplicación dev, que solo está abierta para unos pocos usuarios testers y desarrollardores.
Y para la aplicación productiva se puede ir planteado una estretegia disinta.

## CX!

### ¿Te interesa usar formularios con tu agente?

Las tarjetas adaptativas de toda la vida de Microsoft [3]. Las puedes usar en tu middleware.
¿Personalización extra? Es el mismo estándar que Power Automate, con el que podrías estar más familiarizado.

### ¿Quieres que ... el ... bot ... escriba? ...

```python
# Typying activity: ...
await turn_context.send_activity(Activity(type=ActivityTypes.typing))
# Delegate to application service
response = await self.bot_service.handle_message(text, turn_context)
await turn_context.send_activity(response)
```

Con enviar esa actividad es suficiente en lo que tu motor del agente responde.

## Extra!
Esto es lo que pude recopilar de las comunicación que envían los servidores de Azure Bot Services. Te podría ser útil si quieres entender qué tanto puedes obtener de información útil a través del middleware.

```http
POST /api/messages HTTP/1.1
Host: localhost:3978
User-Agent: BF-DirectLine (Microsoft-BotFramework/3.2 +https://botframework.com/ua)
Content-Length: 719
Accept: */*
Authorization: Bearer <REDACTED_JWT>
Channelid: webchat
Content-Type: application/json; charset=utf-8
Request-Id: |<REDACTED_REQUEST_ID>.<REDACTED_SPAN_ID>.
Traceparent: 00-<REDACTED_TRACE_ID>-<REDACTED_SPAN_ID>-00
X-Forwarded-For: xxx.xxx.xxx.xxx
X-Forwarded-Host: xxxx-xxx-xxx-xx.ngrok-free.app
X-Forwarded-Proto: https
X-Ms-Conversation-Id: <REDACTED_CONVERSATION_ID>
Accept-Encoding: gzip

{"type":"typing","id":"<REDACTED_CONVERSATION_ID>|<REDACTED_ACTIVITY_ID>","timestamp":"2026-03-02T17:44:41.6782359Z","localTimestamp":"2026-03-02T12:44:41.391-05:00","localTimezone":"America/Lima","serviceUrl":"https://webchat.botframework.com/","channelId":"webchat","from":{"id":"00000000-0000-0000-0000-000000000000","name":""},"conversation":{"id":"<REDACTED_CONVERSATION_ID>"},"recipient":{"id":"agente-mesa-de-ayuda-dev@<REDACTED_TOKEN>","name":"agente-mesa-de-ayuda-dev"},"locale":"en-US","entities":[{"type":"ClientCapabilities","requiresBotState":true,"supportsListening":true,"supportsTts":true}],"channelData":{"clientActivityID":"<REDACTED_CLIENT_ACTIVITY_ID>"}}




POST /api/messages HTTP/1.1
Host: localhost:3978
User-Agent: BF-DirectLine (Microsoft-BotFramework/3.2 +https://botframework.com/ua)
Content-Length: 662
Accept: */*
Authorization: Bearer <REDACTED_JWT>
Channelid: webchat
Content-Type: application/json; charset=utf-8
Request-Id: |<REDACTED_REQUEST_ID>.<REDACTED_SPAN_ID>.
Traceparent: 00-<REDACTED_TRACE_ID>-<REDACTED_SPAN_ID>-00
X-Forwarded-For: xxx.xxx.xxx.xxx
X-Forwarded-Host: xxxx-xxx-xxx-xx.ngrok-free.app
X-Forwarded-Proto: https
X-Ms-Conversation-Id: <REDACTED_CONVERSATION_ID>
Accept-Encoding: gzip

{"type":"conversationUpdate","id":"<REDACTED_ACTIVITY_ID>","timestamp":"2026-03-02T17:44:41.0353977Z","serviceUrl":"https://webchat.botframework.com/","channelId":"webchat","from":{"id":"00000000-0000-0000-0000-000000000000"},"conversation":{"id":"<REDACTED_CONVERSATION_ID>"},"recipient":{"id":"agente-mesa-de-ayuda-dev@<REDACTED_TOKEN>","name":"agente-mesa-de-ayuda-dev"},"membersAdded":[{"id":"agente-mesa-de-ayuda-dev@<REDACTED_TOKEN>","name":"agente-mesa-de-ayuda-dev"},{"id":"00000000-0000-0000-0000-000000000000"}]}

POST /api/messages HTTP/1.1
Host: localhost:3978
User-Agent: BF-DirectLine (Microsoft-BotFramework/3.2 +https://botframework.com/ua)
Content-Length: 679
Accept: */*
Authorization: Bearer <REDACTED_JWT>
Channelid: webchat
Content-Type: application/json; charset=utf-8
Request-Id: |<REDACTED_REQUEST_ID>.<REDACTED_SPAN_ID>.
Traceparent: 00-<REDACTED_TRACE_ID>-<REDACTED_SPAN_ID>-00
X-Forwarded-For: xxx.xxx.xxx.xxx
X-Forwarded-Host: xxxx-xxx-xxx-xx.ngrok-free.app
X-Forwarded-Proto: https
X-Ms-Conversation-Id: <REDACTED_CONVERSATION_ID>
Accept-Encoding: gzip

{"type":"message","id":"<REDACTED_CONVERSATION_ID>|<REDACTED_ACTIVITY_ID>","timestamp":"2026-03-02T17:44:42.8691754Z","localTimestamp":"2026-03-02T12:44:42.728-05:00","localTimezone":"America/Lima","serviceUrl":"https://webchat.botframework.com/","channelId":"webchat","from":{"id":"00000000-0000-0000-0000-000000000000","name":""},"conversation":{"id":"<REDACTED_CONVERSATION_ID>"},"recipient":{"id":"agente-mesa-de-ayuda-dev@<REDACTED_TOKEN>","name":"agente-mesa-de-ayuda-dev"},"textFormat":"plain","locale":"en-US","text":"Hola","attachments":[],"channelData":{"attachmentSizes":[],"clientActivityID":"<REDACTED_CLIENT_ACTIVITY_ID>"}}
```


## Referencias

[1] Microsoft. Agents Toolkit fundamentals. Available: https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/agents-toolkit-fundamentals
[2] Microsoft. Microsoft 365 Agents SDK Quickstart (Python). Available: https://learn.microsoft.com/en-us/microsoft-365/agents-sdk/quickstart?pivots=python
[3] Microsoft. Adaptive Cards. Available: https://adaptivecards.microsoft.com/