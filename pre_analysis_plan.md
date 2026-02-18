# Pre-Analysis Plan

**Project title:** [How nice people give more to charity]

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

This pre-analysis plan (PAP) is the **starting point** for the project. It captures the core commitments of the study before analysis begins.

### If you are the first agent on a new project:

1. **Check whether this file has been filled in** (i.e. the placeholders above have been replaced with real content).
   - **If yes**: Read it carefully. Use the information here to populate `research_plan.md` — the PAP answers inform the Research Idea, Hypotheses, Variables, Design, Sample, and Analysis Strategy sections. Ask the user targeted follow-up questions to fill in gaps (e.g. theoretical framework, control variables, specific statistical tests, robustness strategies) that the PAP doesn't cover but the research plan needs.
   - **If no (still placeholders)**: Guide the user through completing the PAP by asking questions that follow this template's structure (main hypothesis, DVs, conditions, analyses, exclusions, sample size, secondary analyses, existing data). Only move on to `research_plan.md` once every section has real content.

2. **If the user uploads a PAP file** (e.g. from AsPredicted, OSF, or a PDF): Read the uploaded file, extract the relevant information, and populate this template with that content. Then proceed as above.

3. **Only once this PAP is complete** should you begin filling in `research_plan.md`. The research plan is a superset of the PAP — it adds theoretical framework, detailed variable definitions, codebook references, timeline, and gate descriptions that the PAP doesn't cover.

### PAP Readiness Checklist

Before moving on to `research_plan.md`, every item below must be ticked. If any item is unticked, the PAP is incomplete — go back and fill in the missing section.

- [ ] **Section 1 — Hypothesis**: Contains a falsifiable prediction with expected direction, not just a research question
- [ ] **Section 2 — DVs**: Every dependent variable is named, operationalised (units, scale, measurement method), and unambiguous
- [ ] **Section 3 — Conditions**: Number of arms stated, assignment mechanism specified (between/within, randomisation unit), each condition described
- [ ] **Section 4 — Analyses**: Primary test specified per hypothesis (test name, sidedness, clustering); at least one robustness check specified
- [ ] **Section 5 — Exclusions**: Concrete, verifiable rules (not "outliers will be removed" — instead "observations with response time < 3s will be excluded")
- [ ] **Section 6 — Sample size**: A specific number or stopping rule; ideally supported by a power calculation or budget constraint
- [ ] **Section 7 — Other**: Secondary/exploratory analyses listed, or explicitly stated as "none planned"
- [ ] **Section 8 — Existing data**: Answered yes or no; if yes, explained what data exist and how they relate to this study
- [ ] **No placeholders remain**: Every `[bracketed placeholder]` has been replaced with real content

Only once all boxes are ticked should the agent proceed to `research_plan.md`.

### Relationship to `research_plan.md`

| Pre-analysis plan | Research plan |
|---|---|
| Core commitments: what you will test, how, and with what data | Full study design: adds theory, detailed variable definitions, timeline, review gates |
| Written before analysis | Updated throughout the project as decisions are made |
| Should not change once data collection begins (deviations logged in `Context/Flow/research_log.md`) | Living document that reflects the current state of the design |
| Answers "what did we commit to?" | Answers "what are we actually doing and why?" |
