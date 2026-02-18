# Researcher Interview Script

## Purpose

This document is a structured interview guide for an AI agent to use when eliciting a Pre-Analysis Plan (PAP) from a behavioural economics researcher. The goal is to extract all the information needed to complete the 8 sections of `pre_analysis_plan.md` with **minimal user burden** and **maximum specificity**.

The agent should think of itself as an experienced co-author who already knows what a good PAP looks like and can fill in reasonable defaults, but who needs the researcher to confirm the substantive commitments. The researcher should never feel interrogated — the tone is collaborative, like two colleagues sketching a study on a whiteboard.

## How to use this script

1. **Start with the gateway question** (Section 0) to determine the researcher's starting point.
2. **Work through Sections 1-8 in order**, but allow natural digressions — if the researcher answers a later question early, note it and skip ahead when you get there.
3. **Within each section**, begin with the opening question. Use follow-up probes only when the answer is vague or incomplete. Apply precision checks before marking a section complete.
4. **Track completion** using the criteria listed under each section. Do not move to the next section until the current one meets its completion criteria (or the researcher explicitly defers it).
5. **After all 8 sections are complete**, run the Bridge Section to capture additional information needed for `research_plan.md`.
6. **End with the summary checklist** — read back the full PAP to the researcher for confirmation.

### Conventions

Throughout this script:

- **Opening question** = the first question to ask for a given section. Broad, non-leading.
- **Follow-up probe** = a conditional question triggered by a specific type of answer. Indented under decision logic.
- **Precision check** = a question that forces the answer from vague to operationalised. These are non-negotiable before marking a section complete.
- **Example prompt** = a concrete example drawn from behavioural economics, offered when the researcher seems stuck. Always frame as "For instance..." rather than suggesting it is the right answer.
- Blockquotes (`>`) indicate decision logic for the agent.

---

## Section 0: Gateway

**Purpose:** Determine the researcher's starting point so the agent can adapt the interview accordingly.

### Opening question

"Tell me briefly what you're working on. Where are you in the process — do you have a study designed, are you still shaping the idea, or have you already collected data?"

> **Decision logic:**
>
> - **If the researcher has a clear study design** (knows their manipulation, outcome, and population): Proceed to Section 1 in standard mode. The interview will be relatively fast — mostly precision checks.
>
> - **If the researcher has a vague idea but no formal design**: Switch to **ideation mode**. Begin Section 1 with the hypothesis-building variant (see below). Expect to spend more time on Sections 1-3 before the design crystallises.
>
> - **If the researcher has already collected data** (post-hoc PAP): Switch to **retrospective mode**. Adapt all questions to past tense. Add the retrospective flag questions listed under each section. The PAP will document what the researcher committed to before looking at results, distinguishing pre-specified from post-hoc decisions.
>
> - **If the researcher wants to upload an existing PAP** (from AsPredicted, OSF, or another platform): Switch to **extraction mode**. See Section 0A below.
>
> - **If the researcher has multiple studies**: Ask "Which study should we focus on first?" Scope the interview to a single study. Note the others and their approximate designs for later.

### Section 0A: Extraction Mode (uploaded PAP)

If the researcher uploads or pastes a PAP from another platform, do not interview — extract. Use this checklist:

1. Read the uploaded document in full.
2. For each of the 8 PAP sections, check whether the uploaded document contains the required information (see completion criteria under each section below).
3. Copy the relevant content into the corresponding section of `pre_analysis_plan.md`, reformatting as needed to match the template's style.
4. For any section that is missing or incomplete in the uploaded document, flag it and ask the researcher to supply the missing information using the relevant interview questions from this script.
5. Once all 8 sections are populated, read back the full PAP for confirmation.

**Common gaps in uploaded PAPs:**
- AsPredicted PAPs often lack precise exclusion rules (Section 5) and specify analyses vaguely (Section 4).
- OSF PAPs sometimes omit sample size justification (Section 6) or bundle multiple studies without scoping clearly.
- PDF PAPs from grant applications often contain theoretical framing but lack operationalised variable definitions (Section 2).

---

## Section 1: Main Question or Hypothesis

**Purpose:** Establish the core research question and at least one falsifiable hypothesis.

### Opening question

"What is the main thing you want to find out? If your study goes perfectly, what would you be able to say at the end that you can't say now?"

### Follow-up probes

> **If the answer is a broad topic** (e.g. "I'm interested in cooperation" or "I want to study fairness"):

