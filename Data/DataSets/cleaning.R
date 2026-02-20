# cleaning.R — oTree raw data → long format
# This function reads oTree session CSVs, reshapes from wide (one row per
# participant) to long (one row per participant per round), and returns a
# combined data frame.
#
# Called by Scripts/config_cleaning.R. Edit the column mappings there.

clean_data <- function(working_directory, subfolder, file_names,
                       constant_variables, variables_to_export,
                       main_list, output_file) {
  setwd(working_directory)
  library(tidyr)
  library(dplyr)
  library(readr)

  # Columns to drop from raw oTree output (e.g. bank details, internal config)
  columns_to_remove <- c(
    # "session.config.participation_fee",
    # "participant.counter"
  )

  remove_columns <- function(df, cols) df %>% select(-any_of(cols))

  all_columns <- c("block", "round", names(variables_to_export), names(constant_variables))

  # --- Read and stack session CSVs ---
  data_list <- list()
  for (file in file_names) {
    file_path <- paste0(subfolder, file, ".csv")
    data <- read_csv(file_path, show_col_types = FALSE)
    data$participant.session <- file
    data <- remove_columns(data, columns_to_remove)
    data_list[[file]] <- data
  }

  # Align columns across sessions (missing columns → NA)
  all_cols <- Reduce(union, lapply(data_list, names))
  data_list <- lapply(data_list, function(df) {
    missing <- setdiff(all_cols, names(df))
    if (length(missing) > 0) df[missing] <- NA
    df[, all_cols, drop = FALSE]
  })

  data <- do.call(rbind, data_list)

  # --- Reshape: wide → long (one row per participant per round) ---
  process_data <- function(main_prefix, round_num) {
    round_data <- list(
      block = rep(main_prefix, nrow(data)),
      round = rep(round_num, nrow(data))
    )
    for (var_name in names(variables_to_export)) {
      col_name <- paste0(main_prefix, ".", round_num, ".", variables_to_export[var_name])
      round_data[[var_name]] <- if (col_name %in% names(data)) data[[col_name]] else NA
    }
    for (var_name in names(constant_variables)) {
      col_name <- constant_variables[var_name]
      round_data[[var_name]] <- if (col_name %in% names(data)) data[[col_name]] else NA
    }
    as.data.frame(round_data)[, all_columns]
  }

  # Generate long-format data across all blocks and rounds
  n_rounds <- 20  # adjust per experiment
  all_data <- lapply(main_list, function(prefix) {
    lapply(seq_len(n_rounds), function(i) process_data(prefix, i))
  })

  complete <- bind_rows(all_data) %>%
    mutate(
      block = as.numeric(sub("main", "", block)),
      round = as.numeric(round)
    ) %>%
    arrange(block, round)

  save(complete, file = output_file)
  cat("Data processing complete. Exported to", output_file, "\n")
  return(complete)
}
