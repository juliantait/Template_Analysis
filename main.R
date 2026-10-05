# MAIN ANALYSIS SCRIPT
# Run this file to reproduce the entire analysis.
# Cleaning is commented out: the analysis loads the tracked data/data_cleaned.RData.

cat("\n=== ANALYSIS STARTING ===\n")

# Restore console output if a previous run was interrupted during sink()
while (sink.number() > 0) sink()

# --- CLEANING (only to rebuild) ---------------------------------------------
# To rebuild data/data_cleaned.{csv,RData} from data/datasets/: uncomment these three lines, run once, re-comment.
# source("scripts/config_init.R")
# source("scripts/config_cleaning.R")
# cat("Data cleaning complete.\n")

# --- SETUP ------------------------------------------------------------------
cat("Section: Setup\n")
source("scripts/config_init.R")
source("scripts/config_toolkit.R")

# --- LOAD DATA --------------------------------------------------------------
cat("Section: Data loading\n")
load("data/data_cleaned.RData")  # loads object named 'data'

# --- SAMPLE RESTRICTIONS ----------------------------------------------------
cat("Section: Sample restrictions\n")
source("scripts/sample_restrictions.R")

# --- CHECKPOINT -------------------------------------------------------------
cat("  -> Saving checkpoint\n")
save_checkpoint()

# --- MAIN ANALYSIS (in paper) ---------------------------------------------------------------
cat("Section: Analysis\n")

cat("  -> Balance table\n")
source("scripts/balance_table.R")

cat("  -> Descriptive statistics\n")
source("scripts/descriptives.R")

cat("  -> Hypothesis tests\n")
source("scripts/hypotheses.R")

cat("  -> Robustness checks\n")
source("scripts/robustness.R")

cat("  -> Exploratory analyses\n")
source("scripts/exploratory.R")

# --- FURTHER ANALYSIS (beyond paper) -------------------------------------------------------
# cat("Section: Further analysis\n")
# source("scripts/further_analysis/further_analysis.R")

# --- SYNC OUTPUTS -----------------------------------------------------------
cat("Section: Sync\n")
source("scripts/helper/config_sync_to_folder.R")

cat("\n=== ANALYSIS COMPLETE ===\n")
