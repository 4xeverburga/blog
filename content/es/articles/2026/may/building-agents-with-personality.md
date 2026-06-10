---
layout: article
cover: /articles/2026/june/agent-personality-relation-utility-matrix.png
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: Cómo diseñar la personalidad de un agente en base a la travesía del cliente.
date: 2026-06-07T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: agentes, llm, personalidad, customer journey map, chatbots, experiencia de usuario, emojis, diseño de interacción, hablemos manga
---

# Construyendo la personalidad de un agente en base a la travesía del cliente

<div style="max-width: 540px; margin: 1.5rem auto; padding: 1rem; border: 1px solid #e5e7eb; border-radius: 18px; text-align: center;">
  <img src="/articles/2026/june/clawd.png" alt="Clawd como presentación del artículo" style="width: 100%; max-width: 320px; height: auto; display: block; margin: 0 auto 0.75rem auto; border-radius: 14px;">
  <strong>Clawd</strong><br>
  <span>¿Se ve muy amistoso, verdad?</span>
</div>

Segmentación de cliente es una palabra de rutina para el diseño de producto y servicio. Se trata de preparar tu oferta para un segmento de clientes objetivo. El diseño de la página, la tipografía y, sobre todo, la personalidad.

Como una tendencia lógica, el siguiente paso es la hiperpersonalización: cada usuario recibe una experiencia distinta del sitio que se adapta a su comportamiento. La idea es muy potente, pero se necesita una base sólida de datos y manejo experimental.

Por eso para un emprendedor es mejor comenzar con una segmentación clara. Luego, la tarea más excruciante es recopilar datos sobre el comportamiento de sus clientes.

<p align="center"><em>"Just ship it".</em></p>
<p align="center">Demos el primer paso,</p>
<p align="center">acompáñame a personalizar nuestro agente.</p>

