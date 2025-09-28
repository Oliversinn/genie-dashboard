# global.R
# Shared libraries, constants, and data loading for GENIE Dashboard

# Load required libraries
library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(dplyr)
library(ggplot2)

# Global constants
APP_TITLE <- "GENIE Metadata Explorer"
APP_VERSION <- "1.0.0"

# Sample data structure for GENIE metadata (replace with actual data loading)
sample_genie_data <- data.frame(
  sample_id = paste0("SAMPLE_", 1:100),
  patient_id = paste0("PATIENT_", rep(1:50, each = 2)),
  cancer_type = sample(c("Lung Cancer", "Breast Cancer", "Colorectal Cancer", 
                        "Prostate Cancer", "Melanoma"), 100, replace = TRUE),
  stage = sample(c("I", "II", "III", "IV"), 100, replace = TRUE),
  age_at_diagnosis = sample(30:80, 100, replace = TRUE),
  gender = sample(c("Male", "Female"), 100, replace = TRUE),
  mutation_count = sample(1:50, 100, replace = TRUE),
  stringsAsFactors = FALSE
)

# Helper functions
format_number <- function(x) {
  formatC(x, format = "d", big.mark = ",")
}

# Color palette for the dashboard
dashboard_colors <- list(
  primary = "#3c8dbc",
  success = "#00a65a", 
  warning = "#f39c12",
  danger = "#dd4b39",
  info = "#00c0ef"
)