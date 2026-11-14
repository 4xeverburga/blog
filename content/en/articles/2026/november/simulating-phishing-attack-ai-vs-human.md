---
title: 'Simulating a Phishing Attack: AI vs Human'
author:
  name: Ever Burga
  url: https://www.linkedin.com/in/everburga/
cover: /articles/2026/november/doppel-phishing-cover.webp
date: '2026-11-14T10:00:00.000Z'
description: Write-up of the 3b1b/Doppel phishing challenge
layout: article
seo:
  title: Simulating a phishing attack, AI vs human (3b1b/Doppel challenge)
  description: I solved the 3Blue1Brown and Doppel phishing puzzle by hand, then compared it in a simulation against a model's solution.
head:
  meta:
    - name: keywords
      content: phishing, 3blue1brown, doppel, KL divergence, detector, simulation, optimization, ai vs human
---

# Simulating a Phishing Attack: AI vs Human

![Phishing expected payoff vs filter strength, human and AI](/articles/2026/november/doppel-phishing-payoff.gif "Phishing expected payoff vs filter strength")

3Blue1Brown and Doppel published a challenge at [3blue1brown.com/talent](https://www.3blue1brown.com/talent/).

I'm currently studying statistics and information theory. The challenge looked like good practice, so I decided to solve it by hand first.

![Handwritten notes of the solution, page 1 of 7](/articles/2026/november/doppel-phishing-notas.png "Handwritten notes (page 1 of 7)")  ::small
[All pages here](https://github.com/4xeverburga/doppel-phising-strat/tree/main/proofs/jpegraw)
\::

In my solution I assume the defender does not update the phishing filter's parameters. Treating those parameters as variables too would probably open up new lines of research and new information channels, but I don't consider that in this write-up.

## Conclusions

The conclusions of my solution:

- While the attacker is still estimating the parameters $C$ and $f$ (which tokens survive the flags), the best strategy is to send messages with a single malicious phrase/token ($n=1$).
- Once $C$ and $f$ are known, the problem is one of optimization: choose how many times to use each token without exceeding the filter threshold $C$.

Check out the full solution! [Human solution (PDF)](https://github.com/4xeverburga/doppel-phising-strat/blob/main/proofs/pdf/solution_human_en.pdf).

## Simulation

![Divergence budget used by each strategy, by false-positive rate](/articles/2026/november/doppel-phishing-budget.gif "What fraction of the divergence budget each strategy uses")

At a time when AI can reason so impressively, it's easy to lose motivation. I decided to take advantage of that and compare my solution against Fable's, working autonomously on its own proposal ([PDF](https://github.com/4xeverburga/doppel-phising-strat/blob/main/proofs/pdf/solution_ai_en.pdf)).

A must was building an engine with interfaces that cleanly separate what the attacker can learn from what the defender has access to. That keeps the comparison between both strategies fair.

The expected payoff of the phishing messages came out very close, as you saw in the first gif. But Fable found a better strategy for extracting information from the Z-channel of responses to a phishing message.

Would I have gotten better results by letting Fable iterate on the simulation and its results? Or would I have ended up with an overfit model? Hard to say.

The simulation code is at [github.com/4xeverburga/doppel-phising-strat](https://github.com/4xeverburga/doppel-phising-strat).
