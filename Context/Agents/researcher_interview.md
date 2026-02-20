# Researcher Interview Script

## Purpose

This document is a structured interview guide for an AI agent to use when eliciting a research basis document from an economics researcher. For experimentalists, this means a pre-analysis plan (PAP) — populated into `pre_analysis_plan.md`. For empiricists and IO researchers, this means a research intention — populated into `research_intention.md`. The goal is to extract all the information needed with **minimal user burden** and **maximum specificity**.

The agent should think of itself as an experienced co-author who already knows what a good analysis plan looks like and can fill in reasonable defaults, but who needs the researcher to confirm the substantive commitments. The researcher should never feel interrogated — the tone is collaborative, like two colleagues sketching a study on a whiteboard.

## How to use this script

1. **Start with the gateway question** (Section 0) to determine the researcher's personality and starting point.
2. **Work through Sections 1-8 in order**, but allow natural digressions — if the researcher answers a later question early, note it and skip ahead when you get there.
3. **Within each section**, begin with the opening question. Use follow-up probes only when the answer is vague or incomplete. Apply precision checks before marking a section complete.
4. **Track completion** using the criteria listed under each section. Do not move to the next section until the current one meets its completion criteria (or the researcher explicitly defers it).
5. **After all 8 sections are complete**, run the Bridge Section to capture additional information needed for `research_plan.md`.
6. **End with the summary checklist** — read back the full analysis plan to the researcher for confirmation.

### Conventions

Throughout this script:

- **Opening question** = the first question to ask for a given section. Broad, non-leading.
- **Follow-up probe** = a conditional question triggered by a specific type of answer. Indented under decision logic.
- **Precision check** = a question that forces the answer from vague to operationalised. These are non-negotiable before marking a section complete.
- **Example prompt** = a concrete example drawn from behavioural economics or industrial organisation, offered when the researcher seems stuck. Always frame as "For instance..." rather than suggesting it is the right answer.
- Blockquotes (`>`) indicate decision logic for the agent.
- **[EXP]** = applies to experimentalists only. **[EMP]** = applies to empiricists only. **[IO]** = applies to IO only. Unmarked content applies to all personalities.

---

## Section 0: Gateway

**Purpose:** Determine the researcher's personality and starting point so the agent can adapt the interview accordingly.

### Step 1: Personality Selection

"Before we get into the study details, let me understand what kind of project this is. Which of these best describes your work?"

> **Decision logic — personality:**
>
> - **Experimentalist**: The researcher is running a lab, online, or field experiment with random assignment. Identification comes from randomisation. Target journal: JEBO. Use `Context/Roles/profile_experimentalist.md`.
>
> - **Empiricist**: The researcher is working with observational, survey, or administrative data, using quasi-experimental methods for identification (IV, DiD, RDD, matching, event studies). Target journal: JEBO. Use `Context/Roles/profile_empiricist.md`.
>
> - **Industrial Organisation (IO)**: The researcher is working with firm-level, product-level, or market-level data, studying competition, pricing, market structure, entry, mergers, or regulation. Identification comes from structural estimation, reduced-form quasi-experimental methods, or both. Target journals: RAND, JIE, IJIO, JEMS. Use `Context/Roles/profile_io.md`.

If the researcher is uncertain, ask: "Are you randomising participants into conditions, or are you working with existing data where some variation gives you identification?" If they mention firms, markets, or competition, probe: "Is this industrial organisation — studying how firms compete, price, enter markets, or respond to regulation?"

### Step 2: Analysis Plan Requirement

> **Decision logic — analysis plan requirement by personality:**
>
> - **If Experimentalist**: Ask: "Do you have a pre-analysis plan — from AsPredicted, OSF, or elsewhere — that you'd like to upload?" If yes, proceed to Section 0A (extraction mode) and populate `pre_analysis_plan.md`. If no: "No problem — let's create one together." Proceed to Step 3 below and work through all sections, populating `pre_analysis_plan.md`.
>
> - **If Empiricist**: Ask: "Do you have any existing document that describes your research — a grant proposal, working paper draft, or planning document?" If yes, proceed to Section 0A (extraction mode) and populate `research_intention.md`. If no: "Let's build a research intention document together to capture the identification strategy and planned specifications." Proceed to Step 3 below, then through all sections, populating `research_intention.md`.
>
> - **If IO**: Ask: "Do you have any existing document — a grant proposal, working paper, or planning document — that describes the research?" If yes, proceed to Section 0A (extraction mode) and populate `research_intention.md`. If no: "Let's document the economic model, data sources, and planned specifications together." Proceed to Step 3 below, then through all sections, populating `research_intention.md`.

### Step 3: Starting Point

"Tell me briefly what you're working on. Where are you in the process — do you have a study designed, are you still shaping the idea, or have you already collected data?"

> **Decision logic — starting point:**
>
> - **If the researcher has a clear study design** (knows their manipulation/identification strategy, outcome, and population): Proceed to Section 1 in standard mode. The interview will be relatively fast — mostly precision checks.
>
> - **If the researcher has a vague idea but no formal design**: Switch to **ideation mode**. Begin Section 1 with the hypothesis-building variant (see below). Expect to spend more time on Sections 1-3 before the design crystallises.
>
> - **If the researcher has already collected data** (post-hoc analysis plan): Switch to **retrospective mode**. Adapt all questions to past tense. Add the retrospective flag questions listed under each section. The plan will document what the researcher committed to before looking at results, distinguishing pre-specified from post-hoc decisions.
>
> - **If the researcher wants to upload an existing analysis plan** (from AsPredicted, OSF, or another platform): Switch to **extraction mode**. See Section 0A below.
>
> - **If the researcher has multiple studies**: Ask "Which study should we focus on first?" Scope the interview to a single study. Note the others and their approximate designs for later.

### Section 0A: Extraction Mode (uploaded analysis plan)

If the researcher uploads or pastes an analysis plan from another platform, do not interview — extract. Use this checklist:

1. Read the uploaded document in full.
2. For each of the 8 analysis plan sections, check whether the uploaded document contains the required information (see completion criteria under each section below).
3. Copy the relevant content into the corresponding section of the target document — `pre_analysis_plan.md` for experimentalists, `research_intention.md` for empiricists and IO — reformatting as needed to match the template's style.
4. For any section that is missing or incomplete in the uploaded document, flag it and ask the researcher to supply the missing information using the relevant interview questions from this script.
5. Once all 8 sections are populated, read back the full analysis plan for confirmation.

