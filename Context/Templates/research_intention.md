# Research Intention

> **This template is for empiricist and IO projects.** If the project uses an experimentalist personality, use `pre_analysis_plan.md` instead.

**Project title:** [Title]

**Author(s):** [Author A, Author B, Author C]

**Research personality:** [empiricist / io]

---

## 1. Research question

[What is the main question being asked? What gap in the literature does this address? State at least one testable hypothesis or — for structural work — the key object to be estimated.]

**Empiricist example:** *We test whether the introduction of mandatory cooling-off periods reduces consumer complaint rates in door-to-door sales, exploiting staggered adoption across local authorities as a natural experiment.*

**IO example:** *We estimate the demand for differentiated breakfast cereals using a random-coefficients logit model and simulate the price effects of a proposed merger between two leading manufacturers.*

## 2. Outcome variables

[What are the key dependent variables or objects of interest? How are they measured or constructed?]

**Empiricist example:** *The main outcome is the monthly complaint rate per 1,000 transactions at the local authority level. Secondary outcomes include contract cancellation rates and consumer satisfaction scores.*

**IO example:** *The main outcome is product-level market share (unit sales / market size). Secondary outcomes include retail prices and product availability (entry/exit indicator). Key objects of interest: own-price elasticities, markups, and merger price effects.*

## 3. Identification strategy

[What is the source of identifying variation? What comparison generates causal or structural estimates? What are the key assumptions?]

**Empiricist example:** *We exploit the staggered introduction of cooling-off period legislation across 32 local authorities between 2015 and 2019. Identification comes from a two-way fixed effects difference-in-differences design, comparing complaint rates in treated vs not-yet-treated authorities before and after adoption. Key assumption: parallel trends in complaint rates absent the policy.*

**IO example:** *Demand is identified using BLP-style instruments: characteristics of competing products (number of rival products, mean rival sugar content) and cost shifters (input commodity prices, transportation costs). Supply-side markup equations are identified by assuming Nash-Bertrand pricing. Key assumptions: instruments are excluded from the utility function; firms set prices simultaneously.*

## 4. Data

[What data will be used? Where does it come from? What is the unit of observation, sample period, and scope?]

**Empiricist example:** *Administrative records from the Consumer Protection Agency covering all registered complaints in door-to-door sales across 32 local authorities, January 2013 – December 2021. Unit of observation: authority-month. Approximately 3,456 observations.*

**IO example:** *Nielsen scanner data for branded breakfast cereals at the UPC level in 50 metropolitan markets, 2016Q1–2020Q4. Unit of observation: product-market-quarter. Approximately 45,000 observations. Supplemented with firm-level cost data from Compustat.*

## 5. Empirical approach

[What are the primary specifications? What robustness checks are planned?]

**Empiricist example:** *Primary: two-way FE regression of complaint rates on a treatment indicator (post-adoption × treated authority), with authority and month fixed effects, clustered at the authority level. Robustness: event-study specification for parallel trends; alternative clustering (authority × year); excluding early/late adopters; placebo outcomes.*

**IO example:** *Demand estimation: random-coefficients logit (BLP) via GMM. Supply: recover marginal costs from first-order conditions under Nash-Bertrand. Merger simulation: compute new equilibrium prices under the merged portfolio, holding costs and demand parameters fixed. Robustness: nested logit, alternative instrument sets, alternative market definitions.*

## 6. Sample restrictions and exclusions

[What observations will be excluded and why? How will outliers be handled?]

**Empiricist example:** *Exclude authorities with fewer than 100 transactions per month (insufficient volume). Winsorise complaint rates at the 99th percentile.*

**IO example:** *Drop products with fewer than 50 units sold per quarter. Exclude markets with fewer than 3 active firms. Private-label products excluded from baseline, included as robustness.*

## 7. Secondary and exploratory analyses

[Any additional analyses planned beyond the core question? Label each as planned or exploratory.]

**Empiricist example:** *Heterogeneous effects by authority size and pre-treatment complaint levels (planned). Placebo test on product categories not covered by the legislation (planned). Mediation analysis through contract terms (exploratory).*

**IO example:** *Welfare decomposition: consumer surplus, producer surplus, total welfare under merger (planned). Sensitivity of merger effects to conduct assumption — Bertrand vs Cournot (planned). Entry counterfactual (exploratory).*

## 8. Current state of data and analysis

[Have data been accessed? Has any analysis been conducted? Be transparent about what has and has not been examined.]

**Empiricist example:** *We have downloaded the full administrative dataset but have not examined the dependent variable or run any regressions. Variable definitions were determined from the data documentation before accessing the data.*

**IO example:** *We have access to the full Nielsen scanner dataset. We have examined summary statistics (number of products, market coverage) but have not estimated any demand models or run regressions on the dependent variable.*

---

## How this file is used

This research intention document captures the planned empirical strategy for an empiricist or IO project. It serves a similar role to a pre-analysis plan but is designed for non-experimental research where formal pre-registration is uncommon.

### Agent instructions

1. **Ask the user if they have an existing research intention document** — this could be a grant proposal, working paper draft, internal planning document, or any document that describes the research question, data, and empirical approach.
2. **If the user uploads a document**, extract the relevant information and populate this template.
3. **If no document exists**, guide the user through creating one by asking questions that follow this template's structure. Use the empiricist/IO sections of the interview script in `Context/Roles/researcher_interview.md`.
4. **Once this document is complete**, proceed to `research_plan.md`. The research plan expands the intention with theoretical framework, detailed variable definitions, codebook references, timeline, and review gates.

### Readiness Checklist

Before moving on to `research_plan.md`, every item below must be ticked.

- [ ] **Section 1 — Research question**: Contains a clear question and at least one testable hypothesis or estimation target
- [ ] **Section 2 — Outcomes**: Every outcome variable or object of interest is named, defined, and unambiguous
- [ ] **Section 3 — Identification**: Strategy stated, source of variation described, key assumptions listed. *(IO)* Market definition specified if structural.
- [ ] **Section 4 — Data**: Source, unit of observation, sample period, and approximate size documented
- [ ] **Section 5 — Approach**: Primary specification described; at least one robustness check planned
- [ ] **Section 6 — Exclusions**: Concrete rules for sample restrictions and outlier handling
- [ ] **Section 7 — Secondary**: Additional analyses listed, or explicitly stated as "none planned"
- [ ] **Section 8 — Data status**: Transparency about data access and any analyses already conducted
- [ ] **No placeholders remain**: Every `[bracketed placeholder]` has been replaced with real content

### Relationship to `research_plan.md`

| Research intention | Research plan |
|---|---|
| Core commitments: what you will estimate, how, and with what data | Full study design: adds theory, detailed variable definitions, timeline, review gates |
| Written before or at the start of analysis | Updated throughout the project as decisions are made |
| Deviations logged in `Context/Flow/research_log.md` | Living document that reflects the current state of the design |
| Answers "what do we intend to do?" | Answers "what are we actually doing and why?" |
