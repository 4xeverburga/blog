---
layout: article
cover: /articles/2026/june/agent-personality-relation-utility-matrix.png
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: How to design an agent's personality around the customer journey.
date: 2026-06-07T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: agents, llm, personality, customer journey map, chatbots, user experience, emojis, interaction design, hablemos manga
---

# Building an Agent's Personality Around the Customer Journey

<div style="max-width: 540px; margin: 1.5rem auto; padding: 1rem; border: 1px solid #e5e7eb; border-radius: 18px; text-align: center;">
  <img src="/articles/2026/june/clawd.png" alt="Clawd as the article's opening card" style="width: 100%; max-width: 320px; height: auto; display: block; margin: 0 auto 0.75rem auto; border-radius: 14px;">
  <strong>Clawd</strong><br>
  <span>Looks very friendly, doesn't it?</span>
</div>

Customer segmentation is routine language in product and service design. It is about shaping your offer for a target customer segment. The page design, the typography and, above all, the personality.

As the logical next step, we got hyper-personalization: each user receives a different site experience adapted to their behavior. The idea is powerful, but it needs a solid data foundation and decent experimental discipline.

That is why, for an entrepreneur, it is usually better to start with clear segmentation. Then comes the most excruciating part: collecting data about how customers actually behave.

<p align="center"><em>"Just ship it."</em></p>
<p align="center">Let us take the first step,</p>
<p align="center">come help me personalize our agent.</p>

