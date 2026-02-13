# Experimentalist Profile

> Extends `researcher_profile.md`. Read the shared profile first; this file adds experiment-specific conventions.

## Research Orientation

- Research area: experimental and behavioural economics (lab experiments, online experiments, incentivised decisions, team behaviour).
- Causal identification comes from **randomisation** into treatment and control conditions.
- Studies are **pre-registered**; hypotheses are stated directionally and tested with the appropriate one-sided or two-sided tests as pre-registered.
- Design features to document: number of sessions, subjects per session, randomisation procedure, payment scheme, and any deception policy.

## Analysis Methodology

- Primary results use **non-parametric tests** wherever possible (e.g. Wilcoxon rank-sum, Wilcoxon signed-rank, permutation tests).
- Non-parametric tests are conducted at the **group level**: collapse individual-level data to one observation per independent group before testing.
- Parametric tests (OLS, logit, etc.) serve as **robustness checks**, replicating the same predictions tested non-parametrically.
- Standard errors in all parametric models are clustered at the group level.
- The hypotheses script reports non-parametric results as the primary evidence; the robustness script re-tests the same predictions with regressions and controls.
- Always report: test type, number of observations/groups, test statistic, and exact p-value (to 3 decimal places).
- Specify sidedness (one-sided or two-sided) consistent with the directional or non-directional nature of each hypothesis.
- Specify the pairing structure of every test (independent samples or matched pairs).

## JEBO Additions

- Non-parametric tests are preferred for primary results; regressions serve as robustness.
- Treatment-effect figures (e.g. bar charts with error bars, CDFs by treatment) are the main visual evidence.
- Always label treatments clearly in figures and tables; a referee must understand the comparison without the main text.

## Typical Script Pipeline

1. `02_clean.R` — import raw experimental data, apply exclusions, construct variables.
2. `03_descriptives.R` — summary statistics and balance checks across treatments.
3. `04_hypotheses.R` — non-parametric tests of pre-registered hypotheses.
4. `05_robustness.R` — OLS/logit regressions with controls replicating the same predictions.
5. `06_exploratory.R` — additional analyses not covered by pre-registration.