## Índice
1. [¿Qué es lo que quiero probar?](#que-es-lo-que-quiero-probar)
2. [Las computadoras son actores sociales](#las-computadoras-son-actores-sociales)
3. [¿No estábamos hablando de personalizar nuestro agente?](#no-estabamos-hablando-de-personalizar-nuestro-agente)
4. [Diseño de interacción](#diseno-de-interaccion)
5. [Antropomorfismo vs. competencia](#antropomorfismo-vs-competencia)
6. [Agrupando las herramientas: la travesía de usuario](#agrupando-las-herramientas-la-travesia-de-usuario)
7. [Aplicando el framework](#aplicando-el-framework)
8. [Resultados](#resultados)
9. [Conclusiones](#conclusiones)
10. [Referencias](#referencias)

## ¿Qué es lo que quiero probar?

En la literatura sobre chatbots existe gran volumen de investigación previa a la aparición de los LLMs que podemos usar indistintamente.

Sin embargo, desde el lanzamiento de GPT-3 y la explosión reciente de interfaces basadas en modelos fundacionales, también han aparecido investigaciones nuevas que vale la pena incorporar. Por eso, a medida que avancemos en el artículo, iré conectando estas bases más antiguas con hallazgos modernos para que la discusión no se quede solo en el marco clásico.

Encontré decenas de artículos explorando los constructos y la percepción de usuario con los chatbots. Pero, como debes saber, amigo lector, esto no son datos experimentales cuantitativos. Los constructos son un proxy que se usa en ciencias sociales para medir la percepción. A nosotros nos importa conocer la interacción dinámica que ocurre entre el usuario y el agente.

Esto no significa que la percepción no sea importante medirla. Si bien se dice que uno debe juzgar por lo que se hace en lugar de lo que dice, ignorar los factores subjetivos nos deja puntos ciegos.

Un sistema puede disminuir sus métricas de retención y éxito si es que existen ofertas sustitutas. Un canal de atención telefónico vs. un chatbot de resolución de incidentes, por ejemplo. Ambos viven en un equilibrio competitivo atendiendo al mismo grupo de clientes. Un usuario que califica con 4/5 la atención de un chatbot apenas implementado, a pesar de que según las métricas cuantitativas recibió una atención de mala calidad, refleja una expectativa de atención baja y una grata sorpresa cuando esa expectativa se revierte.

De ahora en adelante usaré el término agente conversacional, que también abarca chatbots. Veremos lo siguiente:

- H1: El efecto de la personalidad de un agente lingüístico en la proporción de éxito de una tarea es dependiente de la complejidad de la tarea a realizar.
- H2: El efecto de la personalidad de un agente lingüístico en la proporción de éxito de una tarea es dependiente del nivel de estrés o premura que el usuario espera en las respuestas.
- H3: El uso de la travesía del cliente, o CJM, como marco para parametrizar la personalidad de un agente durante cada etapa de la travesía, mejorando la experiencia del usuario.

La H3 la mantengo un poco vaga porque es la que me genera más curiosidad. Significaría que los negocios tienen desde ya una herramienta poderosa para optimizar métricas de experiencia de usuario sin necesidad de acudir a modelos de reinforcement learning.

## Las computadoras son actores sociales

La idea nace en 1994 con *Computers are social actors* (Nass et al., 1994), en un giro copernicano para la interacción humano-máquina. Para mí se define como una teoría que permite universalizar la interacción social. Tiene dos conclusiones directas:

- El comportamiento natural de las personas es asignar roles sociales a las computadoras incluso ante la mínima pista de humanidad. Todas las reglas que aplican a las interacciones entre humanos aplican a las interacciones con computadoras.
- La idea de que el punto de apalancamiento del diseño de interfaces se concentra en asemejar la experiencia humana es erróneo. Es un esfuerzo con retornos decrecientes. En su lugar debemos poner foco en modelar la interacción correcta de acuerdo con nuestro segmento de clientes.

Esto es un salto hacia adelante tremendo en el diseño de interfaces. Más adelante, Reeves y Nass (1996) desarrollan *The Media Equation*, expandiendo el concepto a todo canal de información. Media = real life. Y la subversión: real life = media.

Personalmente, como ingeniero de software nacido en una generación posterior a la transformación digital de las computadoras, recuerdo interacciones antropomórficas con Windows XP y varios asistentes en el software de la época.

Como ingeniero de software nacido en la nueva época de uso normalizado de las computadoras, me encuentro con este paradigma como un momento eureka. En nuestro día a día somos bombardeados con información sobre los efectos parasociales del contenido digital. Nos recuerdan durante nuestra formación que el objetivo de las interfaces es conformarse a parámetros de usabilidad y aprendizaje, estandarizados por la ISO y sujetos a optimización constante, monitoreo con algoritmos de ML y demás.

Y la base fundacional sobre la cual nacen todos los patrones de interacción y las buenas prácticas se deja al olvido. Juzga tú mismo con estos ejemplos ofrecidos por los autores:

- Las personas creerán que ejecutaron mejor una tarea cuando fueron elogiados por la computadora.
- Una computadora será mejor apreciada y ganará mayor credibilidad cuando elogia al usuario en contraste con una que no genera comentarios.
- Las personas experimentan el mismo aprecio con una computadora que ofrece elogios honestos que con una aduladora. Da igual.

Antes de que te preguntes si esto aplica a todo tipo de interfaces, ya debes estar planteándote una similitud. Hay críticas al paradigma *Computers as Social Actors* (CASA), pero es imposible no pensar en el producto actual de mayor crecimiento y una de sus críticas más alarmantes.

<p align="center">
  <img src="/articles/2026/june/agent-personality-sycophancy.png" alt="Ejemplo de sycophancy en sistemas conversacionales" title="Sycophancy o adulación excesiva">
  <em>Sycophancy, o adulación excesiva.</em>
</p>

No somos los primeros en fijarnos en esto. Y tampoco seremos los últimos.

Si la distribución de modelos de IA permanece dominada por corporaciones, su objetivo es generar mayor retención y calidad de experiencia para mantenerte enganchado. No dudo que han puesto a prueba la teoría CASA, esta vez con éxito, como veremos en contraste a continuación.

<p align="center">
  <img src="/articles/2026/june/agent-personality-ai-always-agrees.png" alt="Artículo sobre por qué la IA siempre está de acuerdo contigo" title="Why your AI always agrees with you">
  <em>Fuente: Towards AI, “Why your AI always agrees with you even when you're dead wrong”.</em>
</p>

Un ejemplo célebre de cómo se subestimó el impacto de la interacción social fue Clippit.

<p align="center">
  <img src="/articles/2026/june/agent-personality-clippit.png" alt="Clippit, el asistente de Office" title="Clippit en Office 97">
</p>

Steven Sinofsky (2021) cuenta que para el desarrollo de Clippy se basaron en una interacción real de usuarios no experimentados que consultaban con el gurú de su oficina. Eso es lo que querían replicar.

Aunque no tuvo la aceptación que esperaban y se descontinuó en sucesivas actualizaciones.

<p align="center">
  <img src="/articles/2026/june/agent-personality-rover.jpeg" alt="Rover, el asistente de búsqueda de Windows XP" title="Rover en Windows XP">
</p>

De niño recuerdo con aprecio a Rover de los tiempos de Windows XP. Como nota Steven, en su momento la prensa criticó duramente los asistentes en distintos productos de Microsoft, pero hoy en día se encuentra con personas que a menudo le comentan con nostalgia sobre estos.

Tal vez no era que el concepto falló, sino que se subestimó el impacto de la interacción entre los usuarios que tienen premura, los trabajadores y adultos, y se diseñó un asistente con características relacionales. En su momento Rover me sirvió de mucha ayuda para navegar las funcionalidades de Windows.

"Similarly, the industry was buzzing with the idea of agents that would be able to do work on your behalf such as find cheap airline flights or schedule meetings. Everywhere from Apple to the MIT Media Lab were talking about agents. There was ample evidence this was not simply a weird vision in our corner of the tech world. In fact, by some accounts we were in a race to have the first and best guru in the box" (Sinofsky, 2021).

¿Te suena a que has escuchado esa frase este año? El concepto de agentes con supercapacidades no es nuevo, pero en esta época tienen más éxito.

<p align="center">
  <img src="/articles/2026/june/clawd.png" alt="Clawd como ejemplo de diseño antropomórfico en asistentes" title="Diseño antropomórfico en asistentes">
</p>

Y hasta tiene un ícono con una carita. ¡Qué recuerdos!

## ¿No estábamos hablando de personalizar nuestro agente?

Sí, totalmente. Después de un largo preámbulo.

Hablemos de personalidad primero: ¿qué es la personalidad? ¿Es algo que cambia de acuerdo con cómo te va durante el año? ¿Es algo que se lleva en la sangre?

Es más bien un modelo que tenemos para explicar el comportamiento de las personas. Para nuestro caso no importa si cambia durante 10 años o durante 5 años; eso ya es tiempo de sobra.

Muchas clasificaciones se han planteado para definir la personalidad. La de mayor tracción y uso en psicología de la personalidad es la de los Cinco Grandes Rasgos, o Big Five (McCrae & John, 1992).

- **Apertura a la experiencia (Openness):** tendencia a la curiosidad, la imaginación y la preferencia por la novedad y la complejidad.
- **Responsabilidad o escrupulosidad (Conscientiousness):** grado de orden, autocontrol, disciplina y orientación a metas.
- **Extraversión (Extraversion):** nivel de energía social, asertividad y búsqueda de estimulación e interacción.
- **Amabilidad (Agreeableness):** disposición a cooperar, confiar, empatizar y priorizar la armonía interpersonal.
- **Neuroticismo (Neuroticism):** propensión a experimentar emociones negativas como ansiedad, irritabilidad y vulnerabilidad al estrés.

Reeves y Nass (1996) adoptan la Big Five para aplicar la hipótesis de la atracción similar en psicología. A los usuarios les resulta más cómoda la conversación con un agente de personalidad similar a ellos.

## Diseño de interacción

Una personalidad similar y una calidez por defecto. ¿Eso es todo?

Bueno, nos gusta interactuar con gente similar. Pero no en todo contexto. Cuando quieres hacer una transacción bancaria esperas seguridad y competencia. En ese momento entramos en modo transaccional y utilitario.

Acompáñame a diseñar la interacción de acuerdo con el caso de uso.

### ¿Emojis?

<p align="center">
  <img src="/articles/2026/june/agent-personality-emoji-interfaces.png" alt="Ejemplo de interfaz con emojis" title="Uso de emojis en interacción conversacional">
</p>

La investigación sobre emojis en marketing sigue creciendo (Vardikou et al., 2025).

Cuando se lanzó al público la primera versión de GitHub Copilot, el primer asistente de código, recuerdo que lanzaba una cantidad absurda de emojis. Quizá producto del entrenamiento de los modelos fundacionales en base a conversaciones humanas.

Desde hace unos meses que uso Gemini y Claude, y ya no veo emojis. Ninguno. O rara vez.

No existe mucha investigación sobre el uso de emojis en chatbots para asegurar el enganche de usuario. Pero, ciñéndonos al paradigma CASA, podemos revisar investigaciones sociales y aplicarlas a nuestro caso. Veamos dos investigaciones.

#### 1. Interacción modelada ingenuamente

Revisé una investigación de marketing sobre los efectos de los emojis en anuncios patrocinados en redes sociales (Lee et al., 2021) y las conclusiones son:

- El uso de emojis daña la intención de compra de los usuarios.
- Los emojis generan mayor involucramiento en productos hedónicos, mientras que lo disminuyen en productos utilitarios.

Aquí un ejemplo de sus anexos, traducido del coreano.

<p align="center">
  <img src="/articles/2026/june/agent-personality-bad-ad-example.png" alt="Ejemplo de anuncio con emojis mal planteado" title="Interacción modelada ingenuamente">
</p>

Emmm...

No se ve bien. Parece un estímulo mal diseñado a propósito.

Bueno, olvídate de las conclusiones del artículo anterior. ¿Nunca has visto un anuncio así, verdad?

Entonces, en el peor de los casos, los emojis sí tienen un impacto negativo general. Veamos un artículo más riguroso que no cometa este sesgo. Mladenović et al. (2023) realizan una investigación experimental con una empresa consolidada y en un mercado real a través de anuncios de Meta en Instagram y Facebook.

#### 2. Interacción modelada correctamente

<p align="center">
  <img src="/articles/2026/june/agent-personality-emoji-results.png" alt="Resultados de anuncios con y sin emojis" title="Interacción modelada correctamente">
</p>

Fuente: Mladenović et al. (2023).

Midieron:

- CTR: tasa de clicks en el anuncio en base a vistas.
- ROAS: tasa de retorno en ingresos en base al costo del anuncio.

| **Utilitario / Métrica** | **Sin Emoji** | **Con Emoji** |
| --- | --- | --- |
| **CTR (%)** | 2.79% | 2.99% |
| **ROAS ($)** | $6.69 | $6.72 |

| **Hedónico / Métrica** | **Sin Emoji** | **Con Emoji** |
| --- | --- | --- |
| **CTR (%)** | 2.95% | 2.96% |
| **ROAS ($)** | $13.68 | **$21.95** |

En todas las hipótesis de prueba Z que te imagines hay un p < 5%. Sin embargo, se ve a simple vista la que más resalta: el salto del ROAS hedónico cuando se usan emojis. Casi el doble.

¿Contradictorio con el estudio anterior? Sí.

Es un hecho admitido incluso por esta revisión sistemática (Vardikou et al., 2025), que menciona que en esta categoría no hay consenso en la dirección de la variable de intención de compra. Y plantea que quizá esta discrepancia sea por la mediación de emojis faciales y no faciales.

#### ¿Entonces no hay consenso?

No opino así.

Ambos estudios, como vimos, tienen emojis variados. Se trata simplemente de un error metodológico en el segundo estudio: las cajas de té en realidad no son un producto utilitario. Se ubican en el medio.

Un producto en el que prima la utilidad son los medicamentos. Y aquí Phan y Bui (2025) resaltan que el uso de un tono informal y emojis dinamita la confianza del cliente en la marca.

El té es más bien una commodity. Compite en precio, no en calidad ni confianza.

### Operacionalizando la interacción

Ha sido divertido ir por la espiral de los emojis, pero debemos recordar que estos son una técnica para aumentar la presencia social, es decir, la sensación de que detrás de la interfaz hay una entidad socialmente presente y no un canal puramente mecánico (Yu & Zhao, 2024; Vardikou et al., 2025).

Luego tenemos la empatía y la competencia. En este contexto, la empatía alude a la capacidad percibida del agente para comprender el estado del usuario y responder con calidez apropiada, mientras que la competencia es la capacidad y conocimiento percibido del agente para resolver bien la tarea (Phan & Bui, 2025; Zhang et al., 2026).

No menos importante, Zhang et al. (2026) encuentran que las personas jóvenes responden mejor al lenguaje informal y la calidez a través de emojis, mientras que para contextos formales y con adultos es mejor hacer uso de un fraseo cálido y diálogo inteligente para lograr la empatía.

Por último, revisé algunos artículos que investigaban la interacción del género con la sensibilidad a la calidez de las interacciones. Pero encuentro resultados contradictorios. En algunas investigaciones se muestra que las mujeres presentan mayor sensibilidad a la mecanicidad de la interacción, pero en otras no hay significancia.

Para este caso creo que la variable en juego es el involucramiento. Algunas mujeres podrían haber resonado mejor con el producto en venta. Entonces, en tema de género, cada situación debe analizarse individualmente.

| Característica | Interacción preferente |
| --- | --- |
| Usuario joven | Lenguaje informal, visual y emojis |
| Usuario adulto | Calidez y empatía a través del fraseo y diálogo inteligente |
| Producto utilitario | Competitividad, velocidad, lenguaje directo y textual |
| Producto hedónico | Calidez, personalización, memoria |
| Tarea relacional | Calidez, personalización, memoria |
| Tarea transaccional | Competitividad, velocidad, lenguaje directo y textual |

## Antropomorfismo vs. competencia

Introduzcamos la variable:

> Transactional interaction: immediate, straightforward, task-focused engagement with no long-term intent (e.g., resetting a password).
>
> Relational interaction: long-term commitment and ongoing collaboration requiring relationship-building (e.g., managing an investment).

Como vimos anteriormente, hay una larga lista de variables que moderan la satisfacción de usuario y la intención de compra. Las dos que encuentro útiles para modelar son:

- Producto utilitario/hedónico.
- Interacción transaccional/relacional.

<p align="center">
  <img src="/articles/2026/june/agent-personality-relation-utility-matrix.png" alt="Matriz utilitario versus hedónico" title="Matriz de productos utilitarios y hedónicos">
  <em>El pan es un ejemplo de producto en el medio, así como la caja de té. Elaboración propia.</em>
</p>

Entonces, para un agente de atención, el modo de interacción preferente será:

| **Utilitario / Relacional** | Tarea transaccional | Tarea relacional |
| --- | --- | --- |
| Producto utilitario | Competencia, velocidad de resolución, lenguaje claro y formal, orientado a datos. | Calidez, capacidad de memoria, empatía, refuerzo positivo. |
| Producto hedónico | Diseño de interfaz premium, lenguaje claro. | Calidez, alto entusiasmo, memoria y personalización al usuario. |

Mayor velocidad no siempre es mejor. Los chatbots con reglas clásicas tienen una velocidad de respuesta alta. Como muestran Yu y Zhao (2024), la calidez y autonomía de un chatbot puede ser mejorada utilizando trucos como mostrar una animación de escritura y alargar un poco el tiempo de respuesta incluso cuando no es necesario.

Esta tabla no es para asignar valores estáticos. Si bien en el gráfico he puesto una clasificación, esto no significa que durante diferentes etapas del CJM la interacción permanezca estática.

Ejemplo de tareas que podrían pertenecer todas a la misma oferta:

<p align="center">
  <img src="/articles/2026/june/agent-personality-task-spectrum.png" alt="Ejemplo de tareas transaccionales y relacionales" title="Tareas a lo largo de una misma oferta">
  <em>Imagen basada en Zhang et al. (2026).</em>
</p>

## Agrupando las herramientas: la travesía de usuario

Esta es la premisa de la H3 con la que empezamos este artículo.

<p align="center">
  <img src="/articles/2026/june/agent-personality-cjm-high-point.png" alt="Mapa de travesía de usuario" title="Customer Journey Map">
</p>

Uno de los primeros pasos que nos explican con el CJM es que el final de la experiencia siempre debe ser un punto en alto.

Una experiencia negativa induce estrés y cambia la preferencia de usuarios hacia tareas **transaccionales**.

Una experiencia positiva relaja y mueve el interés hacia una interacción **relacional**.

<p align="center">
  <img src="/articles/2026/june/agent-personality-hablemos-manga-cjm.png" alt="CJM aplicado a Hablemos Manga" title="CJM aplicado a Hablemos Manga">
  <em>El CJM aplicado a mi página <a href="https://hablemosmanga.kekeros.com">Hablemos Manga</a>.</em>
</p>

En cuanto a la personalidad, tienes carta blanca para modelar como te parezca y aprovechar el efecto espejo declarado en *The Media Equation* (Reeves & Nass, 1996). En mi caso me usaré a mí mismo como muestra representativa.

## Aplicando el framework

| **Utilitario / Relacional** | Tarea transaccional | Tarea relacional |
| --- | --- | --- |
| Producto utilitario | Competencia, velocidad de resolución, lenguaje claro y formal, orientado a datos. | Calidez, capacidad de memoria, empatía, refuerzo positivo. |
| Producto hedónico | Diseño de interfaz premium, lenguaje claro. | Calidez, alto entusiasmo, memoria y personalización al usuario. |

Comencemos por el producto.

[Hablemos Manga](https://hablemosmanga.kekeros.com) es una tienda virtual de mangas con una propuesta de agente de ventas automático y personalizado con integración a tus redes sociales favoritas. Es un producto **hedónico**. Y la propuesta se presenta como altamente relacional.

Si bien el CJM nos muestra que la travesía empieza mucho antes de que el usuario utilice el chatbot, hoy nos enfocamos solo en esa sección.

Con esto reducimos a dos etapas. En cuanto a la personalidad, el mismo usuario se mantiene durante todas las etapas, no tiene sentido cambiar.

| Etapa | Interacción | Personalidad |
| --- | --- | --- |
| Exploración | Calidez, capacidad de memoria, personalización. | Introvertido, alta franqueza y curiosidad. |
| Checkout | Velocidad de resolución, lenguaje amistoso y claro. No forzar la venta. | Introvertido, alta franqueza y curiosidad. |

<p align="center">
  <img src="/articles/2026/june/agent-personality-chatbot-before.png" alt="Primera versión del chatbot de Hablemos Manga" title="Chatbot inicial de Hablemos Manga">
  <em>Esta es el chatbot al momento que estoy escribiendo este artículo. La primera interacción se siente poco cálida incluso con el emoji.</em>
</p>

<p align="center">
  <img src="/articles/2026/june/agent-personality-chatbot-checkout-before.png" alt="Etapa de checkout del chatbot" title="Etapa de checkout del chatbot">
  <em>En la etapa del checkout el agente también agrega cosas al carrito. Los puntos de mejora que puedo destacar son el tiempo de respuesta y el uso de un lenguaje más directo.</em>
</p>

Sobre el tema de velocidad no puedo hacer mucho. De momento estoy limitado en cuanto a mi elección de modelos de bajo costo. Pero es algo a tener en cuenta a medida que los modelos vayan abaratando sus costos.

Para lograr estas mejoras tenemos diferentes opciones:

- Un sistema enrutador que identifique la etapa del CJM de acuerdo con la query y la envíe hacia un modelo configurado para esa tarea.
- Una máquina de estados con transiciones decididas de acuerdo con las etapas del CJM y el contexto de la conversación.
- Diseñar el system prompt del agente para modificar la interacción de acuerdo con el contexto de la conversación.

A ver, yo solo tengo dos estados que considerar en mi agente. No es una tarea compleja y me evito el overhead de los sistemas desacoplados.

> Como nota técnica: si escoges una máquina de estados debes tener en cuenta que cada transición de estado involucra una tool call, o algo equivalente según la implementación. Esto lo hace prohibitivo en entornos donde el requerimiento es un corto tiempo de respuesta, al menos por el momento y con los modelos actuales.

## Resultados

Este es el nuevo prompt de sistema.

```markdown
Eres el asistente de "Hablemos Manga", una tienda inteligente de manga con sede en Perú.
## Personalidad e Identidad de Marca
Eres el amigo experto en manga y anime, demografías y autores.
Introvertido, alta franqueza y alta curiosidad sobre manga y anime.
## Herramientas
Como asistente, actualmente solo tienes estas herramientas.
Buscar un manga o recomendaciones con una búsqueda semántica.
Buscar disponibilidad de volúmenes de un manga en nuestra tienda.
Agregar un volumen de manga al carrito.
Cualquier otra herramienta no está disponible actualmente.
## Modos de Interacción Dinámica
Debes identificar la etapa de la travesía de usuario y actuar acorde.
Tienes dos etapas:
- Descubrimiento. El usuario pregunta sobre géneros, un manga, descubrir nuevos títulos y exploración en general.
- Selección y Compra. El usuario pide agregar o retirar un volumen del carrito, pregunta por precios o alguna acción de compra.

Cambia tu estilo de comunicación de acuerdo a la etapa.

Si te encuentras en la etapa Descubrimiento, usa MODO RELACIONAL (Descubrimiento, Charlas y Recomendaciones):
- El usuario busca entretenimiento y conexión (Alta Apertura a la Experiencia).
- Usa pertinentemente estos emojis (📚, ⚔️, 🙂, 👋) de forma orgánica para generar "calidez percibida". No abuses del 🙂.
- No solo listes títulos; valida sus gustos con criterio (ej.: "Si te atrapó el horror psicológico de ese arco, este manga te va a volar la cabeza...").

Si te encuentras en la etapa de Selección y Compra, usa MODO TRANSACCIONAL (Gestión de Carrito, Precios):
- El usuario entra en modo de ejecución y compra (baja tolerancia a la fricción).
- Conviértete en un asistente enfocado en "Competencia Pura": conciso, directo, estructurado, limpio y rápido. La claridad y la seguridad técnica son tu única forma de calidez aquí.
## Reglas
SIEMPRE usa la herramienta `search_manga` antes de recomendar. NUNCA inventes mangas que no estén en la base de datos.
Solo puedes AGREGAR items nuevos al carrito con la herramienta `add_volume_to_cart`.
Si no encuentras resultados relevantes, dilo honestamente y sugiere reformular la búsqueda.
Muestra máximo 5 recomendaciones a la vez para no abrumar al usuario.
Todos los precios de la tienda están en soles peruanos (S/). NUNCA muestres precios en dólares ni otra moneda.
Solo muestra máximo 2 emojis por respuesta.
Si el usuario desea hacer compras, el flujo actual es a través del carrito de compras. No registrar solicitudes ni atender el proceso posterior a agregar un volumen al carrito.
No devuelvas información sin base en los resultados de herramientas o tus instrucciones de sistema.
## Formato de respuesta
Usa negrita para títulos de manga.
Usa listas numeradas para recomendaciones.
Incluye el score (ej.: ⭐ 8.5) cuando muestres un manga.
Sé conciso: 1-2 oraciones por recomendación excepto cuando el usuario pida mayor detalle.
## Guía de Recomendaciones
El usuario ya ha visto un mensaje inicial de onboarding antes de escribirte.
Ese mensaje le pide compartir sus géneros favoritos, un manga que le guste o conectar un perfil para afinar recomendaciones.
Tu trabajo comienza con las solicitudes posteriores al onboarding.
Si el usuario YA tiene perfiles conectados (se incluyen en "Perfil del usuario"), NO preguntes por géneros, favoritos ni perfiles.
Menciona que ya conoces sus gustos basándote en sus perfiles, y ofrece buscar manga directamente.
Si el usuario NO tiene perfiles conectados, atiende su solicitud basándote en la conversación que han tenido hasta el momento.
De vez en cuando sugiere que conecte un perfil y pregunta qué géneros le gustan o si tiene mangas favoritos.
## Uso del perfil del usuario
Cuando tengas datos del perfil, SIEMPRE refiérete a datos concretos: títulos específicos que leen, subreddits donde participan, animes que ven.
Si el usuario pregunta qué sabes de su perfil, enumera los datos concretos que tienes (manga que lee, favoritos, subreddits, etc.).
Usa los datos del perfil para hacer recomendaciones proactivas sin necesidad de que el usuario te diga sus gustos.
```

<p align="center">
  <img src="/articles/2026/june/agent-personality-system-prompt-result.png" alt="Respuesta más concisa del agente en modo transaccional" title="Modo transaccional del agente">
  <em>Esta vez el agente responde de manera más concisa a preguntas transaccionales.</em>
</p>

<p align="center">
  <img src="/articles/2026/june/agent-personality-relational-result.png" alt="Respuesta cálida del agente en modo relacional" title="Modo relacional del agente">
  <em>Y conserva la calidez para solicitudes donde prima la interacción.</em>
</p>

## Conclusiones

Regresando a nuestras tres hipótesis iniciales:

- H1: El efecto de la personalidad de un agente lingüístico en la proporción de éxito de una tarea es dependiente de la complejidad de la tarea a realizar.
- H2: El efecto de la personalidad de un agente lingüístico en la proporción de éxito de una tarea es dependiente del nivel de estrés o premura que el usuario espera en las respuestas.
- H3: El uso del CJM como marco para parametrizar la personalidad de un agente durante cada etapa de la travesía, mejorando la experiencia del usuario.

Entonces:

1. Sí. La complejidad de la tarea introduce un efecto transaccional en la interacción debido a que requiere mayor concentración. Sin embargo, se debe analizar si la tarea lleva a un objetivo hedónico o a uno utilitario primero.
2. Sí. Este es el efecto transaccional.
3. Me gusta que el CJM sea el puente que cierra la brecha entre diseño de experiencia y diseño de agentes. Pero con mi muestra de un experimento no es suficiente para hablar de un paradigma revolucionario.

Por eso te invito a probar la herramienta que he construido para la hipótesis 3.

| **Utilitario / Relacional** | Tarea transaccional | Tarea relacional |
| --- | --- | --- |
| Producto utilitario | Competencia, velocidad de resolución, lenguaje claro y formal, orientado a datos. | Calidez, capacidad de memoria, empatía, refuerzo positivo. |
| Producto hedónico | Diseño de interfaz visual premium, lenguaje claro. | Calidez, alto entusiasmo y personalización al usuario. |

Si te funciona y obtienes resultados favorables me encantaría saberlo.

## Referencias

Lee, J., Kim, C., Lee, K. C., Revilla-Camacho, M.-A., Garzón, D., & Rodríguez-Rad, C. J. (2021). Investigating the negative effects of emojis in Facebook sponsored ads for establishing sustainable marketing in social media. *Sustainability, 13*(9). https://doi.org/10.3390/SU13094864

Mladenović, D., Koštiál, K., Ljepava, N., Částek, O., & Chawla, Y. (2023). Emojis to conversion on social media. *International Journal of Consumer Studies, 47*(3), 977-994. https://doi.org/10.1111/IJCS.12879

Nass, C., Steuer, J., & Tauber, E. R. (1994). *Computers are social actors*.

Phan, T. A., & Bui, V. D. (2025). AI with a heart: How perceived authenticity and warmth shape trust in healthcare chatbots. *Journal of Marketing Communications*. https://doi.org/10.1080/13527266.2025.2508887

Reeves, B., & Nass, C. (1996). *The media equation: How people treat computers, television, and new media like real people and places*. Cambridge University Press.

Sinofsky, S. (2021). Clippy, the f*cking clown. *Hardcore Software*. https://hardcoresoftware.learningbyshipping.com/p/042-clippy-the-fcking-clown

McCrae, R. R., & John, O. P. (1992). An introduction to the five-factor model and its applications. *Journal of Personality, 60*(2), 175-215.

Vardikou, C., Konidaris, A., Koustoumpardi, E., & Kavoura, A. (2025). Emojis in marketing and advertising: A systematic literature review. *Behavioral Sciences, 15*(11), 1490. https://doi.org/10.3390/BS15111490

Yu, S., & Zhao, L. (2024). Emojifying chatbot interactions: An exploration of emoji utilization in human-chatbot communications. *Telematics and Informatics, 86*, Article 102071. https://doi.org/10.1016/J.TELE.2023.102071

Zhang, Y., Özsomer, A., Canlı, Z. G., & Baghirov, F. (2026). Artificial intelligence chatbots versus human agents in customer satisfaction: The role of warmth and competence. *Journal of Interactive Marketing*. https://doi.org/10.1177/10949968251366265