Note: Extraction mode is most common for experimentalists uploading a pre-registered PAP from AsPredicted or OSF, but it can apply to any personality. Empiricists and IO researchers may upload grant proposals, working paper drafts, or internal planning documents that contain the needed information.

**Common gaps in uploaded documents:**
- AsPredicted PAPs often lack precise exclusion rules (Section 5) and specify analyses vaguely (Section 4).
- OSF PAPs sometimes omit sample size justification (Section 6) or bundle multiple studies without scoping clearly.
- PDF PAPs from grant applications often contain theoretical framing but lack operationalised variable definitions (Section 2).
- **[IO]** Working papers or grant proposals often describe the model but omit instrument justifications, market definition boundaries, or planned counterfactual exercises.
- **[EMP]** Empirical papers in draft form may describe the identification strategy but leave robustness specifications vague.

---

## Section 1: Main Question or Hypothesis

**Purpose:** Establish the core research question and at least one falsifiable hypothesis.

### Opening question

"What is the main thing you want to find out? If your study goes perfectly, what would you be able to say at the end that you can't say now?"

### Follow-up probes

> **If the answer is a broad topic** (e.g. "I'm interested in cooperation" or "I want to study fairness" or "I'm looking at market concentration"):

**[EXP/EMP]** "That's a rich area. Can you narrow it down to a specific relationship between two things? For instance, are you asking whether a particular intervention changes cooperation, or whether a particular trait predicts it?"

**[IO]** "That's a rich area. Can you narrow it down to a specific economic relationship? For instance, are you asking whether a merger increased prices, whether entry reduced markups, or whether a regulation changed firm behaviour?"

> **If the answer is a research question but not a hypothesis** (e.g. "I want to know whether framing affects giving" or "I want to estimate the effect of concentration on prices"):

"Good — that gives us the question. Now let's turn it into a prediction. Based on what you know from the literature or your intuition, which direction do you expect the effect to go? Will framing increase giving, decrease it, or do you genuinely have no prediction?"

> **If the researcher genuinely has no directional prediction:**

"That's fine — we'll register it as a two-sided test. But let me push a little: is there a theoretical reason to expect one direction over another? Even a weak prior is worth recording, because it affects whether we use one-sided or two-sided tests, which matters for power."

> **If the answer is already a precise hypothesis** (e.g. "I predict that public commitment increases contributions to a public goods game" or "I predict that the merger increased retail prices by reducing competition"):

Move directly to precision checks.

> **If the researcher is in ideation mode** (vague idea, no formal design):

"Let's work backwards. Imagine you're writing the abstract of the published paper. What's the one-sentence finding? Don't worry about getting it right — we can revise. But having a draft prediction on paper makes everything else easier."

Then help the researcher identify: (a) what varies (the independent variable, manipulation, or source of identifying variation), (b) what it affects (the outcome), and (c) the expected direction.

> **If the researcher has multiple hypotheses:**

"Let's start with the most important one — the hypothesis that, if supported, would make the paper. We'll capture the others too, but let's anchor on the main one first."

Note: Capture all hypotheses, but identify which is primary (H1). Secondary hypotheses can be listed with their own directional predictions. Each hypothesis should be self-contained — a reader should understand the prediction without context.

### Precision checks

- "Can you state the hypothesis as a sentence with a clear direction? Something like: 'X increases/decreases/has no effect on Y'."
- "What is the theoretical or empirical basis for this prediction? Even a one-sentence justification."
- "Is this the main hypothesis, or is there a more central prediction?"
- "Are there any boundary conditions you expect? For example, does the effect only hold for certain subgroups or in certain conditions?"
- **[IO]** "Is the prediction grounded in a specific model of firm behaviour, or is it a reduced-form prediction from the literature?"

### Completion criteria

Section 1 is complete when:

- [ ] There is at least one clearly stated hypothesis with a direction (or an explicit statement that the test is non-directional).
- [ ] The hypothesis names the key independent and dependent variables (even if they are defined precisely in later sections).
- [ ] It is clear which hypothesis is the primary one (if there are multiple).
- [ ] There is at least a brief statement of what gap this addresses or why it matters.

---

## Section 2: Dependent Variables

**Purpose:** Define every outcome variable precisely enough that a different researcher could measure it identically.

### Opening question

**[EXP]** "What exactly are you measuring? Walk me through the main outcome — what does a participant do, or what do you observe, that tells you whether the hypothesis is supported?"

**[EMP]** "What exactly are you measuring? Walk me through the main outcome — what variable in your data tells you whether the hypothesis is supported?"

**[IO]** "What is the main outcome variable? For instance, are you looking at prices, quantities, market shares, entry decisions, markups, or something else? Walk me through what you observe in the data."

### Follow-up probes

> **If the answer is conceptual** (e.g. "generosity", "cooperation", "market power"):

**[EXP/EMP]** "How do you operationalise that? What is the actual number or category that goes into your analysis? For instance, is generosity measured as the amount sent in a dictator game, the proportion of the endowment donated, or something else?"

**[IO]** "How do you operationalise that? For instance, is market power measured as the Lerner index, the HHI, a price-cost margin, or estimated markups from a structural model? What variable in the data captures this?"

> **If the answer names a measure but not its scale or units:**

"What are the units? Is it a continuous amount (e.g. dollars, percentage points), a count, a binary yes/no, or a Likert scale? And what are the endpoints?"

> **If the researcher mentions a composite or index:**

**[EXP/EMP]** "How is the composite constructed? Which items go into it, and how are they combined — simple average, sum, factor score? Are any items reverse-coded?"

**[IO]** "How is the index constructed? For instance, is the HHI computed from revenue shares or quantity shares? At what level of aggregation — product, geographic market, industry? Over what time period?"

> **If there is only one DV mentioned:**

**[EXP]** "Is this the only outcome you care about, or are there secondary outcomes? For example, many experiments also look at response time, whether a decision was made at all (extensive margin), or a self-reported motivation. Even if these are secondary, we should list them."

**[EMP/IO]** "Is this the only outcome you care about, or are there secondary outcomes? For example, you might also look at quantities, product variety, consumer welfare, or distributional effects. Even if these are secondary, we should list them."

> **If the researcher mentions many DVs:**

"Which of these is the primary outcome — the one that the paper lives or dies on? We need to distinguish the primary DV (which drives the headline test) from secondary DVs (which are informative but not the main result). This matters for multiple-testing corrections."