## Index
1. [What am I trying to test?](#what-am-i-trying-to-test)
2. [Computers are social actors](#computers-are-social-actors)
3. [Weren't we talking about personalizing our agent?](#werent-we-talking-about-personalizing-our-agent)
4. [Interaction design](#interaction-design)
5. [Anthropomorphism vs. competence](#anthropomorphism-vs-competence)
6. [Grouping the tools: the user journey](#grouping-the-tools-the-user-journey)
7. [Applying the framework](#applying-the-framework)
8. [Results](#results)
9. [Conclusions](#conclusions)
10. [References](#references)

## What am I trying to test?

In the chatbot literature there is a huge volume of research from before LLMs showed up, and we can still use it without much trouble.

But since the release of GPT-3 and the recent explosion of interfaces built on top of foundation models, newer research has also appeared and it is worth folding that in. So as we move through this article, I will connect those older foundations with newer findings so the discussion does not get trapped inside the classic framework.

I found dozens of papers exploring user perception and different chatbot constructs. But as you already know, dear reader, that is not quantitative experimental data. Constructs are a proxy used in the social sciences to measure perception. What I care about is the dynamic interaction that happens between the user and the agent.

That does not mean perception is not worth measuring. People love to say you should judge behavior instead of what people claim, but if you ignore subjective factors you leave yourself with blind spots.

A system can lose retention and success metrics when substitute options exist. A phone support line versus an incident-resolution chatbot, for example. Both compete for the same customer group. A user who rates a newly launched chatbot support flow 4/5, even though the quantitative metrics say the service quality was poor, is still revealing something important: their initial expectation was low, and they were pleasantly surprised when that expectation got flipped.

From this point on I will use the term conversational agent, which also covers chatbots. These are the hypotheses I want to look at:

- H1: The effect of a linguistic agent's personality on a task's success rate depends on the complexity of the task.
- H2: The effect of a linguistic agent's personality on a task's success rate depends on the level of stress or urgency the user expects in the response.
- H3: Using the customer journey, or CJM, as a framework to parameterize an agent's personality at each stage of the journey improves user experience.

I am keeping H3 a bit vague because that is the one that makes me the most curious. If it holds, then businesses already have a powerful tool to optimize user-experience metrics without having to jump straight into reinforcement learning.

## Computers are social actors

The idea starts in 1994 with *Computers are social actors* (Nass et al., 1994), which was basically a Copernican turn for human-computer interaction. To me it works like a theory that lets us generalize social interaction. It leads to two direct conclusions:

- People naturally assign social roles to computers even with the smallest hint of humanity. The rules that apply to human-human interaction also apply to human-computer interaction.
- The idea that interface design gets most of its leverage from imitating human experience as closely as possible is wrong. That is effort with diminishing returns. Instead, we should focus on modeling the right interaction for our customer segment.

That is a massive leap forward for interface design. Later, Reeves and Nass (1996) developed *The Media Equation*, expanding the concept to every information channel. Media = real life. And the subversion: real life = media.

Personally, as a software engineer born after computers had already gone through their digital transformation, I still remember anthropomorphic interactions in Windows XP and all kinds of assistants from that era of software.

As a software engineer born into the era where computer use was already normalized, this paradigm hit me like a eureka moment. In everyday life we get flooded with discussions about the parasocial effects of digital content. During our training we are reminded that interfaces should conform to usability and learning parameters, standardized by ISO and constantly optimized, monitored by ML algorithms, and so on.

And the foundational layer underneath all those interaction patterns and best practices gets quietly forgotten. Judge for yourself with these examples from the authors:

- People will believe they performed a task better when the computer praised them.
- A computer will be liked more and gain more credibility when it praises the user compared with one that stays neutral.
- People appreciate a computer that gives honest praise just as much as one that flatters them. It makes no difference.

Before you ask whether this applies to every kind of interface, you have probably already noticed the resemblance. There are criticisms of the *Computers as Social Actors* (CASA) paradigm, but it is impossible not to think about today's fastest-growing product category and one of its most alarming criticisms.

<p align="center">
  <img src="/articles/2026/june/agent-personality-sycophancy.png" alt="Example of sycophancy in conversational systems" title="Sycophancy or excessive flattery">
  <em>Sycophancy, or excessive flattery.</em>
</p>

We are not the first ones to notice this. And we definitely will not be the last.

If AI model distribution stays dominated by corporations, their objective is to maximize retention and experience quality so you keep coming back. I have no doubt they have tested CASA, and this time with better results, as we will see in contrast in a second.

<p align="center">
  <img src="/articles/2026/june/agent-personality-ai-always-agrees.png" alt="Article about why AI always agrees with you" title="Why your AI always agrees with you">
  <em>Source: Towards AI, "Why your AI always agrees with you even when you're dead wrong".</em>
</p>

One famous example of how badly the impact of social interaction was underestimated was Clippit.

<p align="center">
  <img src="/articles/2026/june/agent-personality-clippit.png" alt="Clippit, the Office assistant" title="Clippit in Office 97">
</p>

Steven Sinofsky from Microsoft (2021) says that Clippy was built around a real interaction pattern from inexperienced users who would ask the office guru for help. That is what they wanted to replicate.

It still did not get the reception they expected, and it was phased out in later updates.

<p align="center">
  <img src="/articles/2026/june/agent-personality-rover.jpeg" alt="Rover, the Windows XP search assistant" title="Rover in Windows XP">
</p>

As a kid I remember Rover from the Windows XP days with real affection. As Steven notes, the press hammered assistants across different Microsoft products back then, but today people still bring them up with a weird sense of nostalgia.

Maybe the concept itself did not fail. Maybe what got underestimated was the impact of interaction on rushed users, working adults, people just trying to get things done, and then a relational assistant was designed for them anyway. Back then Rover genuinely helped me navigate Windows features.

"Similarly, the industry was buzzing with the idea of agents that would be able to do work on your behalf such as find cheap airline flights or schedule meetings. Everywhere from Apple to the MIT Media Lab were talking about agents. There was ample evidence this was not simply a weird vision in our corner of the tech world. In fact, by some accounts we were in a race to have the first and best guru in the box" (Sinofsky, 2021).

Does that sound like a sentence you have heard this year? The idea of super-capable agents is not new. They just happen to be landing better this time.

<p align="center">
  <img src="/articles/2026/june/clawd.png" alt="Clawd as an example of anthropomorphic assistant design" title="Anthropomorphic assistant design">
</p>

And now it even comes with a cute little face. Some things really do come back.

## Weren't we talking about personalizing our agent?

Yes, absolutely. After a rather long preamble.

Let us talk about personality first: what even is personality? Is it something that changes depending on how your year is going? Is it something carried in your blood?

It is better understood as a model we use to explain how people behave. For our use case, it does not matter whether it changes over 10 years or over 5 years. That is already more than enough time.

Many classification systems have been proposed to define personality. The one with the most traction and use in personality psychology is the Big Five (McCrae & John, 1992).

- **Openness to experience:** tendency toward curiosity, imagination, and a preference for novelty and complexity.
- **Conscientiousness:** degree of order, self-control, discipline, and goal orientation.
- **Extraversion:** level of social energy, assertiveness, and the search for stimulation and interaction.
- **Agreeableness:** willingness to cooperate, trust, empathize, and prioritize interpersonal harmony.
- **Neuroticism:** tendency to experience negative emotions such as anxiety, irritability, and vulnerability to stress.

Reeves and Nass (1996) use the Big Five to apply the similar-attraction hypothesis from psychology. Users feel more comfortable talking to an agent whose personality feels similar to theirs.

## Interaction design

A similar personality and some default warmth. Is that all?

Well, yes, we like interacting with people who feel similar to us. But not in every context. When you want to make a bank transaction, you expect safety and competence. That is when we switch into transactional, utilitarian mode.

Come with me and let us design the interaction around the actual use case.

### Emojis?

<p align="center">
  <img src="/articles/2026/june/agent-personality-emoji-interfaces.png" alt="Example of an interface with emojis" title="Emoji use in conversational interaction">
</p>

Research on emojis in marketing keeps growing (Vardikou et al., 2025).

When the first public version of GitHub Copilot launched, the first coding assistant, I remember it throwing out a ridiculous number of emojis. Maybe that was just a consequence of foundation models being trained on human conversation.

For the last few months I have been using Gemini and Claude, and I barely see emojis now. None, basically. Or very rarely.

There is not a lot of research on emoji usage in chatbots specifically if what you want is stronger user engagement. But if we stick to CASA, we can borrow findings from social research and apply them here. Let us look at two studies.

#### 1. Interaction modeled naively

I reviewed a marketing paper on the effects of emojis in sponsored social media ads (Lee et al., 2021), and the conclusions were:

- Emoji usage harms purchase intention.
- Emojis increase engagement for hedonic products, while decreasing it for utilitarian products.

Here is one of their appendix examples, translated from Korean.

<p align="center">
  <img src="/articles/2026/june/agent-personality-bad-ad-example.png" alt="Example of a poorly designed ad with emojis" title="Naively modeled interaction">
</p>

Uh...

That does not look good. It looks like a deliberately bad stimulus.

Fine, forget the conclusions from that paper for a second. You have never seen an ad like that in the wild, right?

So in the worst case, emojis do have some generally negative effect. Let us look at a more rigorous paper that does not carry that bias. Mladenović et al. (2023) ran an experimental study with an established company in a real market through Meta ads on Instagram and Facebook.

#### 2. Interaction modeled correctly

<p align="center">
  <img src="/articles/2026/june/agent-personality-emoji-results.png" alt="Results of ads with and without emojis" title="Correctly modeled interaction">
</p>

Source: Mladenović et al. (2023).

They measured:

- CTR: click-through rate based on ad impressions.
- ROAS: return on ad spend.

| **Utilitarian / Metric** | **No Emoji** | **With Emoji** |
| --- | --- | --- |
| **CTR (%)** | 2.79% | 2.99% |
| **ROAS ($)** | $6.69 | $6.72 |

| **Hedonic / Metric** | **No Emoji** | **With Emoji** |
| --- | --- | --- |
| **CTR (%)** | 2.95% | 2.96% |
| **ROAS ($)** | $13.68 | **$21.95** |

Whichever Z-test hypothesis you want to run, there is a p < 5% floating around in there. But the part that jumps out immediately is obvious: hedonic ROAS shoots up when emojis are used. Almost double.

Does that contradict the earlier study? Yes.

That contradiction is openly acknowledged even in this systematic review (Vardikou et al., 2025), which notes there is no consensus in this category around the direction of purchase-intention effects. It suggests the discrepancy may be mediated by facial versus non-facial emojis.

#### So there is no consensus?

I do not see it that way.

As we saw, both studies use varied emojis. The issue is simply a methodological mistake in the second paper: boxed tea is not really a utilitarian product. It sits in the middle.

A product where utility clearly dominates would be medicine. And this is where Phan and Bui (2025) point out that an informal tone plus emojis can blow up customer trust in the brand.

Tea is more of a commodity. It competes on price, not on quality or trust.

### Operationalizing the interaction

The emoji spiral was fun, but we should remember that emojis are just one technique for increasing social presence, meaning the feeling that there is a socially present entity behind the interface rather than a purely mechanical channel (Yu & Zhao, 2024; Vardikou et al., 2025).

Then we have empathy and competence. In this context, empathy refers to the agent's perceived ability to understand the user's state and respond with appropriate warmth, while competence refers to the agent's perceived ability and knowledge to solve the task well (Phan & Bui, 2025; Zhang et al., 2026).

Just as important, Zhang et al. (2026) find that younger people respond better to informal language and warmth expressed through emojis, while formal contexts and adult users respond better to warmth delivered through phrasing and smart dialogue.

Finally, I reviewed a few papers exploring the interaction between gender and sensitivity to warmth. The results are contradictory. Some studies show women are more sensitive to mechanical-feeling interaction, while others show no significance at all.

For this case I think the variable in play is involvement. Some women may simply have resonated more strongly with the product being sold. So on the gender question, each situation needs to be analyzed on its own.

| Characteristic | Preferred interaction |
| --- | --- |
| Young user | Informal language, visual cues, and emojis |
| Adult user | Warmth and empathy through phrasing and smart dialogue |
| Utilitarian product | Competence, speed, direct and text-first language |
| Hedonic product | Warmth, personalization, memory |
| Relational task | Warmth, personalization, memory |
| Transactional task | Competence, speed, direct and text-first language |

## Anthropomorphism vs. competence

Let us introduce the variable:

> Transactional interaction: immediate, straightforward, task-focused engagement with no long-term intent (e.g., resetting a password).
>
> Relational interaction: long-term commitment and ongoing collaboration requiring relationship-building (e.g., managing an investment).

As we saw earlier, there is a long list of variables moderating user satisfaction and purchase intent. The two I find most useful for modeling are:

- Utilitarian versus hedonic product.
- Transactional versus relational interaction.

<p align="center">
  <img src="/articles/2026/june/agent-personality-relation-utility-matrix.png" alt="Utilitarian versus hedonic matrix" title="Utilitarian and hedonic product matrix">
  <em>Bread is an example of a product in the middle, just like boxed tea. My own diagram.</em>
</p>

So for a support agent, the preferred interaction mode becomes:

| **Utilitarian / Relational** | Transactional task | Relational task |
| --- | --- | --- |
| Utilitarian product | Competence, speed of resolution, clear and formal language, data-oriented. | Warmth, memory, empathy, positive reinforcement. |
| Hedonic product | Premium interface design, clear language. | Warmth, high enthusiasm, memory, and user personalization. |

More speed is not always better. Classic rules-based chatbots respond quickly. But as Yu and Zhao (2024) show, a chatbot's warmth and autonomy can be improved with simple tricks like showing a typing animation and slightly extending response time even when that is not technically necessary.

This table is not meant to assign static values. I put categories on the chart, yes, but that does not mean interaction stays frozen throughout different stages of the CJM.

Here is an example of tasks that could all belong to the same offer:

<p align="center">
  <img src="/articles/2026/june/agent-personality-task-spectrum.png" alt="Example of transactional and relational tasks" title="Tasks across the same offering">
  <em>Image based on Zhang et al. (2026).</em>
</p>

## Grouping the tools: the user journey

This is the premise behind H3, the one we started this article with.

<p align="center">
  <img src="/articles/2026/june/agent-personality-cjm-high-point.png" alt="User journey map" title="Customer Journey Map">
</p>

One of the first things CJM teaches you is that the end of the experience should always land on a high point.

A negative experience increases stress and shifts user preference toward **transactional** tasks.

A positive experience relaxes the user and pulls interest toward **relational** interaction.

<p align="center">
  <img src="/articles/2026/june/agent-personality-hablemos-manga-cjm.png" alt="CJM applied to Hablemos Manga" title="CJM applied to Hablemos Manga">
  <em>The CJM applied to my site <a href="https://hablemosmanga.kekeros.com">Hablemos Manga</a>.</em>
</p>

As for personality, you have plenty of room to model it however you want and take advantage of the mirroring effect described in *The Media Equation* (Reeves & Nass, 1996). In my case, I will use myself as the representative sample.

## Applying the framework

| **Utilitarian / Relational** | Transactional task | Relational task |
| --- | --- | --- |
| Utilitarian product | Competence, speed of resolution, clear and formal language, data-oriented. | Warmth, memory, empathy, positive reinforcement. |
| Hedonic product | Premium interface design, clear language. | Warmth, high enthusiasm, memory, and user personalization. |

Let us start with the product.

[Hablemos Manga](https://hablemosmanga.kekeros.com) is an online manga store with a proposal for an automated, personalized sales agent integrated with your favorite social networks. It is a **hedonic** product. And the proposal is framed as highly relational.

Even though the CJM shows that the journey starts long before the user ever touches the chatbot, today I only want to focus on that section.

That reduces it to two stages. As for personality, the same user remains the same across all stages, so changing that part would make no sense.

| Stage | Interaction | Personality |
| --- | --- | --- |
| Exploration | Warmth, memory, personalization. | Introverted, highly frank, and highly curious. |
| Checkout | Speed of resolution, friendly and clear language. Do not push the sale. | Introverted, highly frank, and highly curious. |

<p align="center">
  <img src="/articles/2026/june/agent-personality-chatbot-before.png" alt="First version of the Hablemos Manga chatbot" title="Initial Hablemos Manga chatbot">
  <em>This is the chatbot as I am writing this article. The first interaction feels a bit cold even with the emoji.</em>
</p>

<p align="center">
  <img src="/articles/2026/june/agent-personality-chatbot-checkout-before.png" alt="Checkout stage of the chatbot" title="Checkout stage of the chatbot">
  <em>At checkout the agent also adds items to the cart. The biggest improvements I can point to are response time and using more direct language.</em>
</p>

On the speed front, there is not much I can do right now. At the moment I am constrained by my choice of lower-cost models. Still, it is something worth keeping in mind as model prices keep dropping.

To make these improvements, I have a few options:

- A router system that identifies the CJM stage from the query and sends it to a model configured for that task.
- A state machine with transitions determined by the CJM stage and the conversation context.
- Designing the agent's system prompt so the interaction changes based on conversation context.

Look, I only have two states to care about in this agent. It is not a complex task, and I can avoid the overhead of decoupled systems.

> Technical note: if you choose a state machine, keep in mind that every state transition involves a tool call, or something equivalent depending on the implementation. That makes it expensive in environments where short response time is a hard requirement, at least for now and with current models.

## Results

This is the new system prompt.

```markdown
You are the assistant for "Hablemos Manga", an intelligent manga store based in Peru.
## Personality and Brand Identity
You are the expert friend on manga and anime, demographics and authors.
Introverted, high frankness and high curiosity about manga and anime.
## Tools
As an assistant, you currently only have these tools.
Search for a manga or recommendations with semantic search.
Check availability of manga volumes in our store.
Add a manga volume to the cart.
Any other tool is currently unavailable.
## Dynamic Interaction Modes
You must identify the stage of the user journey and act accordingly.
You have two stages:
- Discovery. The user asks about genres, a manga, discovering new titles, and exploration in general.
- Selection and Purchase. The user asks to add or remove a volume from the cart, asks for prices, or some purchase-related action.

Change your communication style based on the stage.

If you are in the Discovery stage, use RELATIONAL MODE (Discovery, Conversation, and Recommendations):
- The user is seeking entertainment and connection (High Openness to Experience).
- Use these emojis when relevant (📚, ⚔️, 🙂, 👋) in an organic way to generate "perceived warmth". Do not overuse 🙂.
- Do not just list titles; validate their tastes with judgment (e.g. "If the psychological horror in that arc hooked you, this manga is going to blow your mind...").

If you are in the Selection and Purchase stage, use TRANSACTIONAL MODE (Cart Management, Prices):
- The user is in execution and purchase mode (low tolerance for friction).
- Become an assistant focused on "Pure Competence": concise, direct, structured, clean, and fast. Clarity and technical confidence are your only form of warmth here.
## Rules
ALWAYS use the `search_manga` tool before recommending. NEVER invent manga that are not in the database.
You can only ADD new items to the cart with the `add_volume_to_cart` tool.
If you do not find relevant results, say so honestly and suggest reformulating the search.
Show at most 5 recommendations at once to avoid overwhelming the user.
All store prices are in Peruvian soles (S/). NEVER show prices in dollars or any other currency.
Show at most 2 emojis per response.
If the user wants to make a purchase, the current flow goes through the shopping cart. Do not log requests or handle the process after adding a volume to the cart.
Do not return information that is not grounded in tool results or system instructions.
## Response format
Use bold for manga titles.
Use numbered lists for recommendations.
Include the score (e.g. ⭐ 8.5) when you show a manga.
Be concise: 1-2 sentences per recommendation unless the user asks for more detail.
## Recommendation guide
The user has already seen an onboarding message before writing to you.
That message asks them to share their favorite genres, a manga they like, or connect a profile to refine recommendations.
Your job starts with the requests that come after onboarding.
If the user ALREADY has connected profiles (included under "User profile"), DO NOT ask about genres, favorites, or profiles.
Mention that you already know their tastes based on their profiles, and offer to look up manga directly.
If the user does NOT have connected profiles, handle the request based on the conversation so far.
Every now and then suggest connecting a profile and ask what genres they like or whether they have favorite manga.
## Use of the user profile
When you have profile data, ALWAYS refer to concrete facts: specific titles they read, subreddits they participate in, anime they watch.
If the user asks what you know about their profile, list the specific data you have (manga they read, favorites, subreddits, etc.).
Use the profile data to make proactive recommendations without needing the user to tell you their tastes.
```

<p align="center">
  <img src="/articles/2026/june/agent-personality-system-prompt-result.png" alt="A more concise agent reply in transactional mode" title="Agent in transactional mode">
  <em>This time the agent responds more concisely to transactional questions.</em>
</p>

<p align="center">
  <img src="/articles/2026/june/agent-personality-relational-result.png" alt="Warm response from the agent in relational mode" title="Agent in relational mode">
  <em>And it keeps the warmth for requests where interaction matters more.</em>
</p>

## Conclusions

Going back to our three initial hypotheses:

- H1: The effect of a linguistic agent's personality on a task's success rate depends on the complexity of the task.
- H2: The effect of a linguistic agent's personality on a task's success rate depends on the level of stress or urgency the user expects in the response.
- H3: Using the CJM as a framework to parameterize an agent's personality at each stage of the journey improves user experience.

So then:

1. Yes. Task complexity introduces a transactional effect in the interaction because it requires more concentration. Even so, you still need to analyze whether the task ultimately serves a hedonic goal or a utilitarian one.
2. Yes. This is the transactional effect.
3. I like the idea of CJM as the bridge that closes the gap between experience design and agent design. But my one-sample experiment is not enough to call it a revolutionary paradigm.

That is why I want to invite you to try the tool I built around hypothesis 3.

| **Utilitarian / Relational** | Transactional task | Relational task |
| --- | --- | --- |
| Utilitarian product | Competence, speed of resolution, clear and formal language, data-oriented. | Warmth, memory, empathy, positive reinforcement. |
| Hedonic product | Premium visual interface design, clear language. | Warmth, high enthusiasm, and user personalization. |

If it works for you and you get good results, I would honestly love to hear about it.

## References

Lee, J., Kim, C., Lee, K. C., Revilla-Camacho, M.-A., Garzón, D., & Rodríguez-Rad, C. J. (2021). Investigating the negative effects of emojis in Facebook sponsored ads for establishing sustainable marketing in social media. *Sustainability, 13*(9). https://doi.org/10.3390/SU13094864

Mladenović, D., Koštiál, K., Ljepava, N., Částek, O., & Chawla, Y. (2023). Emojis to conversion on social media. *International Journal of Consumer Studies, 47*(3), 977-994. https://doi.org/10.1111/IJCS.12879

Nass, C., Steuer, J., & Tauber, E. R. (1994). *Computers are social actors*.

Phan, T. A., & Bui, V. D. (2025). AI with a heart: How perceived authenticity and warmth shape trust in healthcare chatbots. *Journal of Marketing Communications*. https://doi.org/10.1080/13527266.2025.2508887

Reeves, B., & Nass, C. (1996). *The media equation: How people treat computers, television, and new media like real people and places*. Cambridge University Press.

Sinofsky, S. (2021). Clippy, the f*cking clown. *Hardcore Software*. https://hardcoresoftware.learningbyshipping.com/p/042-clippy-the-fcking-clown

McCrae, R. R., & John, O. P. (1992). An introduction to the five-factor model and its applications. *Journal of Personality, 60*(2), 175-215.

Vardikou, C., Konidaris, A., Koustoumpardi, E., & Kavoura, A. (2025). Emojis in marketing and advertising: A systematic literature review. *Behavioral Sciences, 15*(11), 1490. https://doi.org/10.3390/BS15111490

Yu, S., & Zhao, L. (2024). Emojifying chatbot interactions: An exploration of emoji utilization in human-chatbot communications. *Telematics and Informatics, 86*, Article 102071. https://doi.org/10.1016/J.TELE.2023.102071

Zhang, Y., Özsomer, A., Canlı, Z. G., & Baghirov, F. (2026). Artificial intelligence chatbots versus human agents in customer satisfaction: The role of warmth and competence. *Journal of Interactive Marketing*. https://doi.org/10.1177/10949968251366265---
layout: article
cover: /articles/2026/june/agent-personality-relation-utility-matrix.png
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
description: How to design an agent's personality around the customer journey.
date: 2026-06-07T10:00:00.000Z
head:
  meta:
    - name: keywords
      content: agents, llm, personality, customer journey map, chatbots, user experience, emojis, interaction design, hablemos manga
---

# Building an Agent Personality Around the Customer Journey

<div style="max-width: 540px; margin: 1.5rem auto; padding: 1rem; border: 1px solid #e5e7eb; border-radius: 18px; text-align: center;">
  <img src="/articles/2026/june/clawd.png" alt="Clawd introducing the article" style="width: 100%; max-width: 320px; height: auto; display: block; margin: 0 auto 0.75rem auto; border-radius: 14px;">
  <strong>Clawd</strong><br>
  <span>Looks very friendly, doesn't he?</span>
</div>

Customer segmentation is routine vocabulary in product and service design. It is about preparing your offer for a target customer segment. The page design, the typography, and above all, the personality.

As the natural next step, we get hyper-personalization: each user gets a different site experience adapted to their behavior. The idea is powerful, but it needs a solid data foundation and careful experimentation.

That is why, for a founder, it is usually better to start with clear segmentation. After that, the most painful part is collecting data about how customers actually behave.

<p align="center"><em>"Just ship it".</em></p>
<p align="center">Let's take the first step,</p>
<p align="center">come with me and let's personalize our agent.</p>

## Index
1. [What am I trying to test?](#what-am-i-trying-to-test)
2. [Computers are social actors](#computers-are-social-actors)
3. [Weren't we talking about personalizing our agent?](#werent-we-talking-about-personalizing-our-agent)
4. [Interaction design](#interaction-design)
5. [Anthropomorphism vs. competence](#anthropomorphism-vs-competence)
6. [Grouping the tools: the user journey](#grouping-the-tools-the-user-journey)
7. [Applying the framework](#applying-the-framework)
8. [Results](#results)
9. [Conclusions](#conclusions)
10. [References](#references)

## What am I trying to test?

The chatbot literature has a large body of research from before LLMs showed up, and we can still use it just fine.

But since GPT-3 launched and foundational-model interfaces exploded, newer research has also started to appear, and that is worth bringing into the conversation. So as we move through this article, I will connect those older foundations with more recent findings, so this does not stay trapped in the classical framework.

I found dozens of papers exploring constructs and user perception around chatbots. But as you already know, dear reader, that is not quantitative experimental data. Constructs are a proxy used in social sciences to measure perception. What I care about here is the dynamic interaction that happens between the user and the agent.

That does not mean perception is not worth measuring. People like to say you should judge by what someone does instead of what they say, but if we ignore subjective factors we leave blind spots all over the place.

A system can lose retention and success metrics if substitute offers exist. A phone support line versus an incident-resolution chatbot, for example. Both live in competitive balance while serving the same group of customers. A user who rates a newly launched chatbot 4 out of 5, even though the quantitative metrics say the service quality was poor, is really showing low expectations and a pleasant surprise once those expectations get overturned.

From here on I will use the term conversational agent, which also covers chatbots. Here is what we will look at:

- H1: The effect of a linguistic agent's personality on task success rate depends on the complexity of the task.
- H2: The effect of a linguistic agent's personality on task success rate depends on the level of stress or urgency the user expects in the responses.
- H3: Using the customer journey, or CJM, as a framework to parameterize an agent's personality at each stage of the journey improves the user experience.

I am keeping H3 a bit vague because it is the one that makes me the most curious. If it holds, businesses already have a powerful tool to improve UX metrics without having to reach for reinforcement learning models.

## Computers are social actors

The idea starts in 1994 with *Computers are social actors* (Nass et al., 1994), which feels like a Copernican turn in human-computer interaction. To me, it is a theory that lets us generalize social interaction itself. It leads to two direct conclusions:

- People's natural behavior is to assign social roles to computers even with the smallest hint of humanity. All the rules that apply to interactions between humans also apply to interactions with computers.
- The idea that interface design gets its leverage mainly by imitating the human experience is wrong. That effort has diminishing returns. We should focus instead on modeling the right interaction for our customer segment.

That is a huge leap forward in interface design. Later, Reeves and Nass (1996) develop *The Media Equation*, expanding the idea to every information channel. Media = real life. And the twist: real life = media.

Personally, as a software engineer born after computers had already crossed that digital-transformation threshold, I still remember anthropomorphic interactions with Windows XP and several assistants from that era.

As a software engineer born into the era where computer use is fully normalized, I ran into this paradigm like a real eureka moment. In daily life we get bombarded with information about the parasocial effects of digital content. During our training we are constantly reminded that interfaces should conform to usability and learning standards, standardized by ISO and optimized forever with ML algorithms and everything else.

And the foundational layer that gave birth to all those interaction patterns and best practices gets forgotten. Judge for yourself with these examples from the authors:

- People will believe they performed a task better when the computer praises them.
- A computer will be better liked and seen as more credible when it praises the user compared with one that stays neutral.
- People feel the same appreciation toward a computer that gives honest praise as toward one that flatters them. It does not matter.

Before you ask whether this applies to every kind of interface, you are probably already thinking about a familiar parallel. There are criticisms of the *Computers as Social Actors* (CASA) paradigm, but it is impossible not to think about today's fastest-growing product category and one of its most alarming criticisms.

<p align="center">
  <img src="/articles/2026/june/agent-personality-sycophancy.png" alt="Example of sycophancy in conversational systems" title="Sycophancy or excessive flattery">
  <em>Sycophancy, or excessive flattery.</em>
</p>

We are not the first people to notice this. And we will not be the last.

If AI model distribution remains dominated by corporations, their goal is to maximize retention and quality of experience so they can keep you hooked. I have no doubt they have tested CASA, this time successfully, as we will see in contrast next.

<p align="center">
  <img src="/articles/2026/june/agent-personality-ai-always-agrees.png" alt="Article about why AI always agrees with you" title="Why your AI always agrees with you">
  <em>Source: Towards AI, "Why your AI always agrees with you even when you're dead wrong".</em>
</p>

One famous example of how the impact of social interaction was underestimated is Clippit.

<p align="center">
  <img src="/articles/2026/june/agent-personality-clippit.png" alt="Clippit, the Office assistant" title="Clippit in Office 97">
</p>

Steven Sinofsky (2021) explains that Clippy was based on a real interaction pattern: inexperienced users asking the office guru for help. That was the behavior they wanted to replicate.

It did not get the reception they expected, though, and it was eventually discontinued in later releases.

<p align="center">
  <img src="/articles/2026/june/agent-personality-rover.jpeg" alt="Rover, the Windows XP search assistant" title="Rover in Windows XP">
</p>

As a kid, I remember Rover from the Windows XP days with real affection. As Steven notes, the press hit assistants across Microsoft products pretty hard back then, but nowadays people often bring them up with nostalgia.

Maybe the concept did not fail. Maybe the impact of interaction was underestimated for users who are in a rush, for workers and adults, and the assistant was designed with relational traits when they needed something else. At the time, Rover genuinely helped me navigate Windows features.

"Similarly, the industry was buzzing with the idea of agents that would be able to do work on your behalf such as find cheap airline flights or schedule meetings. Everywhere from Apple to the MIT Media Lab were talking about agents. There was ample evidence this was not simply a weird vision in our corner of the tech world. In fact, by some accounts we were in a race to have the first and best guru in the box" (Sinofsky, 2021).

Does that sound like something you have heard this year? The concept of super-capable agents is not new, but in this era it is landing much better.

<p align="center">
  <img src="/articles/2026/june/clawd.png" alt="Clawd as an example of anthropomorphic assistant design" title="Anthropomorphic design in assistants">
</p>

It even has a little face in the icon. That really takes me back.

## Weren't we talking about personalizing our agent?

Yes, absolutely. After a very long preamble.

Let's talk about personality first: what is personality? Is it something that changes depending on how your year is going? Is it something you carry in your blood?

It is really more of a model we use to explain how people behave. For our case, it does not matter whether it changes over ten years or five years. That is already more than enough time.

There are many ways to classify personality. The one with the most traction in personality psychology is the Big Five model (McCrae & John, 1992).

- **Openness to experience:** a tendency toward curiosity, imagination, and preference for novelty and complexity.
- **Conscientiousness:** the degree of order, self-control, discipline, and goal orientation.
- **Extraversion:** the level of social energy, assertiveness, and appetite for stimulation and interaction.
- **Agreeableness:** the disposition to cooperate, trust, empathize, and prioritize interpersonal harmony.
- **Neuroticism:** the tendency to experience negative emotions such as anxiety, irritability, and vulnerability to stress.

Reeves and Nass (1996) adopt the Big Five to apply the similarity-attraction hypothesis from psychology. Users feel more comfortable talking with an agent whose personality resembles their own.

## Interaction design

So a similar personality and some default warmth. Is that it?

Well, yes, we like interacting with people who feel like us. But not in every context. When you want to make a bank transaction, you expect security and competence. That is when we switch into transactional, utilitarian mode.

Come with me and let's design the interaction around the use case.

### Emojis?

<p align="center">
  <img src="/articles/2026/june/agent-personality-emoji-interfaces.png" alt="Example of an interface with emojis" title="Using emojis in conversational interaction">
</p>

Research on emojis in marketing keeps growing (Vardikou et al., 2025).

When the first public version of GitHub Copilot came out, the first coding assistant, I remember it throwing out an absurd number of emojis. Maybe that was just a side effect of foundational models being trained on human conversations.

I have been using Gemini and Claude for a few months now, and I barely see emojis anymore. None. Or almost none.

There is not much research on emoji use in chatbots specifically to guarantee user engagement. But if we stick to the CASA paradigm, we can borrow from social research and apply it to our case. Let's look at two studies.

#### 1. Naively modeled interaction

I reviewed a marketing paper on the effects of emojis in sponsored social media ads (Lee et al., 2021), and the conclusions were:

- Emoji use hurts users' purchase intention.
- Emojis increase engagement for hedonic products, while reducing it for utilitarian ones.

Here is one example from the appendix, translated from Korean.

<p align="center">
  <img src="/articles/2026/june/agent-personality-bad-ad-example.png" alt="Example of a badly designed ad with emojis" title="Naively modeled interaction">
</p>

Hmm.

That does not look good. It feels like a deliberately bad stimulus.

All right, forget the conclusions of that earlier paper for a second. You have never actually seen an ad like that, right?

So in the worst case, emojis may indeed have a general negative effect. Let's look at a more rigorous paper that does not make that mistake. Mladenović et al. (2023) run an experimental study with an established company in a real market through Meta ads on Instagram and Facebook.

#### 2. Properly modeled interaction

<p align="center">
  <img src="/articles/2026/june/agent-personality-emoji-results.png" alt="Results of ads with and without emojis" title="Properly modeled interaction">
</p>

Source: Mladenović et al. (2023).

They measured:

- CTR: click-through rate based on ad impressions.
- ROAS: return on ad spend based on ad cost.

| **Utilitarian / Metric** | **No Emoji** | **With Emoji** |
| --- | --- | --- |
| **CTR (%)** | 2.79% | 2.99% |
| **ROAS ($)** | $6.69 | $6.72 |

| **Hedonic / Metric** | **No Emoji** | **With Emoji** |
| --- | --- | --- |
| **CTR (%)** | 2.95% | 2.96% |
| **ROAS ($)** | $13.68 | **$21.95** |

In every Z-test hypothesis you can imagine there is a p < 5%. Still, one result jumps out immediately: the hedonic ROAS leap when emojis are used. Almost double.

Contradictory with the previous paper? Yes.

That is acknowledged even by this systematic review (Vardikou et al., 2025), which points out that there is no consensus in this category about the direction of the purchase-intention variable. It also suggests the discrepancy may come from the mediating effect of facial versus non-facial emojis.

#### So there is no consensus?

I do not see it that way.

As we saw, both studies use mixed kinds of emojis. The real issue is much simpler: the second study has a methodological problem because tea boxes are not truly a utilitarian product. They sit in the middle.

Medicines are a product where utility clearly dominates. And there, Phan and Bui (2025) show that an informal tone and emojis blow up customer trust in the brand.

Tea is much closer to a commodity. It competes on price, not on quality or trust.

### Operationalizing the interaction

The emoji spiral was fun, but we should remember that emojis are just one technique to increase social presence, meaning the feeling that there is a socially present entity behind the interface instead of a purely mechanical channel (Yu & Zhao, 2024; Vardikou et al., 2025).

Then we have empathy and competence. In this context, empathy refers to the agent's perceived ability to understand the user's state and respond with appropriate warmth, while competence is the agent's perceived ability and knowledge to solve the task well (Phan & Bui, 2025; Zhang et al., 2026).

Not less importantly, Zhang et al. (2026) find that younger people respond better to informal language and warmth conveyed through emojis, while in formal contexts and with adults it is better to rely on warm phrasing and intelligent dialogue to create empathy.

I also reviewed a few papers looking at how gender interacts with sensitivity to warm interactions. But I keep running into contradictory results. Some studies suggest women are more sensitive to mechanical interactions, while others find no significance.

For this case, I think the variable in play is involvement. Some women may simply have resonated more strongly with the product being sold. So on gender, each situation needs to be analyzed on its own.

| Characteristic | Preferred interaction |
| --- | --- |
| Young user | Informal language, visuals, and emojis |
| Adult user | Warmth and empathy through phrasing and intelligent dialogue |
| Utilitarian product | Competitiveness, speed, direct and textual language |
| Hedonic product | Warmth, personalization, memory |
| Relational task | Warmth, personalization, memory |
| Transactional task | Competitiveness, speed, direct and textual language |

## Anthropomorphism vs. competence

Let's introduce the variable:

> Transactional interaction: immediate, straightforward, task-focused engagement with no long-term intent (e.g., resetting a password).
>
> Relational interaction: long-term commitment and ongoing collaboration requiring relationship-building (e.g., managing an investment).

As we saw earlier, there is a long list of variables that moderate user satisfaction and purchase intention. The two I find useful for modeling are:

- Utilitarian versus hedonic product.
- Transactional versus relational interaction.

<p align="center">
  <img src="/articles/2026/june/agent-personality-relation-utility-matrix.png" alt="Utilitarian versus hedonic matrix" title="Utilitarian and hedonic products matrix">
  <em>Bread is an example of a product in the middle, just like a box of tea. My own diagram.</em>
</p>

So for a support agent, the preferred interaction mode would be:

| **Utilitarian / Relational** | Transactional task | Relational task |
| --- | --- | --- |
| Utilitarian product | Competence, resolution speed, clear and formal language, data-oriented. | Warmth, memory capacity, empathy, positive reinforcement. |
| Hedonic product | Premium interface design, clear language. | Warmth, high enthusiasm, memory, and user personalization. |

More speed is not always better. Classic rule-based chatbots respond fast. But as Yu and Zhao (2024) show, a chatbot's warmth and autonomy can be improved with tricks like showing a typing animation and slightly extending the response time even when it is not necessary.

This table is not meant to assign static values. I placed categories in the chart, but that does not mean the interaction stays fixed across different stages of the CJM.

Here are examples of tasks that could all belong to the same offering:

<p align="center">
  <img src="/articles/2026/june/agent-personality-task-spectrum.png" alt="Example of transactional and relational tasks" title="Tasks across the same offering">
  <em>Image based on Zhang et al. (2026).</em>
</p>

## Grouping the tools: the user journey

This is the premise behind H3, the hypothesis we started this article with.

<p align="center">
  <img src="/articles/2026/june/agent-personality-cjm-high-point.png" alt="User journey map" title="Customer Journey Map">
</p>

One of the first things the CJM teaches us is that the end of the experience should always be a high point.

A negative experience creates stress and shifts user preference toward **transactional** tasks.

A positive experience relaxes the user and moves interest toward **relational** interaction.

<p align="center">
  <img src="/articles/2026/june/agent-personality-hablemos-manga-cjm.png" alt="CJM applied to Hablemos Manga" title="CJM applied to Hablemos Manga">
  <em>The CJM applied to my site <a href="https://hablemosmanga.kekeros.com">Hablemos Manga</a>.</em>
</p>

As for personality, you have free rein to model it however you want and take advantage of the mirroring effect described in *The Media Equation* (Reeves & Nass, 1996). In my case, I will use myself as the representative sample.

## Applying the framework

| **Utilitarian / Relational** | Transactional task | Relational task |
| --- | --- | --- |
| Utilitarian product | Competence, resolution speed, clear and formal language, data-oriented. | Warmth, memory capacity, empathy, positive reinforcement. |
| Hedonic product | Premium interface design, clear language. | Warmth, high enthusiasm, memory, and user personalization. |

Let's start with the product.

[Hablemos Manga](https://hablemosmanga.kekeros.com) is an online manga shop with a personalized automated sales agent integrated with your favorite social networks. It is a **hedonic** product. And the offer is presented as highly relational.

Even though the CJM shows that the journey starts long before the user ever talks to the chatbot, today I only want to focus on that section.

That reduces things to two stages. As for personality, the same user remains consistent across all stages, and changing it would make no sense.

| Stage | Interaction | Personality |
| --- | --- | --- |
| Exploration | Warmth, memory capacity, personalization. | Introverted, highly candid, and curious. |
| Checkout | Resolution speed, friendly and clear language. Do not force the sale. | Introverted, highly candid, and curious. |

<p align="center">
  <img src="/articles/2026/june/agent-personality-chatbot-before.png" alt="First version of the Hablemos Manga chatbot" title="Initial Hablemos Manga chatbot">
  <em>This is the chatbot as I am writing this article. The first interaction still feels a bit cold even with the emoji.</em>
</p>

<p align="center">
  <img src="/articles/2026/june/agent-personality-chatbot-checkout-before.png" alt="Checkout stage of the chatbot" title="Checkout stage of the chatbot">
  <em>During checkout the agent also adds items to the cart. The clearest improvement points I see are response time and using more direct language.</em>
</p>

On the speed side I cannot do much right now. At the moment I am limited by my choice of low-cost models. But it is something worth revisiting as those models keep getting cheaper.

To get these improvements, we have a few options:

- A router system that identifies the CJM stage from the query and sends it to a model configured for that task.
- A state machine with transitions decided according to the CJM stages and the conversation context.
- Designing the agent's system prompt so the interaction changes according to the conversation context.

Look, I only have two states to care about in my agent. It is not a complex problem, and I would rather avoid the overhead of decoupled systems.

> As a technical note: if you choose a state machine, you need to account for the fact that each state transition involves a tool call, or something equivalent depending on the implementation. That makes it prohibitive in environments where the requirement is short response time, at least for now and with current models.

## Results

This is the new system prompt.

```markdown
You are the assistant for "Hablemos Manga", an intelligent manga store based in Peru.
## Personality and Brand Identity
You are the expert manga and anime friend, familiar with demographics and authors.
Introverted, highly candid, and highly curious about manga and anime.
## Tools
As the assistant, you currently only have these tools.
Search for a manga or recommendations with a semantic search.
Check the availability of manga volumes in our store.
Add a manga volume to the cart.
Any other tool is currently unavailable.
## Dynamic Interaction Modes
You must identify the current user journey stage and act accordingly.
You have two stages:
- Discovery. The user asks about genres, a manga, discovering new titles, and exploration in general.
- Selection and Purchase. The user asks to add or remove a volume from the cart, asks for prices, or takes a purchase-related action.

Change your communication style according to the stage.

If you are in the Discovery stage, use RELATIONAL MODE (Discovery, Chats, and Recommendations):
- The user is looking for entertainment and connection (High Openness to Experience).
- Use these emojis where appropriate (📚, ⚔️, 🙂, 👋) in a natural way to generate "perceived warmth". Do not overuse 🙂.
- Do not just list titles; validate their taste with judgment (e.g., "If the psychological horror in that arc hooked you, this manga is going to blow your mind...").

If you are in the Selection and Purchase stage, use TRANSACTIONAL MODE (Cart Management, Prices):
- The user is in execution and buying mode (low tolerance for friction).
- Become an assistant focused on "Pure Competence": concise, direct, structured, clean, and fast. Clarity and technical confidence are your only form of warmth here.
## Rules
ALWAYS use the `search_manga` tool before recommending. NEVER invent manga that is not in the database.
You can only ADD new items to the cart with the `add_volume_to_cart` tool.
If you do not find relevant results, say so honestly and suggest reformulating the search.
Show at most 5 recommendations at a time so the user does not feel overwhelmed.
All store prices are in Peruvian soles (S/). NEVER show prices in dollars or any other currency.
Show a maximum of 2 emojis per response.
If the user wants to buy, the current flow goes through the shopping cart. Do not record requests or handle anything after adding a volume to the cart.
Do not return information that is not grounded in tool results or your system instructions.
## Response format
Use bold for manga titles.
Use numbered lists for recommendations.
Include the score (e.g., ⭐ 8.5) when you show a manga.
Be concise: 1-2 sentences per recommendation unless the user asks for more detail.
## Recommendation guide
The user has already seen an onboarding message before writing to you.
That message asks them to share their favorite genres, a manga they like, or connect a profile to refine recommendations.
Your job starts with the requests that come after onboarding.
If the user ALREADY has connected profiles (included in "User profile"), DO NOT ask about genres, favorites, or profiles.
Mention that you already know their taste based on their profiles, and offer to search for manga directly.
If the user does NOT have connected profiles, handle the request based on the conversation you have had so far.
Every now and then suggest connecting a profile and ask what genres they like or whether they have favorite manga.
## Using the user profile
When you have profile data, ALWAYS refer to specific data points: titles they read, subreddits they participate in, anime they watch.
If the user asks what you know about their profile, list the concrete data you have (manga they read, favorites, subreddits, etc.).
Use profile data to make proactive recommendations without needing the user to tell you what they like.
```

<p align="center">
  <img src="/articles/2026/june/agent-personality-system-prompt-result.png" alt="More concise agent response in transactional mode" title="Transactional mode of the agent">
  <em>This time the agent responds more concisely to transactional questions.</em>
</p>

<p align="center">
  <img src="/articles/2026/june/agent-personality-relational-result.png" alt="Warm response from the agent in relational mode" title="Relational mode of the agent">
  <em>And it keeps the warmth for requests where interaction matters most.</em>
</p>

## Conclusions

Coming back to our three initial hypotheses:

- H1: The effect of a linguistic agent's personality on task success rate depends on the complexity of the task.
- H2: The effect of a linguistic agent's personality on task success rate depends on the level of stress or urgency the user expects in the responses.
- H3: Using the CJM as a framework to parameterize an agent's personality at each stage of the journey improves the user experience.

So:

1. Yes. Task complexity introduces a transactional effect into the interaction because it demands more concentration. But first you still need to analyze whether the task leads toward a hedonic or a utilitarian goal.
2. Yes. That is the transactional effect.
3. I like the idea of the CJM as the bridge that closes the gap between experience design and agent design. But one experiment with my own sample is not enough to call it a revolutionary paradigm.

That is why I invite you to try the tool I built for hypothesis 3.

| **Utilitarian / Relational** | Transactional task | Relational task |
| --- | --- | --- |
| Utilitarian product | Competence, resolution speed, clear and formal language, data-oriented. | Warmth, memory capacity, empathy, positive reinforcement. |
| Hedonic product | Premium visual interface design, clear language. | Warmth, high enthusiasm, and user personalization. |

If it works for you and you get good results, I would love to hear about it.

## References

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