"That's a rich area. Can you narrow it down to a specific relationship between two things? For instance, are you asking whether a particular intervention changes cooperation, or whether a particular trait predicts it?"

> **If the answer is a research question but not a hypothesis** (e.g. "I want to know whether framing affects giving"):

"Good — that gives us the question. Now let's turn it into a prediction. Based on what you know from the literature or your intuition, which direction do you expect the effect to go? Will framing increase giving, decrease it, or do you genuinely have no prediction?"

> **If the researcher genuinely has no directional prediction:**

"That's fine — we'll register it as a two-sided test. But let me push a little: is there a theoretical reason to expect one direction over another? Even a weak prior is worth recording, because it affects whether we use one-sided or two-sided tests, which matters for power."

> **If the answer is already a precise hypothesis** (e.g. "I predict that public commitment increases contributions to a public goods game"):

Move directly to precision checks.

> **If the researcher is in ideation mode** (vague idea, no formal design):

"Let's work backwards. Imagine you're writing the abstract of the published paper. What's the one-sentence finding? Don't worry about getting it right — we can revise. But having a draft prediction on paper makes everything else easier."

Then help the researcher identify: (a) what varies (the independent variable or manipulation), (b) what it affects (the outcome), and (c) the expected direction.

> **If the researcher has multiple hypotheses:**

"Let's start with the most important one — the hypothesis that, if supported, would make the paper. We'll capture the others too, but let's anchor on the main one first."

Note: Capture all hypotheses, but identify which is primary (H1). Secondary hypotheses can be listed with their own directional predictions. Each hypothesis should be self-contained — a reader should understand the prediction without context.

### Precision checks

- "Can you state the hypothesis as a sentence with a clear direction? Something like: 'X increases/decreases/has no effect on Y'."
- "What is the theoretical or empirical basis for this prediction? Even a one-sentence justification."
- "Is this the main hypothesis, or is there a more central prediction?"
- "Are there any boundary conditions you expect? For example, does the effect only hold for certain subgroups or in certain conditions?"

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

"What exactly are you measuring? Walk me through the main outcome — what does a participant do, or what do you observe, that tells you whether the hypothesis is supported?"

### Follow-up probes

> **If the answer is conceptual** (e.g. "generosity" or "cooperation"):

"How do you operationalise that? What is the actual number or category that goes into your analysis? For instance, is generosity measured as the amount sent in a dictator game, the proportion of the endowment donated, or something else?"

> **If the answer names a measure but not its scale or units:**

"What are the units? Is it a continuous amount (e.g. 0-100%), a count, a binary yes/no, or a Likert scale? And what are the endpoints?"

> **If the researcher mentions a composite or index:**

"How is the composite constructed? Which items go into it, and how are they combined — simple average, sum, factor score? Are any items reverse-coded?"

> **If there is only one DV mentioned:**

"Is this the only outcome you care about, or are there secondary outcomes? For example, many experiments also look at response time, whether a decision was made at all (extensive margin), or a self-reported motivation. Even if these are secondary, we should list them."

> **If the researcher mentions many DVs:**

"Which of these is the primary outcome — the one that the paper lives or dies on? We need to distinguish the primary DV (which drives the headline test) from secondary DVs (which are informative but not the main result). This matters for multiple-testing corrections."

### Precision checks

- "If I gave your instructions to a research assistant, could they calculate this variable from the raw data without asking you any questions? If not, what's ambiguous?"
- "What is the theoretical range of this variable? What is a typical value?"
- "Is this measured once per participant, or repeatedly (e.g. across rounds)? If repeatedly, how will you aggregate across observations — average, last round, total?"
- "Are there any transformations you plan to apply before analysis (e.g. log, standardise, winsorise)?"

### Completion criteria

Section 2 is complete when:

- [ ] Every DV is named and defined with its unit/scale.
- [ ] The primary DV is distinguished from secondary DVs.
- [ ] The measurement procedure is specified (how and when the variable is observed).
- [ ] Any aggregation across repeated observations is specified (if applicable).
- [ ] Planned transformations (if any) are stated.

---

## Section 3: Conditions

**Purpose:** Define the experimental conditions or comparison groups, the assignment mechanism, and the unit of analysis.

### Opening question

"How many groups or conditions are in your study, and what differs between them?"

### Follow-up probes

> **If the researcher describes a between-subjects design:**

"Good. How are participants assigned to conditions — pure random, stratified, blocked by session, or something else?"

