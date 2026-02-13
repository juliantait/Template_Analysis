# Empirical Analysis Template

Self-contained template for a single-experiment empirical analysis paper.

## Structure

```
Template/
├── main.R                          # Run this to execute the full analysis
├── Data/                           # Place cleaned data here (.RData or .csv)
├── Scripts/
│   ├── 00_packages.R               # Package loading
│   ├── 01_settings.R               # Palette, theme, output paths, save functions
│   ├── 02_cleaning.R               # Data loading and cleaning
│   ├── 03_variable_generation.R    # Derived/computed variables
│   ├── 04_sample_restrictions.R    # Exclusion criteria and subsetting
│   ├── 05_balance_table.R          # Randomisation balance checks
│   ├── 06_descriptives.R           # OutputValues class and summary statistics
│   ├── 07_hypotheses.R             # Main hypothesis tests
│   ├── 08_robustness.R             # Regression robustness checks
│   └── 09_exploratory.R            # Exploratory analyses
├── Output/
│   ├── Graphs/                     # .png files
│   ├── Tables/                     # .tex files (LaTeX tables)
│   └── Text/                       # .txt files (key values, test results)
└── LaTeX/
    ├── main.tex                    # Article document (compile with pdflatex + bibtex)
    ├── abstract.tex                # Abstract
    ├── introduction.tex            # Introduction
    ├── theory.tex                  # Theoretical framework
    ├── experiment.tex              # Experimental design and hypotheses
    ├── results.tex                 # Results (references Output/ tables and graphs)
    ├── discussion.tex              # Discussion
    ├── appendix.tex                # Appendix tables and figures
    └── references.bib              # Bibliography
```

## Usage

1. Place your cleaned data in `Data/`.
2. Edit `Scripts/02_cleaning.R` to load and clean your data.
3. Fill in the analysis scripts (03-09) for your experiment.
4. Adjust `output_paths` in `Scripts/01_settings.R` to add external output destinations (e.g., Overleaf).
5. Open `Template.Rproj` in RStudio and run `main.R`.

## Output Paths

The `save_graph()`, `save_table()`, and `save_text()` functions in `01_settings.R` write to every path in the `output_paths` vector. To send output to multiple locations (e.g., local + Overleaf), add paths to the vector:

```r
output_paths <- c(
  file.path(getwd(), "Output"),
  "/path/to/Overleaf/project/Output"
)
```
