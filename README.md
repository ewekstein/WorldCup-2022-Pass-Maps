# 2022 World Cup Final: Pass Reception Heatmaps

**By Elijah Wekstein**  
CU Boulder - Business Analytics and Information Management

---

## Overview

With the 2026 World Cup approaching, I wanted to take a look back at the greatest final in recent memory. Argentina vs. France in Qatar 2022 was a 3-3 thriller settled on penalties. Beyond the scoreline, the pass reception maps from that match tell a fascinating tactical story about how two very different teams tried to win the same game.

**Data source:** [StatsBomb Open Data](https://github.com/statsbomb/open-data) - 2022 FIFA World Cup

---

## Tools

- R (StatsBombR, SBpitch, ggplot2, tidyverse)

---

## Visualizations

### Argentina Pass Reception Map

![Argentina Pass Reception Map](Argentina_PassMap.png)

Argentina came out fast, scoring two first-half goals, which allowed them to settle into a patient possession-based game. The density is spread broadly across their own defensive half and midfield, reflecting a team happy to build slowly and circulate the ball. Their three goals cluster in the upper half of the attacking third, consistent with how they created through that side across the match.

---

### France Pass Reception Map

![France Pass Reception Map](France_PassMap.png)

France's map looks completely different. Because they never led, they were forced into a more aggressive and direct attacking style throughout. The density clusters heavily through the left-center corridor, which is Mbappe's fingerprint on the game - cutting inside from the left wing through the central channel repeatedly. Their three goals land on the upper side of the attacking third, the same zone Mbappe attacked all night.

---

## Key Observations

- **Argentina controlled possession more broadly.** With 560 completed passes vs. France's 434, Argentina circulated the ball patiently across more zones of the pitch.
- **France was more central and direct.** Their pass density funnels through the left-center corridor, reflecting a vertical and transition-oriented approach driven by Mbappe.
- **Game state shaped both maps.** Argentina scoring early gave them the luxury of slower buildup in their own half. France never leading pushed them into a more attacking shape the entire match.
- **Mbappe's influence is visible in the data.** France's entire attacking threat ran through one channel. The pass map and goal locations tell that story clearly without needing a single stat.

---

## Repository Contents

| File | Description |
|------|-------------|
| `WorldCup22Map.R` | R script for data pull, processing, and heatmap generation |
| `Argentina_PassMap.png` | Argentina pass reception heatmap |
| `France_PassMap.png` | France pass reception heatmap |
| `README.md` | Project overview and analysis |

---

## About

**Elijah Wekstein** - [LinkedIn](https://www.linkedin.com/in/elijah-wekstein) | [Portfolio](https://ewekstein.github.io)
