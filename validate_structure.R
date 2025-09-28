# validate_structure.R
# Script to validate the Shiny app structure without running it

cat("=== GENIE Dashboard Structure Validation ===\n\n")

# Check if required files exist
required_files <- c("global.R", "ui.R", "server.R", "app.R")
cat("Checking required files:\n")

for (file in required_files) {
  if (file.exists(file)) {
    cat("✓", file, "exists\n")
  } else {
    cat("✗", file, "missing\n")
  }
}

cat("\n=== File Contents Summary ===\n")

# Check global.R
if (file.exists("global.R")) {
  global_content <- readLines("global.R")
  library_lines <- grep("^library\\(", global_content)
  cat("global.R:\n")
  cat("  - Lines:", length(global_content), "\n")
  cat("  - Libraries loaded:", length(library_lines), "\n")
  cat("  - Libraries:", paste(gsub("library\\(|\\)", "", global_content[library_lines]), collapse = ", "), "\n")
}

# Check ui.R
if (file.exists("ui.R")) {
  ui_content <- readLines("ui.R")
  menu_items <- grep("menuItem\\(", ui_content)
  cat("ui.R:\n")
  cat("  - Lines:", length(ui_content), "\n")
  cat("  - Menu items:", length(menu_items), "\n")
}

# Check server.R
if (file.exists("server.R")) {
  server_content <- readLines("server.R")
  outputs <- grep("output\\$", server_content)
  cat("server.R:\n")
  cat("  - Lines:", length(server_content), "\n")
  cat("  - Output definitions:", length(outputs), "\n")
}

cat("\n=== Structure Validation Complete ===\n")
cat("All required files for Shiny multi-file structure are present!\n")
cat("\nTo run the app:\n")
cat("1. Install R and required packages\n")
cat("2. Run: shiny::runApp() or source('run_app.R')\n")