### Precision checks

- "If I gave your instructions to a research assistant, could they calculate this variable from the raw data without asking you any questions? If not, what's ambiguous?"
- "What is the theoretical range of this variable? What is a typical value?"
- **[EXP]** "Is this measured once per participant, or repeatedly (e.g. across rounds)? If repeatedly, how will you aggregate across observations — average, last round, total?"
- **[EMP/IO]** "Is this measured once per unit, or repeatedly over time? If it's panel data, how will you handle the time dimension — fixed effects, first differences, averaged across periods?"
- "Are there any transformations you plan to apply before analysis (e.g. log, standardise, winsorise)?"

### Completion criteria

Section 2 is complete when:

- [ ] Every DV is named and defined with its unit/scale.
- [ ] The primary DV is distinguished from secondary DVs.
- [ ] The measurement procedure is specified (how and when the variable is observed).
- [ ] Any aggregation across repeated observations is specified (if applicable).
- [ ] Planned transformations (if any) are stated.

---

## Section 3: Conditions / Identification Strategy

**Purpose:** Define the experimental conditions or identification strategy, comparison groups, the assignment or variation mechanism, and the unit of analysis.

### Opening question

**[EXP]** "How many groups or conditions are in your study, and what differs between them?"

**[EMP]** "What is your source of identifying variation? What creates the comparison that lets you make a causal claim — or at least a credible association?"

**[IO]** "What is your identification strategy? Are you estimating a structural model, exploiting quasi-experimental variation, or both?"

### Follow-up probes — Experimentalist

> **If the researcher describes a between-subjects design:**

"Good. How are participants assigned to conditions — pure random, stratified, blocked by session, or something else?"

"Is there a control condition? If so, what does the control group experience — nothing, a neutral version of the treatment, or a different treatment?"

> **If the researcher describes a within-subjects design:**

"So each participant experiences multiple conditions. In what order? Is the order counterbalanced or randomised? Could there be order effects or learning, and if so, how will you handle that?"

> **If the design has both between- and within-subjects elements** (mixed design):

"Let's be precise: which factor varies between participants, and which varies within? For the within-subjects factor, how many observations per participant per condition?"

> **If the number of conditions is unclear:**

"Let me make sure I have this right. Can you list each condition with a short label? For example: (1) Control, (2) Low stakes, (3) High stakes. Just the labels for now — we can describe them in detail after."

> **If the researcher is using a factorial design:**

"How many factors, and how many levels per factor? Do you plan to analyse the full factorial (including interactions), or are some cells of secondary interest?"

### Follow-up probes — Empiricist

> **If the researcher describes a difference-in-differences design:**

"What is the treatment event or policy change? When did it occur? Who is in the treated group and who is in the control group? Are the groups defined by geography, eligibility, timing, or something else?"

"Have you thought about parallel trends? Is there a pre-treatment period where you can test whether the groups were trending similarly?"

> **If the researcher describes an instrumental variables strategy:**

"What is the instrument, and what is the endogenous variable? What is the economic argument for why the instrument satisfies the exclusion restriction — i.e. why would it affect the outcome only through the endogenous variable?"

> **If the researcher describes a regression discontinuity:**

"What is the running variable, and what is the cutoff? Is the design sharp or fuzzy? What is the bandwidth you plan to use, and will you test sensitivity to alternative bandwidths?"

> **If the researcher describes matching or selection-on-observables:**

"What variables are you matching on, and what method — propensity score, coarsened exact matching, nearest-neighbour? What is the argument for conditional independence — that once you control for these observables, treatment assignment is as good as random?"

> **If the identification strategy is unclear:**

"Let me put this more directly: if a sceptical reader asked 'Why should I believe this is causal and not just a correlation?', what would you say? What is the source of exogenous variation?"

### Follow-up probes — Industrial Organisation

> **If the researcher is estimating a structural model:**

"Let's pin down the model. What is the economic framework — a demand system (e.g. BLP random coefficients logit), an entry model, an auction model, a dynamic game? What are the key decision-makers, and what is the equilibrium concept (Nash-Bertrand, Nash-Cournot, sequential entry)?"

"What are the main functional-form assumptions? For instance, in a demand model: what is the utility specification, and how is the unobserved heterogeneity distributed?"

"What are the instruments for identification? For demand estimation, are you using BLP-style instruments (characteristics of rival products), cost shifters, or something else? What is the exclusion restriction?"

> **If the researcher is using reduced-form methods for IO questions:**

"What is the source of identifying variation — a policy change, a merger, entry or exit of a competitor, a regulatory shock? How does this create treatment and control groups at the firm or market level?"

"What are the key identification assumptions? For instance, if DiD: are you assuming parallel trends in the outcome across treated and control markets?"

> **If the researcher is combining structural and reduced-form approaches:**

"How do the two approaches relate? Is the reduced-form evidence used to motivate or validate the structural model, or are they addressing different questions?"

> **For all IO researchers — market definition:**

"How do you define the relevant market? What are the product boundaries, geographic boundaries, and time boundaries? Is there ambiguity in market definition, and will you test sensitivity to alternative definitions?"

### Precision checks — all personalities

- **[EXP]** "How many participants per condition do you plan to have?" (This also feeds into Section 6.)
- **[EXP]** "What is the unit of independent observation — the individual participant, a pair, a group, a session? This determines how we cluster standard errors and what counts as an observation in non-parametric tests."
- **[EXP]** "Is the treatment manipulation described precisely enough that another researcher could replicate it? If it involves instructions or stimuli, do you have the exact wording?"
- **[EMP]** "What is the unit of observation in your data, and at what level will you cluster standard errors?"
- **[EMP]** "Can you state the identification assumption in one sentence — the thing that has to be true for your estimate to be causal?"
- **[IO]** "What is the unit of observation — firm, product, market, transaction? At what level are standard errors clustered?"
- **[IO]** "Can you state the key identification assumptions? For structural models, this includes functional-form and distributional assumptions. For reduced-form, this includes the exclusion restriction or parallel-trends assumption."
- "Are there any conditions or comparisons you considered but decided not to include? Worth noting for the 'Other' section."

### Completion criteria

Section 3 is complete when:

- [ ] **[EXP]** Every condition is listed with a clear label and a description of what the participant experiences.
- [ ] **[EXP]** The assignment mechanism is specified (random, stratified, within-subjects, etc.).
- [ ] **[EMP/IO]** The source of identifying variation is clearly stated.
- [ ] **[EMP/IO]** Comparison groups (treated/control, before/after, across markets) are defined.
- [ ] **[EMP/IO]** Key identification assumptions are stated explicitly.
- [ ] **[IO]** For structural models: the economic model, equilibrium concept, and key assumptions are specified.
- [ ] **[IO]** Market definition (product, geographic, temporal boundaries) is stated.
- [ ] The design type is clear (between-subjects, within-subjects, mixed, DiD, IV, RDD, structural, etc.).
- [ ] The unit of independent observation is identified.
- [ ] **[EXP]** For within-subjects designs, the number of observations per participant per condition is stated.

---

## Section 4: Analyses

**Purpose:** Pre-specify the exact statistical tests or estimation methods that will be used to evaluate each hypothesis.

### Opening question

**[EXP]** "For your main hypothesis, what statistical test will you use to evaluate it? If you're not sure, tell me the type of data (continuous, binary, count) and I can suggest options."

**[EMP]** "For your main hypothesis, what is the primary regression specification? Walk me through the dependent variable, the key independent variable, and the controls."

**[IO]** "What is your primary estimation approach — structural estimation, reduced-form regressions, or both? Let's start with the headline specification."

### Follow-up probes — Experimentalist

> **If the researcher names a test clearly** (e.g. "Wilcoxon rank-sum test"):

"Good. A few details: will this be one-sided or two-sided? And what is the unit of observation — individual responses, or averages collapsed to the group/session level?"

> **If the researcher is unsure which test to use:**

Ask these diagnostic questions in sequence:

1. "Is the outcome variable continuous, binary, or a count?"
2. "Are you comparing two groups or more than two?"
3. "Are the observations independent, or is there repeated measurement / clustering?"
4. "Do you have a directional prediction (one-sided) or not (two-sided)?"

Then suggest an appropriate test. For experiments targeting JEBO, the default hierarchy is:
- Two independent groups, continuous outcome: Wilcoxon rank-sum test (primary), OLS with clustered SEs (robustness).
- Two matched groups: Wilcoxon signed-rank test.
- More than two independent groups: Kruskal-Wallis test, with pairwise rank-sum tests for specific comparisons.
- Binary outcome: Fisher's exact test (primary), logit with clustered SEs (robustness).
- Regression-based identification (observational data): OLS/IV/DiD as primary, with robustness via alternative specifications.

> **If the researcher only mentions a regression:**

"Will the regression be the primary test, or is there a non-parametric test that comes first? In experimental economics targeting JEBO, it's conventional to lead with non-parametric tests and use regressions as robustness. But if your identification relies on controls or an instrument, the regression may be the primary test."

### Follow-up probes — Empiricist

> **If the researcher describes a regression specification:**

"Let's write it out precisely. What is the dependent variable? What is the key right-hand-side variable? What controls are included, and what fixed effects? How are standard errors clustered?"

> **If the researcher is using IV:**

"What is the first-stage specification? What first-stage F-statistic do you expect, and will you report it? Will you present the reduced form as well as the 2SLS?"

> **If the researcher is using DiD:**

"Will you show an event-study plot? How many pre-treatment and post-treatment periods are available? Will you use a staggered DiD estimator (e.g. Callaway-Sant'Anna, Sun-Abraham) if treatment timing varies?"

### Follow-up probes — Industrial Organisation

> **If the researcher is doing structural estimation:**

"Let's pin down the estimation method. Are you using maximum likelihood, GMM, simulated method of moments, or something else? If GMM or moments-based: what are the moment conditions?"

"What are your instruments, and what are the exclusion restrictions? For demand estimation, are you using BLP instruments (sums of rival characteristics), Hausman instruments (prices in other markets), cost shifters, or differentiation IVs?"

"What counterfactual exercises do you plan to run? For example: simulating a merger, removing a product, changing a regulation. What assumptions are maintained in the counterfactual, and what is allowed to change?"

"How will you assess model fit? Will you compare predicted versus actual shares, prices, or other moments? Will you hold out moments for validation?"

> **If the researcher is doing reduced-form IO:**

"What is the primary regression specification? Walk me through the dependent variable, the key independent variable, controls, and fixed effects."

"At what level are standard errors clustered? For market-level data, common choices include market, firm, or region-by-time. What is the appropriate level given your identification strategy?"

### Follow-up probes — all personalities

> **If the researcher has multiple hypotheses:**

"Let's map each hypothesis to its test. Can you tell me: for H1, the test is ___; for H2, the test is ___; and so on."

> **If the researcher mentions regressions with controls:**

"Which controls will you include, and why? The analysis plan should list them. Are they demographics, experimental features, market characteristics, or theoretically motivated covariates?"

Note: Control variable details feed into the Bridge Section, but the analysis plan should at minimum list which controls appear in the primary specification.

> **If the researcher does not mention robustness checks:**

"What robustness checks are you planning? Common ones include: alternative variable definitions, including/excluding controls, winsorising outliers, alternative clustering levels, or restricting the sample. Even one or two planned robustness checks strengthen the analysis plan."

**[IO]** Additional robustness probes: "Will you test sensitivity to alternative market definitions? Alternative instruments? Alternative functional forms in the demand or cost specification?"

> **If the researcher mentions multiple-testing corrections:**

"Which correction method will you use — Bonferroni, Holm, Benjamini-Hochberg, or something else? And which family of tests does it apply to — all hypothesis tests, or only the secondary outcomes?"

### Precision checks

- "For each test, confirm: (a) the exact test name or estimation method, (b) one-sided or two-sided, (c) the unit of observation, (d) any clustering."
- "If you are using regressions, what is the exact specification? Write it as: Y = f(X1, X2, ...) with standard errors clustered at ___."
- **[IO]** "If structural: state the estimation method, the moment conditions or likelihood, the instruments, and the planned counterfactuals."
- "Is there a pre-specified significance level? (The convention is alpha = 0.05, but confirm.)"
- "Will you report exact p-values or rely on significance stars? (JEBO convention: exact p-values in prose, stars in regression tables. IO journal conventions vary — confirm with target journal.)"

### Completion criteria

Section 4 is complete when:

- [ ] Every hypothesis has a named statistical test or estimation method.
- [ ] Sidedness (one-sided or two-sided) is specified for each test.
- [ ] The unit of observation and clustering level are specified.
- [ ] At least one robustness check is described.
- [ ] If regressions are used, the specification is written out (DV, IVs, controls, clustering).
- [ ] **[IO]** If structural: estimation method, instruments, and planned counterfactuals are specified.
- [ ] Any multiple-testing correction is specified (or an explicit statement that none is planned).

