# Research Plan

> **Foundation:** This plan builds on `pre_analysis_plan.md`. Read the PAP first — it contains the core pre-registered commitments. The sections below expand on the PAP with theoretical detail, full variable definitions, and operational decisions. If the PAP is still in placeholder form, complete it before filling in this document.

## Research Idea

[Describe the core research idea in 2-4 paragraphs. Start from the PAP's main question (Section 1) and expand.]

Address each of the following:
- **Gap**: What specific gap in the literature does this study fill?
- **Contribution**: What will we know after this study that we don't know now?
- **Positioning**: Name 2-3 key papers this study builds on or challenges.
- **Importance**: Why does this matter — for theory, policy, or practice?

*Example: Recent work on prosocial behaviour (Fehr & Gächter, 2000; Andreoni, 1990) shows that cooperation decays without punishment mechanisms. However, the role of individual differences in agreeableness has been largely ignored. This study fills that gap by testing whether agreeableness predicts donation behaviour in a controlled dictator game.*

## Research Question

[State the primary research question as a single, clear sentence.]

*Format: "Does [IV] affect [DV] in [context/population]?"*

*Example: Does agreeableness predict the fraction of endowment donated to charity in a laboratory dictator game?*

## Theoretical Framework

[Outline the theoretical basis for the hypotheses in 2-3 paragraphs.]

Address each of the following:
- **Core theory**: Which theory generates the predictions? (e.g., social preferences, dual-process, identity economics)
- **Mechanism**: What is the proposed causal pathway from IV to DV?
- **Boundary conditions**: Under what conditions should the effect hold or fail?
- **Competing predictions**: Does any theory predict the opposite? If so, how does the design discriminate?

*Example: We draw on Fehr and Schmidt's (1999) inequity aversion model, which predicts that individuals with stronger other-regarding preferences will donate more. Agreeableness (Big Five) captures dispositional cooperativeness and should correlate with inequity aversion. The public condition tests whether social image concerns (Bénabou & Tirole, 2006) amplify or substitute for dispositional agreeableness.*

## Design

**Personality profile:** [experimentalist / empiricist] — see `Context/Roles/researcher_profile.md` for details. Set this before any analysis begins.

[Describe the design using the following structure:]

- **Type**: [between-subjects / within-subjects / mixed]
- **Arms**: [number and names of conditions]
- **Randomisation**: [unit of randomisation, method, stratification if any]
- **Timing**: [number of rounds/periods, session structure]
- **Setting**: [lab / online / field; platform if online]

*Example: Between-subjects design with 3 arms (Private, Public, Public + Norm). Randomisation at the individual level within each session. Each participant plays 5 rounds of a dictator game. Conducted in the university laboratory using oTree.*

## Hypotheses

[List pre-registered hypotheses. For each hypothesis, specify:]
- **Statement**: the directional prediction
- **IV → DV**: which independent variable affects which dependent variable
- **Direction**: which group/condition is expected to be higher/lower
- **Sidedness**: one-sided or two-sided test
- **Mechanism** (optional): why you expect this direction

- **H1**: [Statement] *(sidedness: [one/two]-sided)*
- **H2**: [Statement] *(sidedness: [one/two]-sided)*
- **H3**: [Statement] *(sidedness: [one/two]-sided)*
- **H4**: [Statement] *(sidedness: [one/two]-sided)*

*Example:*
- *H1: Participants in the Public condition donate a higher fraction than those in the Private condition (one-sided)*
- *H2: The effect of publicity on donations is larger for participants with low agreeableness (two-sided)*

## Variables

### Independent Variables

[For each IV, specify:]

| Variable | Type | Levels / Values | Operationalisation | Source |
|----------|------|-----------------|-------------------|--------|
| | [binary / categorical / continuous] | [list levels] | [how measured/assigned] | [PAP section / data source] |

*Example:*
| Variable | Type | Levels | Operationalisation | Source |
|----------|------|--------|-------------------|--------|
| Treatment | Categorical | Private, Public, Public+Norm | Random assignment at session start | PAP §3 |
| Agreeableness | Continuous | 1-5 scale | Big Five Inventory, 9-item subscale | Post-experiment survey |

### Dependent Variables

[For each DV, specify:]

| Variable | Type | Range / Units | Operationalisation | Source |
|----------|------|---------------|-------------------|--------|
| | [continuous / binary / count] | [range and units] | [how measured] | [PAP section] |

*Example:*
| Variable | Type | Range | Operationalisation | Source |
|----------|------|-------|-------------------|--------|
| Donation fraction | Continuous | 0-100% | Amount sent / endowment, averaged over 5 rounds | PAP §2 |
| Donated at all | Binary | 0/1 | 1 if any positive donation in any round | PAP §2 |

### Controls

[For each control variable, specify:]

| Variable | Type | Justification | When included |
|----------|------|---------------|---------------|
| | | [why this control is needed] | [primary / robustness only] |

*Example:*
| Variable | Type | Justification | When included |
|----------|------|---------------|---------------|
| Gender | Binary | Known predictor of prosocial behaviour | Robustness |
| Age | Continuous | May correlate with agreeableness | Robustness |
| Session FE | Fixed effect | Controls for session-level variation | All regressions |

## Sample

[Describe using this structure:]

- **Population**: [who are the participants?]
- **Recruitment**: [how recruited? what platform?]
- **Target N**: [total sample size and per-arm]
- **Power calculation**: [effect size, alpha, power, test used; or state "not conducted" with justification]
- **Stopping rule**: [fixed N / budget-constrained / sequential]
- **Exclusion rules**: [reference PAP §5, list criteria here]

**Codebook:** See `Context/Flow/codebook.md` for a full variable-level description of the dataset, including raw variables, generated variables, recoding decisions, and exclusions.

*Example: 120 university students (40 per arm), recruited via ORSEE. Power calculation: d = 0.5 (medium effect), α = 0.05, 80% power, two-sample t-test → 64 per group for pairwise. 40 per arm is the minimum for the three-arm Kruskal-Wallis test at similar power. Stopping rule: fixed N = 120, run over 6 sessions of 20 participants each.*

## Analysis Strategy

[Organise into three tiers:]

### Primary Analyses
[The pre-registered tests from PAP §4. For each hypothesis, specify:]
- Test name and type (e.g., Wilcoxon rank-sum, Kruskal-Wallis, OLS)
- Sidedness (must match hypothesis sidedness above)
- Clustering (if any; at what level and why)
- Multiple testing correction (if testing multiple hypotheses)

### Robustness Checks
[Pre-specified alternative specifications from PAP §4. For each:]
- What changes relative to the primary analysis (e.g., add controls, change functional form, alternative sample)
- Why this is a meaningful robustness check
- What would "failure" look like (primary result overturned vs. attenuated)

### Exploratory Analyses
[From PAP §7. Clearly labelled as exploratory — not pre-registered.]
- Subgroup analyses (specify subgroups)
- Additional outcomes not in PAP §2
- Mechanism tests or mediation analyses

**Output naming convention:** See `Context/context.md` for the `{script}_{analysis}_{descriptor}.{ext}` naming standard used by all `save_graph()`, `save_table()`, and `save_text()` calls.

## Timeline

The project timeline lives in `Context/Flow/timeline.md` — a standalone file that tracks phase-by-phase progress. Update it whenever a task changes status.

See the gate descriptions below for requirements that must be met before certain phases can begin.

### Results review (gate before writing)

**Do not begin writing until this phase is complete.** Once all analysis scripts have run and results are generated, stop and critically review everything before moving on. This is not a formality — it is a substantive checkpoint.

The agent must:

1. **Read all generated output** — every table, graph, and text file in `Output/`.
2. **Compare results against hypotheses** — which were supported, which were not, and which were ambiguous? Are effect sizes meaningful or trivially small?
3. **Stress-test the empirical strategy** using the item-by-item checklist in `Context/Agents/results_review_checklist.md`. Work through every section (balance, descriptive coherence, hypothesis verdicts, robustness, exploratory, cross-analysis coherence, technical quality, red flags) and tick each item.
4. **Check for coherence across analyses** — do descriptives, hypothesis tests, robustness checks, and exploratory results tell a consistent story? Flag any contradictions.
5. **Identify necessary adjustments** — if the results call for changes to variable definitions, sample restrictions, additional controls, alternative specifications, or reframing of hypotheses, make those changes now. Update the relevant scripts, re-run, and log the decision in `Context/Flow/research_log.md`.
6. **Update the research plan** — revise the Analysis Strategy, Hypotheses, or Variables sections of this file if anything changed.
7. **Record lessons** — add any non-obvious findings to the Notes for Future Agents table below.
8. **Produce the review artefact** — save a structured `results_review.md` file to the project root. It must contain: (a) a summary of each hypothesis and whether it was supported, with effect sizes; (b) a coherence assessment across analyses; (c) any concerns flagged; (d) changes made to scripts or the research plan during the review. This file is required — without it, the review is not complete.

Only once this review is done, `results_review.md` exists, and the results are stable should the timeline move to Writing.

### Referee report (gate before submission)

**Do not submit until this phase is complete.** Once the paper is fully drafted, a separate agent must be spawned to act as an anonymous referee. This is not optional.

The referee agent must:

1. **Adopt the referee persona** described in `Context/Roles/profile_referee.md`. Read that file in full before beginning.
2. **Read the entire manuscript** — all LaTeX section files, all figures, all tables. Understand the paper as a whole before commenting.
3. **Read the research plan and analysis output** — the referee should understand what was done, not just what was written up.
4. **Write a full referee report** following the structure in `Context/Roles/profile_referee.md` (summary, overall assessment, major comments, minor comments, questions for the authors).
5. **Save the report to the project root** using the following naming convention:
   - First report: `referee_report.md`
   - Subsequent reports (after revisions): `referee_report_2.md`, `referee_report_3.md`, etc.
   - Before writing, check which reports already exist and increment accordingly. Previous reports must never be overwritten — they form a history of how the paper improved.
6. **Be genuinely critical** — the point of this exercise is to catch problems before a real referee does. A friendly report is a useless report.

The referee agent should be spawned as a dedicated subagent with its own context so that it approaches the paper fresh, without the baggage of having written it.

The referee-then-revise cycle is **iterative**. After a Revise & Resubmit round, spawn a new referee agent to write a fresh report on the revised manuscript. Repeat until the referee's overall assessment is that the paper is publishable (minor revision or accept). Each iteration produces a new numbered report file.

### Revise and resubmit

Once the referee report is complete, a new session begins to address every comment. This is a full revise-and-resubmit cycle, not a cosmetic pass. Follow `Context/Agents/revision_protocol.md` for the full multi-cycle protocol, including cascade rules for re-running scripts and output versioning.

The revising agent must:

1. **Read the latest referee report** (the highest-numbered `referee_report*.md` in the project root) in full.
2. **Triage comments** — classify each major and minor comment as: (a) agree and will fix, (b) partially agree, or (c) disagree. For (b) and (c), prepare a reasoned response.
3. **Make substantive changes** — if the referee identifies problems with the empirical strategy, variable definitions, sample restrictions, robustness checks, or framing, fix them. This may mean re-running analysis scripts, generating new output, and rewriting sections. Do not treat this as a writing-only task.
4. **Rewrite the paper** — revise every section of the manuscript as needed. The goal is a paper that would satisfy the referee, not a paper with patches.
5. **Write a response document** — save a point-by-point response to the project root, numbered to match the report it responds to (e.g. `referee_response.md` for the first, `referee_response_2.md` for the second, etc.).
6. **Log all decisions** in `Context/Flow/research_log.md` and update `research_plan.md` if the design or analysis strategy changed.
7. **Record lessons** in the Notes for Future Agents table below.
8. **Spawn a new referee** — after the revision is complete, spawn a fresh referee agent to write the next numbered report on the revised manuscript. Repeat the cycle until the referee recommends minor revision or accept.

Only once the referee is satisfied and the final revision is complete should the timeline move to Submission.

### How to maintain this timeline

- **First agent**: Set up the timeline in `Context/Flow/timeline.md` (see checkbox there). After setup, update the table as work progresses.
- When a task is **completed**, set its Status to `Done` and fill in the Date Done column.
- When a task is **in progress**, set its Status to `In progress`.
- When a task is **blocked** by something, set its Status to `Blocked` and explain in Notes.
- When new tasks emerge during the work, **add new rows** to the table.
- If a phase needs to be broken into sub-tasks, indent them beneath the parent phase.

## Notes for Future Agents

This section collects hard-won lessons, gotchas, and institutional knowledge that a future agent needs when picking up the next stage of this research. Add to this section whenever you learn something that isn't obvious from the code or context files alone.

Each entry should include a date and a short description of the lesson.

| Date | Lesson |
|------|--------|
|      |        |
