# run_app.R
# Convenience script to run the GENIE Dashboard

# Check and install required packages if not available
required_packages <- c("shiny", "shinydashboard", "DT", "plotly", "dplyr", "ggplot2")

missing_packages <- required_packages[!required_packages %in% installed.packages()[,"Package"]]

if(length(missing_packages)) {
  cat("Installing missing packages:", paste(missing_packages, collapse = ", "), "\n")
  install.packages(missing_packages)
}

# Load all required packages
lapply(required_packages, library, character.only = TRUE)

# Run the app
cat("Starting GENIE Dashboard...\n")
shiny::runApp()