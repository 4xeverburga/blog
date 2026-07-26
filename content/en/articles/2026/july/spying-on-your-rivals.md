---
title: Legally Spying on Your Competition is Possible
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
  avatarUrl: https://www.linkedin.com/
cover: /articles/2026/july/spying-on-your-rivals-cover.svg
date: 2026-07-20T10:00:00.000Z
description: Tracking your competition with open data is a task... not that hard.
layout: article
seo:
  title: Tracking Your Competitors' Users
  description: Tracking your competition with public data is simple.
head:
  meta:
    - name: keywords
      content: crux, http archive, bigquery, competitive analysis, web technologies, wappalyzer, cloudflare r2, data lake, seo, web analytics
---

# Legally Spying on Your Competition is Possible

::div{.hero-breakout}
  :::div{.hero-breakout-inner}
  ![Diagram of the competitor tracking flow using open data](/articles/2026/july/spying-on-your-rivals-hero.svg)
  :::
::

How do you get user data from pages you're interested in monitoring?

By using Google's public data!

You don't need a scraper or expensive Wappalyzer subscriptions.

You just need

- The BigQuery database and API for CrUX.
- The HTTP Archive database in BigQuery.

[theuxreport](https://theuxreport.kekeros.com)


## Architecture Decisions

### First, let's look at the nature of the data sources

The CrUX and HTTP Archive databases are updated monthly. CrUX has a 2-month lag, while HTTP Archive only has a 1-month lag. This difference has an impact on the data analysis. That's why it's worth tagging the provenance month of every piece of data that enters our data lake.

On the other hand, for the end user who just wants to see reports, a 1-month difference doesn't matter much. It could even be read as processing delay or some insignificant offset between the historical charts.

Now, if we focus on data volume, each database uses a field called origin as its identifier, which we can think of as the web domain that serves the content and applications.

Each origin has dozens of columns in total. But at the end of the day, that's a fixed amount of data. This means the data volume grows given the parameters

- N: number of origins to analyze
- T: number of time units to analyze,

... with O(NT) complexity. For my initial list of Peruvian domains I registered 20 thousand domains, and my goal is to keep a 24-week window in the report. I doubt it will exceed 100 thousand domains in the future, so we have a modest volume of data that can be processed on a single node, or my computer.

### Requirements and constraints

Among other more specific requirements,

- I want to store the historical and enrichment data in a format with low storage cost but high data integrity guarantees.
- My reports page must have high availability and deliver a smooth user experience.
- I want to keep maintenance costs to a minimum.

AWS S3 + Athena, GCP BigQuery Iceberg Catalog... there are many solutions on the market. This time I decided to use Cloudflare R2 Data Catalog, with a generous free quota of 10GB of storage and a high number of reads and writes.

As for the site itself, Astro is my preferred choice for these cases. And the CDN will be Cloudflare to keep administration simple.

## Data Transformation

The extraction, filtering, and enrichment stages are straightforward.

However, HTTP Archive doesn't provide normalized technology categories. Since it uses Wappalyzer's signature engine, it just returns whatever categories it detects. You can end up with React.js and Next.js at the same time, even though we know Next.js is a React meta-framework and doesn't exist without it.

### Stage 1: Remapping to Macrocategories

![Diagram of remapping raw categories into normalized macrocategories](/articles/2026/july/spying-on-your-rivals-remapping.svg)*Remapping raw categories into normalized macrocategories.*

Origin\_Technologies comes from R2 with a list of categories per technology. After grouping them we have less complexity to work with. But this is the stage where we do the dirty work.

### Stage 2: Cleaning up ties

![Diagram of the LinearUntie process to collapse technologies tied to the same macrocategory](/articles/2026/july/spying-on-your-rivals-linear-untie.svg)*LinearUntie: collapsing technologies tied to the same macrocategory.*

A single origin can have several technologies for the same category. This is a consequence of what I mentioned before. You can have Next.js and Next App Router classified within the same Web Frameworks category.

To collapse these ties I use a linear ordering of technologies according to category. If I find both Nest.js and Express, Nest.js is the option that encompasses both concepts.

A direct improvement to this model would be to rank not just by category, but by category + framework. But that requires a costly relationship-building task, and there are still exceptions stemming from the very nature of how HTTP Archive generates its data.

Minor exceptions or mis-categorized technologies I add manually to a structure on disk. It's unavoidable work.

## Ranking

Once you have the normalized datasets, ranking becomes a statistics task, and the reports page becomes a design and UI process.

### How to reproduce your `severity` and your `score` with the public CrUX API

theuxreport doesn't make up any number: everything it shows about your Core Web Vitals comes straight from Google's [Chrome UX Report API](https://developer.chrome.com/docs/crux/api) — the same real Chrome user data that PageSpeed Insights uses. You can request that same data from Google with your own API key and land on the exact same `severity`/`score` you see in your report. Here's the formula, step by step.

#### 1. Request your own histogram from CrUX

```bash
curl --request POST \
  'https://chromeuxreport.googleapis.com/v1/records:queryRecord?key=YOUR_API_KEY' \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{"origin":"https://your-domain.pe"}'
```

(Free API key, requested in Google Cloud Console by enabling "Chrome UX Report API".)

The response includes, for each metric, a 3-bin `histogram` — good / needs improvement / poor — each with a `density` (the real fraction of real-user visits in that range, not a synthetic average):

```json
"largest_contentful_paint": {
  "histogram": [
    { "start": 0,    "end": 2500, "density": 0.82 },
    { "start": 2500, "end": 4000, "density": 0.11 },
    { "start": 4000,               "density": 0.07 }
  ],
  "percentiles": { "p75": 2380 }
}
```

The three metrics that matter are `largest_contentful_paint` (LCP), `cumulative_layout_shift` (CLS), and `interaction_to_next_paint` (INP) — Google's three official Core Web Vitals.

#### 2. Calculate the severity of each metric

For each metric, severity is NOT "which band is the majority" — it's an average weighted by the real density of each band:

```
metric_severity = poor × 1.0 + needs_improvement × 0.5 + good × 0.0
```

With the example above: 0.07 × 1.0 + 0.11 × 0.5 + 0.82 × 0.0 = 0.125.

Why weighted instead of "dominant band"? Because an origin with 51% good / 49% needs-improvement and another with 99% good / 1% needs-improvement are very different real stories — collapsing them to the same discrete value erases the variation that genuinely exists between sites.

#### 3. Average the three metrics

```python
def metric_severity(good: float, ni: float, poor: float) -> float:
    return poor * 1.0 + ni * 0.5 + good * 0.0

severity = (
    metric_severity(*lcp_densities)
    + metric_severity(*cls_densities)
    + metric_severity(*inp_densities)
) / 3
```

`severity` ends up between 0 (perfect) and 1 (the worst possible case). If your origin is missing one of the three metrics for this window (CrUX requires a minimum amount of traffic per metric before it publishes it), you simply average whichever ones you do have — my production version imputes the missing metric with that window's Peruvian cohort average instead of ignoring it (so an origin with incomplete data isn't artificially rewarded), but that part does depend on the cohort.

#### 4. Your score

```python
score = round((1 - severity) * 100)
```

With `severity = 0.125`, the score is **87** — the same figure you'd see in your report. This number is 100% reproducible by anyone with nothing but Google's public API: there's no secret ingredient.

#### What actually needs the cohort (and why you can't calculate it alone)

The **percentile** ("better than X% of .pe sites") is different from the score: it's not a formula over your own histogram, it's your position relative to the ~20 thousand real `.pe` origins theuxreport measured with the same method. Google doesn't hand you that list — it's theuxreport's real collection work, not an algorithmic secret. That's the difference between "your number" (reproducible by anyone, today, with a free API key) and "your position" (which requires having measured the whole country with the same yardstick).

I hope you enjoyed the article. Remember I update the site report every month. See you in my analytics metrics soon!

## Collaboration

I plan to open source the project once it reaches a stable stage. If you'd like to contribute a list of URLs you think are worth including, or a metric you'd like to see, reach out to me on my social channels — I'd be glad to hear it.
