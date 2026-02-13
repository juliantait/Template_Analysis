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
- Always report: estimation method, number of observations, number of clusters, key coefficient(s), standard error, and exact p-value (to 3 decimal places).
- Specify sidedness (one-sided or two-sided) consistent with the directional or non-directional nature of each hypothesis.
- Robustness checks include: alternative specifications, placebo tests, sensitivity to bandwidth/functional form, and sample restrictions.
- Identification assumptions must be discussed and, where possible, tested (e.g. parallel-trends plots for DiD, first-stage F-statistics for IV, density tests for RDD).

## JEBO Additions

- Regression tables are the primary evidence; present them with coefficient estimates, clustered standard errors in parentheses, and significance stars following journal convention.
- Figures focus on **identification** (e.g. event-study plots, RDD scatter plots, binned scatter plots) and **descriptive patterns** (e.g. time series, distributions).
- Always label variables, samples, and fixed effects clearly in tables; a referee must understand the specification without the main text.

## Typical Script Pipeline

1. `02_clean.R` — import raw data, merge sources, apply sample restrictions, construct variables.
2. `03_descriptives.R` — summary statistics, distributions, and descriptive figures.
3. `04_main_results.R` — primary regression specifications testing the main hypotheses.
4. `05_robustness.R` — alternative specifications, placebo tests, sensitivity analyses.
5. `06_mechanisms.R` — heterogeneity analysis, mediation, or subgroup decompositions.
