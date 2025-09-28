# app.R
# Alternative single-file entry point for the GENIE Dashboard
# This file sources the multi-file structure (global.R, ui.R, server.R)

# Source the global file first
source("global.R")

# Source UI and Server
ui <- source("ui.R", local = TRUE)$value
server <- source("server.R", local = TRUE)$value

# Run the application
shinyApp(ui = ui, server = server)