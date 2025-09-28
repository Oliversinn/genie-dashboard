# ui.R
# User Interface for GENIE Dashboard using shinydashboard

# Dashboard Header
header <- dashboardHeader(
  title = APP_TITLE,
  titleWidth = 300
)

# Dashboard Sidebar
sidebar <- dashboardSidebar(
  width = 300,
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
    menuItem("Sample Explorer", tabName = "samples", icon = icon("table")),
    menuItem("Cancer Types", tabName = "cancer_types", icon = icon("chart-pie")),
    menuItem("Mutations", tabName = "mutations", icon = icon("dna")),
    menuItem("About", tabName = "about", icon = icon("info-circle"))
  )
)

# Dashboard Body
body <- dashboardBody(
  tags$head(
    tags$style(HTML("
      .content-wrapper, .right-side {
        background-color: #f4f4f4;
      }
    "))
  ),
  
  tabItems(
    # Overview tab
    tabItem(tabName = "overview",
      fluidRow(
        valueBoxOutput("total_samples"),
        valueBoxOutput("total_patients"), 
        valueBoxOutput("cancer_types")
      ),
      fluidRow(
        box(
          title = "Sample Distribution by Cancer Type",
          status = "primary",
          solidHeader = TRUE,
          width = 6,
          plotlyOutput("cancer_type_plot")
        ),
        box(
          title = "Age Distribution",
          status = "primary", 
          solidHeader = TRUE,
          width = 6,
          plotlyOutput("age_distribution")
        )
      )
    ),
    
    # Sample Explorer tab
    tabItem(tabName = "samples",
      fluidRow(
        box(
          title = "Sample Data Explorer",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          DT::dataTableOutput("sample_table")
        )
      )
    ),
    
    # Cancer Types tab
    tabItem(tabName = "cancer_types",
      fluidRow(
        box(
          title = "Cancer Type Analysis",
          status = "primary",
          solidHeader = TRUE,
          width = 8,
          plotlyOutput("cancer_detailed_plot")
        ),
        box(
          title = "Statistics",
          status = "info",
          solidHeader = TRUE,
          width = 4,
          tableOutput("cancer_stats")
        )
      )
    ),
    
    # Mutations tab
    tabItem(tabName = "mutations",
      fluidRow(
        box(
          title = "Mutation Count Distribution",
          status = "primary",
          solidHeader = TRUE, 
          width = 12,
          plotlyOutput("mutation_plot")
        )
      )
    ),
    
    # About tab
    tabItem(tabName = "about",
      fluidRow(
        box(
          title = "About GENIE Dashboard",
          status = "info",
          solidHeader = TRUE,
          width = 12,
          HTML(paste0(
            "<h4>GENIE Metadata Explorer v", APP_VERSION, "</h4>",
            "<p>This dashboard provides an interactive interface for exploring GENIE (Genomics Evidence Neoplasia Information Exchange) metadata.</p>",
            "<h5>Features:</h5>",
            "<ul>",
            "<li>Sample overview and statistics</li>",
            "<li>Interactive data exploration</li>", 
            "<li>Cancer type analysis</li>",
            "<li>Mutation distribution analysis</li>",
            "</ul>",
            "<h5>Data Source:</h5>",
            "<p>Sample data is used for demonstration purposes. Replace with actual GENIE data in production.</p>"
          ))
        )
      )
    )
  )
)

# Combine all UI elements
dashboardPage(
  header = header,
  sidebar = sidebar, 
  body = body,
  skin = "blue"
)