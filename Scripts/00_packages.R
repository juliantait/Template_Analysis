# =============================================================================
# PACKAGES
# =============================================================================
# All package loading in one place. Install any missing packages before loading.
# =============================================================================
cat("  -> Loading packages\n")

# --- Helper: install if missing ----------------------------------------------
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# --- Core packages -----------------------------------------------------------
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)

# --- Plotting ----------------------------------------------------------------
library(cowplot)
library(patchwork)
install_if_missing("showtext")
library(showtext)

# --- Statistical tests -------------------------------------------------------
library(coin)         # Non-parametric tests (Wilcoxon, sign tests)
install_if_missing("fixest")
library(fixest)       # Fixed effects regressions (feols, etable)
install_if_missing("lmtest")
library(lmtest)       # Linear model tests
install_if_missing("sandwich")
library(sandwich)     # Robust covariance matrices

# --- Tables ------------------------------------------------------------------
library(stargazer)
library(knitr)
library(kableExtra)
library(xtable)