---

## Section 5: Outliers and Exclusions

**Purpose:** Define, before seeing the data, exactly which observations will be excluded and how outliers will be handled. This is one of the most important sections of the analysis plan because it constrains researcher degrees of freedom.

### Opening question

**[EXP]** "Under what circumstances would you drop a participant or an observation from the analysis? Think about things like: they didn't finish, they clearly didn't understand the task, or their data looks implausible."

**[EMP]** "What are your sample restrictions? Which observations will be excluded from the analysis, and what rules determine the analysis sample?"

**[IO]** "What are your sample restrictions? How do you define the boundaries of your data — which markets, firms, products, and time periods are included, and which are excluded?"

### Follow-up probes — Experimentalist

> **If the researcher says "no exclusions":**

"That's a strong commitment — good. Just to be safe: what if someone completes only half the experiment and leaves? What if someone enters clearly nonsensical responses (e.g. types random characters in a free-text field, or gives the same answer to every question on a scale)? Would you still include them?"

> **If the researcher lists vague criteria** (e.g. "participants who didn't pay attention"):

"How will you determine whether someone paid attention? Is there an attention check, a comprehension quiz, a minimum time threshold? We need a rule that doesn't require judgement — something a research assistant could apply mechanically."

> **If the researcher mentions attention checks or comprehension questions:**

"How many attempts do participants get? Is it pass/fail on the first try, or do they get to retry? And what is the consequence — exclusion from the analysis entirely, or just from the affected task?"

> **If the researcher mentions outlier treatment:**

"How will you define outliers? Common approaches include: more than 3 standard deviations from the mean, below/above a fixed threshold, or values in the top/bottom 1%. Which will you use, and will you exclude outliers entirely or winsorise them?"

> **If the researcher has not mentioned response time:**

"Will you impose any restrictions based on response time? For example, excluding decisions made in under 3 seconds (likely random clicking) or over 5 minutes (likely distracted)?"

> **If the researcher is running an online experiment:**

"Any platform-specific exclusions? Common ones include: duplicate IP addresses, VPN/proxy detection, failing a bot check, or completing the study on a mobile device when the task requires a desktop."

> **If the researcher mentions a sequential or multi-round task:**

"If a participant is excluded, are all their rounds excluded, or only specific ones? If they drop out partway through, do you keep their completed rounds or exclude them entirely?"

### Follow-up probes — Empiricist

> **If the researcher describes sample restrictions vaguely:**

"Let's make the inclusion criteria mechanical. Can you state each rule as: 'Include observation if [condition]'? For example: 'Include if the individual was employed in both the pre- and post-period' or 'Include if the firm has at least 3 years of data.'"

> **If the researcher has not mentioned outliers:**

"How will you handle extreme values? Will you winsorise, trim, or leave them as-is? If winsorising, at what percentile?"

> **If the researcher has not mentioned missing data as an exclusion issue:**

"What about observations with missing values on key variables — are they dropped listwise, or will you impute? If dropped, do you have a sense of how much missingness to expect?"

### Follow-up probes — Industrial Organisation

> **If market definition boundaries are unclear:**

"Let's be precise about market boundaries. What defines a market in your data — a geographic area, a product category, an industry code? Where exactly do you draw the line? For instance, if you're studying the beer market, does that include craft brewers? Imports? Non-alcoholic beer?"

> **If the researcher has not mentioned minimum observation thresholds:**

"Will you impose minimum thresholds for inclusion? For instance: a minimum number of products per market, a minimum number of periods per firm, or a minimum market size. These are common in IO to avoid noisy estimates from thin markets."

> **If private-label or store-brand treatment is unclear** (for consumer goods IO):

"How will you treat private-label or store-brand products? Include them, exclude them, or aggregate them? This can materially affect market share calculations and demand estimates."

> **If geographic or temporal scope is unclear:**

"What is the geographic scope — national, regional, specific metro areas? And what is the time period? Are there any subperiods you'll exclude (e.g. a financial crisis, a data-quality break)?"

> **If the researcher has not mentioned firm/product entry and exit:**

"How will you handle entry and exit? If a firm or product appears in only some periods, do you include those observations, require balanced panels, or handle it some other way?"

### Precision checks — all personalities

- "Let me read back your exclusion rules as a numbered list. Can you confirm each one?"
- "Are these exclusion rules applied before or after the main analysis? In other words, do they define the analysis sample, or are they a sensitivity check?"
- "For each rule, what is the expected number or percentage of exclusions? We don't need an exact number, but a ballpark helps sanity-check the sample size."
- "Are there any exclusion rules that you might apply but are not yet committed to? If so, we should list them as contingent or sensitivity-check exclusions."

### Retrospective mode addition

> **If the researcher has already collected data:**

"Have you already looked at the data? If so, have any of these exclusion rules been informed by what you saw? It's important to be transparent about which rules were specified before versus after seeing the data. We can document both — pre-specified rules go in the analysis plan, and post-hoc rules get flagged as deviations in the research log."

### Completion criteria

Section 5 is complete when:

- [ ] Every exclusion rule is stated precisely enough for mechanical application (no subjective judgement required).
- [ ] Outlier treatment is specified: definition, method (exclude vs. winsorise vs. trim), and which variables it applies to.
- [ ] The expected impact on sample size is roughly estimated.
- [ ] **[EXP]** For online experiments: platform-specific exclusions are addressed.
- [ ] **[IO]** Market definition boundaries are specified (product, geographic, temporal).
- [ ] **[IO]** Minimum observation thresholds are stated (or explicitly set to none).
- [ ] **[IO]** Treatment of private labels, entry/exit, and scope restrictions is addressed (where applicable).
- [ ] It is clear whether exclusions define the analysis sample or are sensitivity checks.

---

## Section 6: Sample Size

**Purpose:** Commit to a sample size or describe what determines the sample, ideally with a power calculation or a discussion of statistical precision.

### Opening question

**[EXP]** "How many participants are you planning to collect, and how did you arrive at that number?"

**[EMP/IO]** "What determines your sample size? Is it fixed by data availability, or do you have discretion over the sample scope?"

### Follow-up probes — Experimentalist

> **If the researcher gives a number with no justification** (e.g. "about 200"):

"Where does that number come from — convention, budget, a power calculation, or a prior study? Any of those is fine, but we should document it."

