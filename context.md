# Context

Read this file first. Study the relevant linked context files depending on your task.

## Researcher

See `Context/researcher_profile.md` for background on the researcher, field, and target journal.

## Project Structure

This is a self-contained empirical analysis project. All scripts are sourced in numbered order from `main.R`. Output is written to `Output/Graphs/`, `Output/Tables/`, and `Output/Text/` via the `save_graph()`, `save_table()`, and `save_text()` helper functions defined in `Scripts/01_settings.R`.

- Settings, palette, and theme: `Scripts/01_settings.R`
- Data preparation: `Scripts/02_cleaning.R` → `Scripts/03_variable_generation.R` → `Scripts/04_sample_restrictions.R`
- Analysis: `Scripts/05_balance_table.R` through `Scripts/09_exploratory.R`

## Study

[Describe the study here. Include: research question, design, treatments, main outcome variables, and hypotheses.]

### Hypotheses

- H1:
- H2:
- H3:
- H4:

### Outcomes

[Describe the main outcome variables and how they are measured.]

### Treatments

[Describe the treatment arms, within/between-subject variation, and matching/randomisation structure.]

## Analysis Conventions

- Non-parametric tests use group-level analysis by collapsing on the group variable.
- Parametric tests always cluster standard errors at the group level.
- British English spelling throughout all output.

## Output Naming Convention

All saved output files follow the pattern:

```
{script}_{analysis}_{descriptor}.{ext}
```

| Component      | Description                                                                 | Source                                                        |
|----------------|-----------------------------------------------------------------------------|---------------------------------------------------------------|
| `{script}`     | The analysis stage that generated the file, matching the script name.       | `balance`, `descriptives`, `hypotheses`, `robustness`, `exploratory` |
| `{analysis}`   | The specific analysis or sub-section within that script.                    | e.g. `learning`, `gender`, `manager_types`, `reporting`       |
| `{descriptor}` | What the output shows. Be specific enough to identify it without opening.   | e.g. `mistake_hiding_rates`, `mean_outcomes_matched`, `by_round` |
| `{ext}`        | File type: `.png` for graphs, `.tex` for tables, `.txt` for text.          |                                                               |

All parts use **lowercase** with **underscores** as separators. No spaces, no camelCase.

### Examples

| File                                                  | Script              | Analysis        | Descriptor              |
|-------------------------------------------------------|----------------------|-----------------|-------------------------|
| `balance_demographics.tex`                            | 05_balance_table     | —               | demographics            |
| `descriptives_values.txt`                             | 06_descriptives      | —               | values                  |
| `hypotheses_h1_hiding_by_stakes.png`                  | 07_hypotheses        | h1              | hiding_by_stakes        |
| `robustness_regression_treatment_with_controls.tex`   | 08_robustness        | regression      | treatment_with_controls |
| `exploratory_learning_mistake_hiding_rates.png`       | 09_exploratory       | learning        | mistake_hiding_rates    |
| `exploratory_manager_types_mean_outcomes_matched.tex` | 09_exploratory       | manager_types   | mean_outcomes_matched   |

### Rules
- If a script has only one output, the `{analysis}` part can be omitted (e.g. `balance_demographics.tex`).
- The `{descriptor}` should be readable enough that you can identify the content from the filename alone.
- Use the same naming in the `save_graph()`, `save_table()`, and `save_text()` calls — the function appends the file extension automatically.

## Task-Specific Context

### Graphs
If you are making a graph, study `Context/graphs.md`.

### Tables
If you are making a table, study `Context/tables.md`.

### Writing
If you are writing paper text or LaTeX, study `Context/researcher_profile.md` for journal conventions.