"Is there a control condition? If so, what does the control group experience — nothing, a neutral version of the treatment, or a different treatment?"

> **If the researcher describes a within-subjects design:**

"So each participant experiences multiple conditions. In what order? Is the order counterbalanced or randomised? Could there be order effects or learning, and if so, how will you handle that?"

> **If the design has both between- and within-subjects elements** (mixed design):

"Let's be precise: which factor varies between participants, and which varies within? For the within-subjects factor, how many observations per participant per condition?"

> **If the researcher describes a natural experiment or observational study:**

"What defines the groups? Is this a naturally occurring variation (e.g. a policy change, a geographic boundary), or are you splitting the sample by a measured variable? If the latter, how is the split defined — median, tercile, clinical cutoff?"

> **If the number of conditions is unclear:**

"Let me make sure I have this right. Can you list each condition with a short label? For example: (1) Control, (2) Low stakes, (3) High stakes. Just the labels for now — we can describe them in detail after."

> **If the researcher is using a factorial design:**

"How many factors, and how many levels per factor? Do you plan to analyse the full factorial (including interactions), or are some cells of secondary interest?"

### Precision checks

- "How many participants per condition do you plan to have?" (This also feeds into Section 6.)
- "What is the unit of independent observation — the individual participant, a pair, a group, a session? This determines how we cluster standard errors and what counts as an observation in non-parametric tests."
- "Is the treatment manipulation described precisely enough that another researcher could replicate it? If it involves instructions or stimuli, do you have the exact wording?"
- "Are there any conditions you considered but decided not to include? Worth noting for the 'Other' section."

### Completion criteria

Section 3 is complete when:

- [ ] Every condition is listed with a clear label and a description of what the participant experiences.
- [ ] The assignment mechanism is specified (random, stratified, within-subjects, natural variation, etc.).
- [ ] The design type is clear (between-subjects, within-subjects, mixed, quasi-experimental).
- [ ] The unit of independent observation is identified.
- [ ] For within-subjects designs, the number of observations per participant per condition is stated.

---

## Section 4: Analyses

**Purpose:** Pre-specify the exact statistical tests that will be used to evaluate each hypothesis.

### Opening question

"For your main hypothesis, what statistical test will you use to evaluate it? If you're not sure, tell me the type of data (continuous, binary, count) and I can suggest options."

### Follow-up probes

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

> **If the researcher has multiple hypotheses:**

"Let's map each hypothesis to its test. Can you tell me: for H1, the test is ___; for H2, the test is ___; and so on."

> **If the researcher mentions regressions with controls:**

"Which controls will you include, and why? The PAP should list them. Are they demographics (age, gender), experimental features (session, order), or theoretically motivated covariates?"

Note: Control variable details feed into the Bridge Section, but the PAP should at minimum list which controls appear in the primary specification.

> **If the researcher does not mention robustness checks:**

"What robustness checks are you planning? Common ones include: alternative variable definitions, including/excluding controls, winsorising outliers, alternative clustering levels, or restricting the sample. Even one or two planned robustness checks strengthen the PAP."

> **If the researcher mentions multiple-testing corrections:**

"Which correction method will you use — Bonferroni, Holm, Benjamini-Hochberg, or something else? And which family of tests does it apply to — all hypothesis tests, or only the secondary outcomes?"

### Precision checks

- "For each test, confirm: (a) the exact test name, (b) one-sided or two-sided, (c) the unit of observation, (d) any clustering."
- "If you are using regressions, what is the exact specification? Write it as: Y = f(X1, X2, ...) with standard errors clustered at ___."
- "Is there a pre-specified significance level? (The convention is alpha = 0.05, but confirm.)"
- "Will you report exact p-values or rely on significance stars? (JEBO convention: exact p-values in prose, stars in regression tables.)"

### Completion criteria

Section 4 is complete when:

- [ ] Every hypothesis has a named statistical test.
- [ ] Sidedness (one-sided or two-sided) is specified for each test.
- [ ] The unit of observation and clustering level are specified.
- [ ] At least one robustness check is described.
- [ ] If regressions are used, the specification is written out (DV, IVs, controls, clustering).
- [ ] Any multiple-testing correction is specified (or an explicit statement that none is planned).

---

## Section 5: Outliers and Exclusions

**Purpose:** Define, before seeing the data, exactly which observations will be excluded and how outliers will be handled. This is one of the most important sections of the PAP because it constrains researcher degrees of freedom.

### Opening question