> **If the researcher says "as many as I can get" or "it depends on the budget":**

"Understood — budgets are real constraints. Can we set a minimum and a maximum? For example: 'We will collect at least 120 participants. If resources allow, we will continue up to 200.' That way the analysis plan has a commitment without being unrealistic."

> **If the researcher has not done a power calculation:**

"Would you like to do a quick power calculation? I can help. I need three things: (a) the smallest effect size you'd consider meaningful (not the one you hope for — the one that would still be interesting if that's all there is), (b) your significance level (usually 0.05), and (c) your desired power (usually 0.80). If you don't know the effect size, we can work from a prior study or from conventions in your field."

> **If the researcher wants help estimating the effect size:**

"A few approaches: (1) Is there a closely related prior study? If so, what effect did they find? We could power for 50-75% of their effect as a conservative estimate. (2) For common behavioural economics paradigms, typical effect sizes are: dictator game framing effects d = 0.3-0.5, public goods contribution differences between conditions d = 0.3-0.6, risk-preference treatment effects d = 0.2-0.4. Does any of that sound like your setting?"

> **If the researcher mentions a specific power calculation tool:**

"Great — can you share the inputs and the result? I want to record: the effect size, alpha, power, test type, and resulting N."

> **If the researcher has multiple conditions:**

"Is that N total or N per condition? And is the allocation balanced (equal N per condition) or unbalanced?"

### Follow-up probes — Empiricist / IO

> **If the sample is fixed by data availability:**

"Since the sample is determined by the data, let's document what you have. What is the total number of observations? What determines the sample — all records from a given period, all firms in a given market, all transactions above a threshold? What is the effective sample size after your exclusion rules?"

> **If the researcher has discretion over scope** (e.g. choice of time period, geographic coverage, market breadth):

"What are you choosing, and on what basis? For instance, are you using all available years, or restricting to a specific window? Are you using all markets or a subset? Document the rationale — a reviewer will ask why you didn't include more or fewer observations."

> **If the researcher has not discussed statistical power or precision:**

"Given your sample size, do you have a sense of the minimum detectable effect? Even a rough calculation is useful — it tells the reader what your analysis can and cannot detect. If you're not sure, we can work through it."

**[IO]** "For structural estimation, power calculations are less standard, but it's worth discussing precision. Are there markets or products with very few observations that might give you noisy estimates? Will you report standard errors or confidence intervals for key parameters like elasticities or markups?"

> **If the data is a panel:**

"How many cross-sectional units (firms, markets, individuals) and how many time periods? The effective sample size for clustering depends on the number of clusters, not the total number of observations."

### Precision checks — all personalities

- **[EXP]** "To confirm: the planned sample size is ___ [total / per condition]. Is that the number before or after expected exclusions?"
- **[EXP]** "Is there a stopping rule? For example: 'We will stop at exactly 150' or 'We will collect in batches of 30 and stop when we reach at least 120.'"
- **[EXP]** "If the actual sample differs from the target (e.g. fewer show up, more fail attention checks than expected), what will you do?"
- **[EMP/IO]** "To confirm: the sample contains approximately ___ observations, covering ___ [units] over ___ [time period]. Is the sample likely to change (e.g. data updates, additional years becoming available)?"
- **[EMP/IO]** "How many clusters do you have for standard-error purposes? A small number of clusters (under ~50) may require adjustments."

### Completion criteria

Section 6 is complete when:

- [ ] **[EXP]** A target sample size is stated (total and per condition).
- [ ] **[EMP/IO]** The sample size is described and what determines it is documented.
- [ ] The basis for the number is documented (power calculation, budget constraint, convention, or data availability).
- [ ] If a power calculation was done: effect size, alpha, power, and test type are recorded.
- [ ] **[EXP]** Any stopping rule or sequential analysis plan is stated.
- [ ] **[EMP/IO]** The number of clusters and effective degrees of freedom are noted.
- [ ] It is clear whether the number is pre- or post-exclusion.

---

## Section 7: Other (Secondary Analyses, Exploratory)

**Purpose:** Capture anything the researcher wants to pre-specify beyond the core hypotheses — secondary analyses, exploratory questions, additional measures collected, or unusual methodological choices.

### Opening question

"Is there anything else you plan to analyse that we haven't covered? This could be secondary hypotheses, subgroup analyses, mediation, moderation, or exploratory questions you want to flag."

### Follow-up probes

> **If the researcher says "no, that's everything":**

**[EXP]** "A few things that often come up: (a) Do you plan to test for heterogeneous treatment effects by gender, age, risk attitudes, or any other moderator? (b) Are you collecting any survey measures at the end (demographics, personality scales, manipulation checks, self-reports) that might be analysed? (c) Is there a learning or order effect you plan to examine?"

**[EMP]** "A few things that often come up: (a) Do you plan to test for heterogeneous effects by subgroup (e.g. by region, income, demographic group)? (b) Are there mechanism or mediation tests you might explore? (c) Will you do any falsification or placebo tests beyond the main robustness checks?"

**[IO]** "A few things that often come up: (a) Do you plan to examine heterogeneity by market type, firm size, or product category? (b) Are there additional counterfactual exercises beyond the main ones — for instance, simulating different merger remedies, different regulatory regimes, or hypothetical entry? (c) Will you decompose welfare effects into consumer surplus, producer surplus, and total surplus?"

> **If the researcher mentions mediation or moderation:**

"For mediation: what is the proposed mediator, and what method will you use (Baron-Kenny, causal mediation analysis, something else)? For moderation: what is the moderator variable, and how will you test the interaction — by splitting the sample or including an interaction term?"

> **If the researcher mentions exploratory analyses:**

"Good — flagging these as exploratory is exactly what the analysis plan is for. We'll label them clearly so there's no confusion about what was pre-specified versus exploratory. Is there a specific analysis you have in mind, or is this more of a 'we'll look at the data and see what's interesting' situation?"

> **If the researcher is collecting data they won't use in the primary analysis:**

"Worth noting what you're collecting and why, even if you won't analyse it in the main paper. It protects you from the accusation that you selectively reported measures."

### Precision checks

- "For each secondary or exploratory analysis, can you briefly state: (a) what you're testing, (b) how, and (c) whether you consider it pre-specified or exploratory?"
- "Are any of these analyses conditional on the primary results? For example: 'We will only test for mediation if H1 is supported.'"

### Completion criteria

Section 7 is complete when:

