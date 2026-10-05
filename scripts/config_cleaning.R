# config_cleaning.R
# Orchestrator: loads raw data via a data-source adapter in scripts/helper/,
# generates derived variables, and saves ONE combined cleaned dataset to the root
# of data/ as both data_cleaned.csv and data_cleaned.RData.
# Commented out in main.R: uncomment there only to rebuild from data/datasets/.

cat("  -> Cleaning: combining and cleaning datasets\n")

if (!exists("OUTPUT_ROOT")) source("scripts/config_init.R")

library(readr)
library(tidyr)
library(dplyr)
library(stringr)

# === DATA SOURCE ===
# Set to "otree" or "csv" to select the adapter in scripts/helper/.
data_source <- "otree"

source(paste0("scripts/helper/", data_source, ".R"))

# === LOAD AND RESHAPE ===
data <- load_data(subfolder = "data/datasets/")

# === VARIABLE GENERATION ===
# Create derived variables here. Examples:
#
# data$block <- ifelse(data$round <= 10, 1L, 2L)
# data$treated <- ifelse(data$treatment == "treatment", 1, 0)
# data$male <- ifelse(data$gender == "Male", 1, ifelse(data$gender == "Female", 0, NA))

# === SAVE CLEANED DATA ===
save(data, file = "data/data_cleaned.RData", compress = FALSE)
write.csv(data, "data/data_cleaned.csv", row.names = FALSE)

cat(sprintf("  -> Saved: data_cleaned (%d observations)\n", nrow(data)))
