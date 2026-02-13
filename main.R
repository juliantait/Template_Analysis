# =============================================================================
# MAIN ANALYSIS SCRIPT
# =============================================================================
# Master script: sources all scripts in order.
# Run this file to reproduce the entire analysis.
# =============================================================================

cat("\n=== ANALYSIS STARTING ===\n")

# Clear environment
rm(list = ls())

# Set working directory to project root (where this file lives)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# --- SETUP -------------------------------------------------------------------
cat("Section: Setup\n")
source("Scripts/00_packages.R")
source("Scripts/01_settings.R")

# --- DATA PREPARATION --------------------------------------------------------
cat("Section: Data preparation\n")
source("Scripts/02_cleaning.R")
source("Scripts/03_variable_generation.R")
source("Scripts/04_sample_restrictions.R")

# --- ANALYSIS ----------------------------------------------------------------
cat("Section: Analysis\n")

## Balance Table
cat("  -> Balance table\n")
source("Scripts/05_balance_table.R")

## Descriptive Statistics & Key Values
cat("  -> Descriptive statistics\n")
source("Scripts/06_descriptives.R")

## Main Hypothesis Tests
cat("  -> Hypothesis tests\n")
source("Scripts/07_hypotheses.R")

## Robustness Checks
cat("  -> Robustness checks\n")
source("Scripts/08_robustness.R")

## Exploratory Analyses
cat("  -> Exploratory analyses\n")
source("Scripts/09_exploratory.R")

cat("\n=== ANALYSIS COMPLETE ===\n")