- [ ] All secondary hypotheses or analyses are listed (even if briefly).
- [ ] Each is labelled as pre-specified secondary or exploratory.
- [ ] Additional measures collected but not analysed are noted.
- [ ] Conditional analyses (if any) state their trigger condition.
- [ ] If there is genuinely nothing to add, an explicit "None" is recorded.

---

## Section 8: Existing Data

**Purpose:** Disclose whether any data relevant to this study have already been collected, observed, or accessed by the researcher.

### Opening question

**[EXP]** "Have you collected, accessed, or looked at any data related to this study? This includes pilot data, prior waves of the same experiment, or administrative data you've already downloaded."

**[EMP/IO]** "Have you already accessed or examined the data you plan to use? If so, have you looked at the key outcome variables or run any preliminary analyses?"

### Follow-up probes

> **If the researcher says "no":**

"Perfect. We'll record that no data have been collected or accessed."

> **If the researcher has pilot data:**

"How many participants were in the pilot? Did you look at the results? If so, did the pilot results influence your hypothesis, your design, your chosen sample size, or your exclusion rules? Any of these is fine — we just need to document it."

> **If the researcher has already collected the full dataset:**

"This is a retrospective analysis plan. Let's be transparent about that. Key questions: (a) Have you already looked at the main outcome variable? (b) Have you run any analyses? (c) Which decisions in this analysis plan were made before versus after seeing data? We'll flag any post-hoc decisions clearly."

> **If the researcher has access to a related dataset** (e.g. an earlier wave, a similar study by a co-author, a different market):

"Has that dataset informed your hypotheses, variable definitions, or analysis choices? If so, we should note that. It's not a problem — it's standard practice to build on prior work — but transparency matters."

> **If the researcher has simulated data:**

"Have you tested your analysis pipeline on simulated or synthetic data? That's great practice. Did anything you learned from the simulation change your design or analysis plan?"

> **[IO]** If the researcher has worked with similar data in a previous paper:**

"Have you used the same data source, market, or time period in prior published work? If so, note which variables or findings from that work informed the current study's design."

### Precision checks

- "Can you characterise the state of the data using one of these categories? (a) No data exist. (b) Data exist but I have not accessed them. (c) Data exist and I have accessed them but not analysed the dependent variable. (d) Data exist and I have analysed them, including the dependent variable."
- "If data exist, how many observations, and what is the overlap with the planned study?"

### Retrospective mode addition

> **If the researcher is writing a post-hoc analysis plan:**

"Let's be especially careful here. I'll ask you about each section: was this decision made before or after you saw the data? There's no judgement — post-hoc analysis plans are common and useful — but the documentation must be honest. We'll mark each section as 'pre-specified' or 'post-hoc' so that readers can calibrate."

Work through each section (hypotheses, DVs, conditions/identification, analyses, exclusions, sample) and ask: "Was this decided before or after you had access to the data?" Record the answer in the analysis plan.

### Completion criteria

Section 8 is complete when:

- [ ] The existence or non-existence of data is clearly stated.
- [ ] If data exist: the nature of the data (pilot, partial, full), the sample size, and whether results have been examined are documented.
- [ ] For retrospective analysis plans: each section is marked as pre-specified or post-hoc.

---

## Bridge Section: Beyond the Analysis Plan

**Purpose:** After the analysis plan is complete, elicit additional information needed for `research_plan.md` that is not covered by the 8 analysis plan sections. This information is not pre-registered — it is planning and framing.

### B1: Theoretical Framework

"Now that the analysis plan is done, let's talk about the 'why.' What is the theoretical framework behind this study? Which theories or models generate the predictions you've registered?"

Follow-up probes:
- **[EXP/EMP]** "Is there a specific model (e.g. Fehr & Schmidt inequality aversion, dual-process theory, social identity) that your hypothesis derives from?"
- **[IO]** "Is there a specific IO model that motivates the analysis — for instance, a Cournot or Bertrand oligopoly model, a Hotelling model of differentiation, a free-entry model, or a model of vertical contracting?"
- "Are you testing a theory, extending it, or pitting two theories against each other?"
- "What are the two or three most important papers that this study builds on?"

### B2: Control Variables and Justification

"Which control variables will you include in your regression specifications, and why?"

Follow-up probes:
- "For each control, is the justification empirical (commonly used in the literature), theoretical (the variable is a known confounder), or practical (it was collected and might reduce noise)?"
- "Are there any controls you considered but decided against? Why?"
- **[EXP/EMP]** "Are the controls measured before or after the treatment? Post-treatment controls can introduce bias — is that a concern here?"
- **[IO]** "Are you controlling for market-level characteristics (size, concentration, entry barriers)? Time-varying versus time-invariant controls? Fixed effects at what level (firm, market, product, time)?"

### B3: Robustness Strategy

"Let's map out your primary specification versus your robustness checks. What is the headline test, and what are the alternatives?"

Follow-up probes:
- "If the primary result holds but a robustness check doesn't, how will you interpret that?"
- "Are any robustness checks designed to address specific reviewer concerns you anticipate?"
- "Do you plan to present robustness checks in the main text or the appendix?"
- **[IO]** "Will you test sensitivity to alternative market definitions, alternative instruments, or alternative functional forms?"

### B4: Test Sidedness

"Let's go through each hypothesis and confirm the sidedness."

For each hypothesis:
- "Is your prediction directional (one-sided) or non-directional (two-sided)?"
- "If directional, what would it mean for the effect to go in the opposite direction? Would that be theoretically interesting or just noise?"
- "Note: one-sided tests give you more power but commit you to ignoring effects in the unexpected direction. Are you comfortable with that?"

### B5: Missing Data Strategy

"How will you handle missing data?"

Follow-up probes:
- "Is missingness likely to be random, or could it be related to the treatment (e.g. differential attrition)?"
- "Will you use complete cases only, imputation, or inverse probability weighting?"
- "Is there a threshold of missingness above which you would flag a concern? For example, if more than 10% of observations are missing on the primary DV, would that change your approach?"
- **[IO]** "Are there systematic gaps in the data — for instance, private firms not reporting, small firms below a reporting threshold, or missing cost data? How will you handle these?"

### B6: Power Calculation Details

If the power calculation was only briefly discussed in Section 6, expand here:

**[EXP]**
- "What tool or software did you use for the power calculation?"
- "What is the assumed distribution of the outcome variable?"
- "Did you account for clustering in the power calculation?"
- "If the study involves repeated measures, did the power calculation incorporate the expected within-subject correlation?"
- "What is the minimum detectable effect size at your planned N and power?"

