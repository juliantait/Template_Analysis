# Empiricist Profile

> Extends `researcher_profile.md`. Read the shared profile first; this file adds empirical/observational-specific conventions.

## Research Orientation

- Research area: empirical behavioural economics (observational data, survey data, administrative records, field data).
- Causal identification comes from **quasi-experimental variation** or **natural experiments** (e.g. instrumental variables, difference-in-differences, regression discontinuity, matching).
- Pre-registration is not always applicable; clearly state whether hypotheses were pre-specified or exploratory.
- Data features to document: source, sample period, unit of observation, sample-selection criteria, and any linkage across datasets.

## Analysis Methodology

- Primary results use **regression-based methods** (OLS, IV, DiD, RDD, logit/probit) as the main evidence.
- Standard errors are clustered at the appropriate level dictated by the identification strategy (e.g. individual, firm, region).
- Non-parametric and semi-parametric methods (e.g. local polynomial regression, kernel density estimation) supplement the main results where appropriate.
- In tables, report: estimation method, number of observations, number of clusters, key coefficient(s), and standard errors in parentheses.
- In prose, embed core numbers (coefficients, percentage-point changes, magnitudes) directly in the sentence. Test details follow in parentheses — e.g. `($p=.03$, one-sided)`. Do **not** report $t$-statistics in running text.
- Specify sidedness (one-sided or two-sided) consistent with the directional or non-directional nature of each hypothesis.
- Robustness checks include: alternative specifications, placebo tests, sensitivity to bandwidth/functional form, and sample restrictions.
- Identification assumptions must be discussed and, where possible, tested (e.g. parallel-trends plots for DiD, first-stage F-statistics for IV, density tests for RDD).

## JEBO Additions

- Regression tables are the primary evidence; present them with coefficient estimates, clustered standard errors in parentheses, and significance stars following journal convention.
- Figures focus on **identification** (e.g. event-study plots, RDD scatter plots, binned scatter plots) and **descriptive patterns** (e.g. time series, distributions).
- Always label variables, samples, and fixed effects clearly in tables; a referee must understand the specification without the main text.

## Typical Script Pipeline

1. `02_cleaning.R` — import raw data, merge sources, recode variables.
2. `03_variable_generation.R` — construct derived variables and instrument definitions.
3. `04_sample_restrictions.R` — apply sample restrictions and exclusion criteria.
4. `05_balance_table.R` — summary statistics and covariate balance across groups.
5. `06_descriptives.R` — descriptive statistics, distributions, and key values.
6. `07_hypotheses.R` — primary regression specifications testing the main hypotheses.
7. `08_robustness.R` — alternative specifications, placebo tests, sensitivity analyses.
8. `09_exploratory.R` — heterogeneity analysis, mediation, or subgroup decompositions.
