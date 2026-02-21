# MAIN ANALYSIS SCRIPT
# Run this file to reproduce the entire analysis.
# Cleaning section: uncomment to regenerate cleaned data from raw files.

cat("\n=== ANALYSIS STARTING ===\n")

# Restore console output if a previous run was interrupted during sink()
while (sink.number() > 0) sink()

# --- CLEANING (run once, then comment out) ----------------------------------
# source("Scripts/config_init.R")
# source("Scripts/config_cleaning.R")
# cat("Data cleaning complete.\n")

# --- SETUP ------------------------------------------------------------------
cat("Section: Setup\n")
source("Scripts/config_init.R")
source("Scripts/config_toolkit.R")

# --- LOAD DATA --------------------------------------------------------------
cat("Section: Data loading\n")
load("Data/data_cleaned.RData")  # loads object named 'data'

# --- SAMPLE RESTRICTIONS ----------------------------------------------------
cat("Section: Sample restrictions\n")
source("Scripts/sample_restrictions.R")

# --- CHECKPOINT -------------------------------------------------------------
cat("  -> Saving checkpoint\n")
save_checkpoint()

# --- MAIN ANALYSIS (in paper) ---------------------------------------------------------------
cat("Section: Analysis\n")

cat("  -> Balance table\n")
source("Scripts/balance_table.R")

cat("  -> Descriptive statistics\n")
source("Scripts/descriptives.R")

cat("  -> Hypothesis tests\n")
source("Scripts/hypotheses.R")

cat("  -> Robustness checks\n")
source("Scripts/robustness.R")

cat("  -> Exploratory analyses\n")
source("Scripts/exploratory.R")

# --- FURTHER ANALYSIS (beyond paper) -------------------------------------------------------
# cat("Section: Further analysis\n")
# source("Scripts/Further Analysis/further_analysis.R")

# --- SYNC OUTPUTS -----------------------------------------------------------
cat("Section: Sync\n")
source("Helper/config_sync_to_folder.R")

cat("\n=== ANALYSIS COMPLETE ===\n")
