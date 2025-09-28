# GENIE Dashboard

A R Shiny dashboard application for exploring GENIE (Genomics Evidence Neoplasia Information Exchange) metadata using shinydashboard.

## Overview

This interactive dashboard provides tools for exploring cancer genomics metadata including:
- Sample and patient overview statistics
- Interactive data tables for sample exploration
- Cancer type distribution analysis
- Mutation count distributions
- Demographic analysis

## File Structure

This Shiny app follows the multi-file structure pattern:

- `global.R` - Shared libraries, constants, helper functions, and data loading
- `ui.R` - User interface definition using shinydashboard
- `server.R` - Server logic and reactive functions
- `app.R` - Alternative single-file entry point
- `DESCRIPTION` - Package dependencies

## Installation

### Prerequisites

Make sure you have R installed (version 3.6.0 or higher). Install the required packages:

```r
install.packages(c(
  "shiny",
  "shinydashboard", 
  "DT",
  "plotly",
  "dplyr",
  "ggplot2"
))
```

### Running the App

#### Option 1: Using the multi-file structure
```r
# Make sure you're in the project directory
setwd("path/to/genie-dashboard")

# Run the app (Shiny will automatically detect ui.R and server.R)
shiny::runApp()
```

#### Option 2: Using app.R
```r
# Run the single-file entry point
shiny::runApp("app.R")
```

#### Option 3: From RStudio
1. Open the project in RStudio
2. Open any of the R files (ui.R, server.R, or app.R)
3. Click the "Run App" button

## Features

### Overview Tab
- Value boxes showing total samples, patients, and cancer types
- Interactive plots for cancer type distribution and age demographics

### Sample Explorer Tab
- Interactive data table with filtering and search capabilities
- Sortable columns and pagination

### Cancer Types Tab
- Detailed analysis of cancer types by stage
- Summary statistics table

### Mutations Tab
- Distribution of mutation counts across samples

### About Tab
- Application information and version details

## Data

The current implementation uses sample data for demonstration purposes. To use with actual GENIE data:

1. Replace the `sample_genie_data` in `global.R` with your actual data loading logic
2. Ensure your data has the expected column structure:
   - `sample_id`: Unique sample identifier
   - `patient_id`: Patient identifier
   - `cancer_type`: Type of cancer
   - `stage`: Cancer stage (I, II, III, IV)
   - `age_at_diagnosis`: Age at diagnosis
   - `gender`: Patient gender
   - `mutation_count`: Number of mutations

## Customization

- Modify colors in the `dashboard_colors` list in `global.R`
- Add new tabs by extending the `sidebarMenu` in `ui.R` and corresponding `tabItem` sections
- Add new visualizations by creating reactive outputs in `server.R`

## License

MIT License
