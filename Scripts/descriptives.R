# =============================================================================
# DESCRIPTIVE STATISTICS & KEY VALUES
# =============================================================================
# Compute summary statistics and key values referenced in the paper.
# Uses the OutputValues class for structured output.
# Output: Text file to Text/
# =============================================================================
cat("    -> Computing descriptive statistics\n")

# --- OutputValues CLASS ------------------------------------------------------
# Structured container for (description, value) pairs used in the paper text.

OutputValues <- function(desc, value) {
  structure(
    list(desc = desc, value = value),
    class = "OutputValues"
  )
}

print.OutputValues <- function(x, ...) {
  cat(sprintf("%s: %s\n", x$desc, format(x$value, digits = 5)))
}

compile_values_text <- function(value_objects, header = "Key Values") {
  c(
    header, "",
    vapply(value_objects,
           function(x) sprintf("%s: %s", x$desc, format(x$value, digits = 5)),
           character(1))
  )
}

# --- EXAMPLE VALUE -----------------------------------------------------------
# mean_outcome_value <- OutputValues(
#   desc = "Mean outcome across all rounds",
#   value = round(mean(data$outcome, na.rm = TRUE), 2)
# )

# --- COMPILE & EXPORT -------------------------------------------------------
# output_values_list <- list(
#   mean_outcome_value
# )
#
# value_lines <- compile_values_text(output_values_list)
# save_text(value_lines, "descriptive_values")
