# Pre-Analysis Plan

> **This template is for experimentalist projects only.** If the project uses an empiricist or IO personality, use `research_intention.md` instead.

**Project title:** [Title]

**Author(s):** [Author A, Author B, Author C]

---

## 1. Main question or hypothesis

[What is the main question being asked or hypothesis being tested? What gap does this address?]

*Example: We hypothesise that individuals who score higher on agreeableness donate a larger fraction of their endowment to charity. We test whether this relationship holds when controlling for income and social desirability bias.*

## 2. Dependent variables

[Describe the key dependent variable(s) and how they will be measured.]

*Example: The main outcome variable is the fraction of the endowment donated to charity (0–100%). Secondary outcomes include the decision to donate at all (binary) and response time (seconds).*

## 3. Conditions

[How many and which conditions will participants be assigned to?]

*Example: Participants are randomly assigned to one of three conditions: (1) private donation, (2) public donation (other participants observe), and (3) public donation with social norm information. Each participant plays 5 rounds within their assigned condition.*

## 4. Analyses

[Specify exactly which analyses you will conduct to examine the main question/hypothesis.]

*Example: H1 will be tested by comparing mean donation fractions across agreeableness terciles using a Kruskal-Wallis test, with session-level clustering. As a robustness check, we will run OLS regressions with controls for age, gender, and income, clustering standard errors at the session level.*

## 5. Outliers and exclusions

[Describe exactly how outliers will be defined and handled, and your precise rule(s) for excluding observations.]

*Example: No participant who completes the experiment will be excluded. We will winsorise response times at the 1st and 99th percentiles for any analysis that uses response time as an outcome.*

## 6. Sample size

[How many observations will be collected or what will determine sample size?]

*Example: We will collect a minimum of 120 participants (40 per condition). If the budget allows, we will continue up to 180 participants (60 per condition).*

## 7. Other

[Anything else you would like to pre-register? Secondary analyses, exploratory variables, unusual analyses planned?]

*Example: We will explore gender differences in donation behaviour and whether the effect of agreeableness is moderated by condition. We also collect self-reported motivations for donating in an open-ended question at the end of the experiment.*

## 8. Existing data

[Have any data been collected for this study already? If yes, explain.]

*Example: No data have been collected for this study.*

---

## How this file is used

This pre-analysis plan (PAP) captures the core pre-registered commitments of an experimental study. It is the **starting point** for experimentalist projects.

### Agent instructions

1. **Check whether the user has a PAP to upload** (from AsPredicted, OSF, or a PDF). If yes, extract the content and populate this template.
2. **If no PAP exists**, guide the user through creating one by asking questions that follow this template's structure. Use the experimentalist sections of the interview script in `Context/Agents/researcher_interview.md`.
3. **Once this PAP is complete**, proceed to `research_plan.md`. The research plan expands the PAP with theoretical framework, detailed variable definitions, codebook references, timeline, and review gates.

### PAP Readiness Checklist

Before moving on to `research_plan.md`, every item below must be ticked.

- [ ] **Section 1 — Hypothesis**: Contains a falsifiable prediction with expected direction, not just a research question
- [ ] **Section 2 — DVs**: Every dependent variable is named, operationalised (units, scale, measurement method), and unambiguous
- [ ] **Section 3 — Conditions**: Number of arms stated, assignment mechanism specified (between/within, randomisation unit), each condition described
- [ ] **Section 4 — Analyses**: Primary test specified per hypothesis (test name, sidedness, clustering); at least one robustness check specified
- [ ] **Section 5 — Exclusions**: Concrete, verifiable rules (not "outliers will be removed" — instead "observations with response time < 3s will be excluded")
- [ ] **Section 6 — Sample size**: A specific number or stopping rule; ideally supported by a power calculation or budget constraint
- [ ] **Section 7 — Other**: Secondary/exploratory analyses listed, or explicitly stated as "none planned"
- [ ] **Section 8 — Existing data**: Answered yes or no; if yes, explained what data exist and how they relate to this study
- [ ] **No placeholders remain**: Every `[bracketed placeholder]` has been replaced with real content

### Relationship to `research_plan.md`

| Pre-analysis plan | Research plan |
|---|---|
| Core commitments: what you will test, how, and with what data | Full study design: adds theory, detailed variable definitions, timeline, review gates |
| Written before analysis | Updated throughout the project as decisions are made |
| Should not change once data collection begins (deviations logged in `Context/Flow/research_log.md`) | Living document that reflects the current state of the design |
| Answers "what did we commit to?" | Answers "what are we actually doing and why?" |