**[EMP/IO]** If a power or precision analysis was discussed:
- "What tool or method did you use?"
- "Did you account for clustering and the number of clusters?"
- "What is the minimum detectable effect size given your sample?"
- **[IO]** "For structural estimation, did you assess the precision of key parameters (e.g. via Monte Carlo simulation or asymptotic standard errors from a similar specification)?"

### B7: Design Type

"One final classification question for the research plan: which personality profile best fits this project?"

> **If Experimentalist:** The project will use `Context/Roles/profile_experimentalist.md`. Non-parametric tests are the primary evidence; regressions are robustness. Target journal: JEBO.
>
> **If Empiricist:** The project will use `Context/Roles/profile_empiricist.md`. Regressions are the primary evidence; robustness via alternative specifications and placebo tests. Target journal: JEBO.
>
> **If IO:** The project will use `Context/Roles/profile_io.md`. Structural estimation and/or regression-based methods are the primary evidence; robustness via alternative specifications, market definitions, and instruments. Target journals: RAND, JIE, IJIO, JEMS. Confirm the specific target journal.

---

## Summary and Confirmation

Once all sections (1-8 plus Bridge) are complete, read back the full analysis plan to the researcher in a structured summary. Use the appropriate format based on personality.

---

### Experimentalist Summary Format

**Analysis Plan Summary for [Project Title]**

**H1:** [Main hypothesis, direction, and key variables]

**Primary DV:** [Name, operationalisation, scale]
**Secondary DVs:** [List]

**Conditions:** [Number and labels]
**Assignment:** [Mechanism]
**Unit of observation:** [Individual / group / session]

**Primary test:** [Test name, sidedness, clustering]
**Robustness:** [Test name(s)]
**Controls:** [List]

**Exclusions:** [Numbered list of rules]
**Outlier treatment:** [Method and scope]

**Sample size:** [N total, N per condition, justification]

**Secondary/exploratory analyses:** [List]

**Existing data:** [Status]

---

### Empiricist Summary Format

**Analysis Plan Summary for [Project Title]**

**H1:** [Main hypothesis, direction, and key variables]

**Primary DV:** [Name, operationalisation, unit]
**Secondary DVs:** [List]

**Identification strategy:** [DiD / IV / RDD / matching / other]
**Source of variation:** [What creates the comparison]
**Comparison groups:** [Treated vs control, or equivalent]
**Key identification assumption:** [One sentence]
**Unit of observation:** [Individual / firm / region-time]

**Primary specification:** [Regression equation, clustering]
**Robustness:** [Alternative specifications, placebo tests]
**Controls:** [List with justification]

**Exclusions:** [Numbered list of rules]
**Outlier treatment:** [Method and scope]

**Sample:** [N observations, N clusters, time period, data source]

**Secondary/exploratory analyses:** [List]

**Existing data:** [Status]

---

### IO Summary Format

**Analysis Plan Summary for [Project Title]**

**H1:** [Main hypothesis, direction, and key variables]

**Primary DV:** [Name, operationalisation, unit]
**Secondary DVs:** [List]

**Approach:** [Structural / reduced-form / both]
**Economic model:** [Model name, equilibrium concept, key assumptions] (if structural)
**Identification strategy:** [Source of variation, instruments, exclusion restrictions]
**Market definition:** [Product, geographic, and temporal boundaries]
**Unit of observation:** [Firm / product / market / transaction]

**Primary estimation:** [Method, specification, clustering]
**Instruments:** [List with exclusion restriction justification] (if applicable)
**Counterfactuals:** [Planned exercises] (if structural)
**Robustness:** [Alternative specifications, market definitions, instruments]
**Controls / fixed effects:** [List]

**Exclusions:** [Numbered list of rules, including market-definition boundaries]
**Minimum thresholds:** [Firm/product/market observation thresholds]
**Outlier treatment:** [Method and scope]

**Sample:** [N observations, N markets/firms, time period, data source]

**Secondary/exploratory analyses:** [List]

**Existing data:** [Status]

---

Ask: "Does this accurately capture your study? Is there anything you'd change, add, or correct?"

Once confirmed, populate the target document: `pre_analysis_plan.md` for experimentalists, `research_intention.md` for empiricists and IO.

---

## Completion Checklist

Use this checklist to verify that the analysis plan is complete before writing it to the file.

### Analysis plan sections

- [ ] **Section 1 (Hypothesis):** At least one falsifiable hypothesis with direction, named variables, and a gap statement.
- [ ] **Section 2 (DVs):** All outcomes named, defined, scaled, with primary vs. secondary distinguished.
- [ ] **Section 3 (Conditions / Identification):** [EXP] All conditions listed and described; assignment mechanism and design type specified. [EMP/IO] Identification strategy, comparison groups, and key assumptions stated. [IO] Market definition specified.
- [ ] **Section 4 (Analyses):** Every hypothesis mapped to a test or estimation method; sidedness, clustering, and robustness specified. [IO] Instruments and counterfactuals specified if structural.
- [ ] **Section 5 (Exclusions):** All exclusion rules stated mechanically; outlier treatment defined. [IO] Market boundaries and observation thresholds specified.
- [ ] **Section 6 (Sample size):** [EXP] Target N stated with justification; stopping rule if applicable. [EMP/IO] Sample described with determinants documented; clusters and effective degrees of freedom noted.
- [ ] **Section 7 (Other):** Secondary and exploratory analyses listed, or explicit "None."
- [ ] **Section 8 (Existing data):** Data status disclosed; retrospective flags if applicable.

### Bridge sections (for research plan)

- [ ] **B1:** Theoretical framework and key references identified.
- [ ] **B2:** Control variables listed with justification.
- [ ] **B3:** Primary vs. robustness specification hierarchy established.
- [ ] **B4:** Sidedness confirmed for each hypothesis.
- [ ] **B5:** Missing data strategy stated.
- [ ] **B6:** Power calculation details recorded (if applicable).
- [ ] **B7:** Design type confirmed (experimentalist, empiricist, or IO) and target journal noted.

### Process checks

- [ ] All sections meet their completion criteria.
- [ ] The full analysis plan has been read back to the researcher and confirmed.
- [ ] The target document has been populated (`pre_analysis_plan.md` for experimentalists, `research_intention.md` for empiricists/IO).
- [ ] Bridge section answers have been noted for transfer to `research_plan.md`.