"Under what circumstances would you drop a participant or an observation from the analysis? Think about things like: they didn't finish, they clearly didn't understand the task, or their data looks implausible."

### Follow-up probes

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

### Precision checks

- "Let me read back your exclusion rules as a numbered list. Can you confirm each one?"
- "Are these exclusion rules applied before or after the main analysis? In other words, do they define the analysis sample, or are they a sensitivity check?"
- "For each rule, what is the expected number or percentage of exclusions? We don't need an exact number, but a ballpark helps sanity-check the sample size."
- "Are there any exclusion rules that you might apply but are not yet committed to? If so, we should list them as contingent or sensitivity-check exclusions."

### Retrospective mode addition

> **If the researcher has already collected data:**

"Have you already looked at the data? If so, have any of these exclusion rules been informed by what you saw? It's important to be transparent about which rules were specified before versus after seeing the data. We can document both — pre-specified rules go in the PAP, and post-hoc rules get flagged as deviations in the research log."

### Completion criteria

Section 5 is complete when:

- [ ] Every exclusion rule is stated precisely enough for mechanical application (no subjective judgement required).
- [ ] Outlier treatment is specified: definition, method (exclude vs. winsorise vs. trim), and which variables it applies to.
- [ ] The expected impact on sample size is roughly estimated.
- [ ] For online experiments: platform-specific exclusions are addressed.
- [ ] It is clear whether exclusions define the analysis sample or are sensitivity checks.

---

## Section 6: Sample Size

**Purpose:** Commit to a sample size or a stopping rule, ideally justified by a power calculation.

### Opening question

"How many participants are you planning to collect, and how did you arrive at that number?"

### Follow-up probes

> **If the researcher gives a number with no justification** (e.g. "about 200"):

"Where does that number come from — convention, budget, a power calculation, or a prior study? Any of those is fine, but we should document it."

> **If the researcher says "as many as I can get" or "it depends on the budget":**

"Understood — budgets are real constraints. Can we set a minimum and a maximum? For example: 'We will collect at least 120 participants. If resources allow, we will continue up to 200.' That way the PAP has a commitment without being unrealistic."

> **If the researcher has not done a power calculation:**

"Would you like to do a quick power calculation? I can help. I need three things: (a) the smallest effect size you'd consider meaningful (not the one you hope for — the one that would still be interesting if that's all there is), (b) your significance level (usually 0.05), and (c) your desired power (usually 0.80). If you don't know the effect size, we can work from a prior study or from conventions in your field."

> **If the researcher wants help estimating the effect size:**

"A few approaches: (1) Is there a closely related prior study? If so, what effect did they find? We could power for 50-75% of their effect as a conservative estimate. (2) For common behavioural economics paradigms, typical effect sizes are: dictator game framing effects d = 0.3-0.5, public goods contribution differences between conditions d = 0.3-0.6, risk-preference treatment effects d = 0.2-0.4. Does any of that sound like your setting?"

> **If the researcher mentions a specific power calculation tool:**

"Great — can you share the inputs and the result? I want to record: the effect size, alpha, power, test type, and resulting N."

> **If the study is observational and the sample is fixed:**

"Since the sample is already determined, we don't choose N — we describe what we have. What is the total sample size, and what determines it (e.g. all records from a given period, all participants who met the inclusion criteria)? We should also note the effective sample size after exclusions and any clustering."

> **If the researcher has multiple conditions:**

"Is that N total or N per condition? And is the allocation balanced (equal N per condition) or unbalanced?"

### Precision checks

- "To confirm: the planned sample size is ___ [total / per condition]. Is that the number before or after expected exclusions?"
- "Is there a stopping rule? For example: 'We will stop at exactly 150' or 'We will collect in batches of 30 and stop when we reach at least 120.'"
- "If the actual sample differs from the target (e.g. fewer show up, more fail attention checks than expected), what will you do?"

### Completion criteria

Section 6 is complete when:

- [ ] A target sample size is stated (total and per condition).
- [ ] The basis for the number is documented (power calculation, budget constraint, convention, or existing dataset).
- [ ] If a power calculation was done: effect size, alpha, power, and test type are recorded.
- [ ] Any stopping rule or sequential analysis plan is stated.
- [ ] It is clear whether the number is pre- or post-exclusion.

---

## Section 7: Other (Secondary Analyses, Exploratory)

**Purpose:** Capture anything the researcher wants to pre-register beyond the core hypotheses — secondary analyses, exploratory questions, additional measures collected, or unusual methodological choices.

