# Helper/csv.R — Generic CSV data-source adapter
# Reads CSV files that are already in long format (one row per observation).
# Stacks multiple files, renames columns, and returns a data.frame.
#
# Called by Scripts/config_cleaning.R when data_source <- "csv".
# Edit the configuration below to match your dataset.

# === SESSION FILES ===
# Leave empty to auto-detect all CSVs in the data subfolder.
file_names <- c()

# === COLUMN MAPPING ===
# Map: analysis_name = "raw_column_name"
# Columns listed here are renamed; unlisted columns are dropped unless
# they appear in keep_extra.
column_map <- c(
  # participant_id = "subject_id",
  # session        = "session_label",
  # round          = "period",
  # decision       = "choice",
  # payoff         = "earnings"
)

# === EXTRA COLUMNS TO KEEP ===
# Raw column names to retain without renaming.
keep_extra <- c()

# === CSV FORMAT ===
separator  <- ","
skip_rows  <- 0


# =============================================================================
# load_data(subfolder)
# Reads CSVs, stacks them, applies column renaming/selection.
# Returns a data.frame ready for variable generation.
# =============================================================================

load_data <- function(subfolder) {

  # --- Auto-detect files if none specified ---
  if (length(file_names) == 0) {
    detected <- sub("\\.csv$", "", list.files(subfolder, pattern = "\\.csv$"))
    if (length(detected) == 0) stop("No CSV files found in ", subfolder)
  } else {
    detected <- file_names
  }

  # --- Read and stack CSVs ---
  data_list <- lapply(detected, function(file) {
    file_path <- paste0(subfolder, file, ".csv")
    read_delim(file_path, delim = separator, skip = skip_rows,
               show_col_types = FALSE)
  })

  data <- bind_rows(data_list)

  # --- Apply column mapping ---
  if (length(column_map) > 0) {
    # Check which raw columns exist
    present <- column_map[column_map %in% names(data)]
    if (length(present) > 0) {
      mapped <- data[, present, drop = FALSE]
      names(mapped) <- names(present)
    } else {
      mapped <- data.frame(row.names = seq_len(nrow(data)))
    }
  } else {
    mapped <- data.frame(row.names = seq_len(nrow(data)))
  }

  # --- Keep extra columns ---
  if (length(keep_extra) > 0) {
    extras <- data[, intersect(keep_extra, names(data)), drop = FALSE]
    mapped <- cbind(mapped, extras)
  }

  # If no mapping was defined, return the full data as-is
  if (length(column_map) == 0 && length(keep_extra) == 0) {
    return(data)
  }

  mapped
}
