# Config init: Clear environment, set working directory, and configure paths
cat("  -> Init (clearing environment, setting paths)\n")

rm(list = ls())

# Set working directory to project root
# Update this path when setting up a new project
# Outside RStudio (e.g. Rscript main.R), run from the project root instead.
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}

# === OUTPUT PATHS ===
OUTPUT_ROOT <- file.path(getwd(), "LaTeX", "output")

# === SYNC DESTINATIONS ===
# Extra folders to mirror the output/ structure into. The canonical use-case
# is a local Overleaf clone — point this at the output/ subfolder of the
# cloned project and every save_graph/save_table/save_text writes there too.
SYNC_DESTINATIONS <- c(
  # path.expand("~/Overleaf/your-project/output")
)

# Reset package namespaces (prevents cached modifications from prior runs)
if ("package:knitr" %in% search()) detach("package:knitr", unload = TRUE)
if ("package:kableExtra" %in% search()) detach("package:kableExtra", unload = TRUE)