### Opening question

"Is there anything else you plan to analyse that we haven't covered? This could be secondary hypotheses, subgroup analyses, mediation, moderation, or exploratory questions you want to flag."

### Follow-up probes

> **If the researcher says "no, that's everything":**

"A few things that often come up: (a) Do you plan to test for heterogeneous treatment effects by gender, age, risk attitudes, or any other moderator? (b) Are you collecting any survey measures at the end (demographics, personality scales, manipulation checks, self-reports) that might be analysed? (c) Is there a learning or order effect you plan to examine?"

> **If the researcher mentions mediation or moderation:**

"For mediation: what is the proposed mediator, and what method will you use (Baron-Kenny, causal mediation analysis, something else)? For moderation: what is the moderator variable, and how will you test the interaction — by splitting the sample or including an interaction term?"

> **If the researcher mentions exploratory analyses:**

"Good — flagging these as exploratory is exactly what the PAP is for. We'll label them clearly so there's no confusion about what was pre-registered versus exploratory. Is there a specific analysis you have in mind, or is this more of a 'we'll look at the data and see what's interesting' situation?"

> **If the researcher is collecting data they won't use in the primary analysis:**

"Worth noting what you're collecting and why, even if you won't analyse it in the main paper. It protects you from the accusation that you selectively reported measures."

### Precision checks

- "For each secondary or exploratory analysis, can you briefly state: (a) what you're testing, (b) how, and (c) whether you consider it pre-registered or exploratory?"
- "Are any of these analyses conditional on the primary results? For example: 'We will only test for mediation if H1 is supported.'"

### Completion criteria

Section 7 is complete when:

- [ ] All secondary hypotheses or analyses are listed (even if briefly).
- [ ] Each is labelled as pre-registered secondary or exploratory.
- [ ] Additional measures collected but not analysed are noted.
- [ ] Conditional analyses (if any) state their trigger condition.
- [ ] If there is genuinely nothing to add, an explicit "None" is recorded.

---

## Section 8: Existing Data

**Purpose:** Disclose whether any data relevant to this study have already been collected, observed, or accessed by the researcher.

### Opening question

"Have you collected, accessed, or looked at any data related to this study? This includes pilot data, prior waves of the same experiment, or administrative data you've already downloaded."

### Follow-up probes

> **If the researcher says "no":**

"Perfect. We'll record that no data have been collected."

> **If the researcher has pilot data:**

"How many participants were in the pilot? Did you look at the results? If so, did the pilot results influence your hypothesis, your design, your chosen sample size, or your exclusion rules? Any of these is fine — we just need to document it."

> **If the researcher has already collected the full dataset:**

"This is a retrospective PAP. Let's be transparent about that. Key questions: (a) Have you already looked at the main outcome variable? (b) Have you run any analyses? (c) Which decisions in this PAP were made before versus after seeing data? We'll flag any post-hoc decisions clearly."

> **If the researcher has access to a related dataset** (e.g. an earlier wave, a similar study by a co-author):

"Has that dataset informed your hypotheses, variable definitions, or analysis choices? If so, we should note that. It's not a problem — it's standard practice to build on prior work — but transparency matters."

> **If the researcher has simulated data:**

"Have you tested your analysis pipeline on simulated or synthetic data? That's great practice. Did anything you learned from the simulation change your design or analysis plan?"

### Precision checks

- "Can you characterise the state of the data using one of these categories? (a) No data exist. (b) Data exist but I have not accessed them. (c) Data exist and I have accessed them but not analysed the dependent variable. (d) Data exist and I have analysed them, including the dependent variable."
- "If data exist, how many observations, and what is the overlap with the planned study?"

### Retrospective mode addition

> **If the researcher is writing a post-hoc PAP:**

"Let's be especially careful here. I'll ask you about each PAP section: was this decision made before or after you saw the data? There's no judgement — post-hoc PAPs are common and useful — but the documentation must be honest. We'll mark each section as 'pre-specified' or 'post-hoc' so that readers can calibrate."

Work through each section (hypotheses, DVs, conditions, analyses, exclusions, sample) and ask: "Was this decided before or after you had access to the data?" Record the answer in the PAP.

### Completion criteria

Section 8 is complete when:

- [ ] The existence or non-existence of data is clearly stated.
- [ ] If data exist: the nature of the data (pilot, partial, full), the sample size, and whether results have been examined are documented.
- [ ] For retrospective PAPs: each section is marked as pre-specified or post-hoc.

