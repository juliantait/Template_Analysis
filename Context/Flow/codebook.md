# Codebook

Documentation for the dataset used in this project.

## Population Timing

This codebook is a **gated dependency** — it must be kept current as a prerequisite for downstream work.

| Trigger | Action | Who |
|---------|--------|-----|
| Data arrives (before 02_cleaning.R) | Populate **Data Source** and **Raw Variables** sections from any shipped documentation in `Data/`, or by examining the data directly | Agent or researcher |
| After 02_cleaning.R runs | Update **Raw Variables** with any cleaning notes; add entries to **Recoding Notes** and **Exclusions** if cleaning changed or dropped anything | Agent |
| After 03_variable_generation.R runs | Populate **Generated Variables** for every new variable created | Agent |
| After 04_sample_restrictions.R runs | Update **Exclusions** with every restriction applied and the N dropped | Agent |
| Before any analysis script (05+) runs | **Gate check**: Raw Variables, Generated Variables, and Exclusions sections must all be populated. If they are empty, stop and populate them first. | Agent |
| During analysis (05-09) | If any script creates new variables or recodes existing ones, update the relevant section | Agent |
| During revision cycles | If any variable definition changes, update the codebook and log the change in `Context/Flow/research_log.md` | Agent |

**Before populating this file**, check the `Data/` folder for any codebook or data documentation that shipped with the dataset (e.g. `.csv`, `.xlsx`, `.pdf`, `.md`, `.txt`). If one exists, use it as the primary source — reproduce the relevant information here in the structured format below. If none exists, build this codebook from scratch by examining the data directly.

## Data Source

| Field | Value |
|-------|-------|
| Source | |
| File(s) | |
| Format | |
| Unit of observation | |
| Sample period | |
| Total observations | |
| Total unique subjects | |

## Raw Variables

Variables as they appear in the original dataset before any cleaning or recoding.

| Variable | Type | Description | Valid values | Missingness notes |
|----------|------|-------------|--------------|-------------------|
| | | | | |

## Generated Variables

Variables created in `Scripts/03_variable_generation.R` or later scripts.

| Variable | Type | Description | Source / derivation | Created in |
|----------|------|-------------|---------------------|------------|
| | | | | |

## Recoding Notes

Document any non-obvious recoding decisions (e.g., collapsing categories, handling special codes, imputation).

| Variable | Original coding | New coding | Rationale | Script |
|----------|-----------------|------------|-----------|--------|
| | | | | |

## Exclusions

Variables or observations dropped during cleaning or sample restrictions.

| What was excluded | Reason | N dropped | Script |
|-------------------|--------|-----------|--------|
| | | | |