---

## Bridge Section: Beyond the PAP

**Purpose:** After the PAP is complete, elicit additional information needed for `research_plan.md` that is not covered by the 8 PAP sections. This information is not pre-registered — it is planning and framing.

### B1: Theoretical Framework

"Now that the PAP is done, let's talk about the 'why.' What is the theoretical framework behind this study? Which theories or models generate the predictions you've registered?"

Follow-up probes:
- "Is there a specific model (e.g. Fehr & Schmidt inequality aversion, dual-process theory, social identity) that your hypothesis derives from?"
- "Are you testing a theory, extending it, or pitting two theories against each other?"
- "What are the two or three most important papers that this study builds on?"

### B2: Control Variables and Justification

"Which control variables will you include in your regression specifications, and why?"

Follow-up probes:
- "For each control, is the justification empirical (commonly used in the literature), theoretical (the variable is a known confounder), or practical (it was collected and might reduce noise)?"
- "Are there any controls you considered but decided against? Why?"
- "Are the controls measured before or after the treatment? Post-treatment controls can introduce bias — is that a concern here?"

### B3: Robustness Strategy

"Let's map out your primary specification versus your robustness checks. What is the headline test, and what are the alternatives?"

Follow-up probes:
- "If the primary result holds but a robustness check doesn't, how will you interpret that?"
- "Are any robustness checks designed to address specific reviewer concerns you anticipate?"
- "Do you plan to present robustness checks in the main text or the appendix?"

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

### B6: Power Calculation Details

If the power calculation was only briefly discussed in Section 6, expand here:

- "What tool or software did you use for the power calculation?"
- "What is the assumed distribution of the outcome variable?"
- "Did you account for clustering in the power calculation?"
- "If the study involves repeated measures, did the power calculation incorporate the expected within-subject correlation?"
- "What is the minimum detectable effect size at your planned N and power?"

### B7: Design Type

"One final question for the research plan: is this an experiment (experimentalist profile) or an observational study (empiricist profile)? This determines which analysis conventions we follow."

> **If experiment:** The project will use `Context/Roles/profile_experimentalist.md`. Non-parametric tests are the primary evidence; regressions are robustness.
>
> **If observational:** The project will use `Context/Roles/profile_empiricist.md`. Regressions are the primary evidence; robustness via alternative specifications and placebo tests.

---

## Summary and Confirmation

Once all sections (1-8 plus Bridge) are complete, read back the full PAP to the researcher in a structured summary. Use the following format:

---

**PAP Summary for [Project Title]**

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

Ask: "Does this accurately capture your study? Is there anything you'd change, add, or correct?"

Once confirmed, populate `pre_analysis_plan.md` with the agreed content.

---

## Completion Checklist

Use this checklist to verify that the PAP is complete before writing it to the file.

### PAP sections

- [ ] **Section 1 (Hypothesis):** At least one falsifiable hypothesis with direction, named variables, and a gap statement.
- [ ] **Section 2 (DVs):** All outcomes named, defined, scaled, with primary vs. secondary distinguished.
- [ ] **Section 3 (Conditions):** All conditions listed and described; assignment mechanism and design type specified.
- [ ] **Section 4 (Analyses):** Every hypothesis mapped to a test; sidedness, clustering, and robustness specified.
- [ ] **Section 5 (Exclusions):** All exclusion rules stated mechanically; outlier treatment defined.
- [ ] **Section 6 (Sample size):** Target N stated with justification; stopping rule if applicable.
- [ ] **Section 7 (Other):** Secondary and exploratory analyses listed, or explicit "None."
- [ ] **Section 8 (Existing data):** Data status disclosed; retrospective flags if applicable.

### Bridge sections (for research plan)

- [ ] **B1:** Theoretical framework and key references identified.
- [ ] **B2:** Control variables listed with justification.
- [ ] **B3:** Primary vs. robustness specification hierarchy established.
- [ ] **B4:** Sidedness confirmed for each hypothesis.
- [ ] **B5:** Missing data strategy stated.
- [ ] **B6:** Power calculation details recorded (if applicable).
- [ ] **B7:** Design type confirmed (experimentalist or empiricist).

### Process checks

- [ ] All sections meet their completion criteria.
- [ ] The full PAP has been read back to the researcher and confirmed.
- [ ] `pre_analysis_plan.md` has been populated with the confirmed content.
- [ ] Bridge section answers have been noted for transfer to `research_plan.md`.
