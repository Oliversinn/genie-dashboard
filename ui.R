dashboardPage(
  skin = "green",
  title = "GENIE",
  header = dashboardHeader(title = "GENIE"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebarid",
      menuItem(
        "Dashboard",
        tabName = "dashboard",
        icon = icon("gauge")
      ),
      menuItem(
        "Data Explorer",
        tabName = "data_explorer",
        icon = icon("table")
      ),
      conditionalPanel(
        'input.sidebarid != "about"',
        selectInput(
          "sex_selector",
          label = "Sex",
          multiple = T,
          choices = list_sex
        ),
        selectInput(
          "race_selector",
          label = "Race",
          multiple = T,
          choices = list_race
        ),
        selectInput(
          "ethnicity_selector",
          label = "Ethnicity",
          multiple = T,
          choices = list_ethnicity
        ),
        selectInput(
          "cancer_type_selector",
          label = "Cancer Type",
          multiple = T,
          choices = list_cancer_type
        ),
        selectInput(
          "cancer_type_detailed_selector",
          label = "Cancer Detailed",
          multiple = T,
          choices = list_cancer_type_detailed
        ),
        selectInput(
          "center_selector",
          label = "Center",
          multiple = T,
          choices = list_center
        ) 
      ),
      menuItem(
        "About",
        tabName = "about",
        icon = icon("circle-info")
      )
    )
  ),
  body = dashboardBody(
    fluidPage(
      tabItems(
        # Dashboard Tab ----
        tabItem(
          tabName = "dashboard",
          h2("Dashboard"),
          fluidRow(
            valueBoxOutput("box_centers", width = 3),
            valueBoxOutput("box_cases", width = 3),
            valueBoxOutput("box_cancer_type", width = 3),
            valueBoxOutput("box_interval_of_death", width = 3)
          ),
          fluidRow(
            width = 12,
            tabBox(
              width = 12,
              height = "400px",
              tabPanel(
                title = "Cancer Types",
                icon = icon("disease"),
                plotOutput("cancer_barplot", height = 350)
              ),
              tabPanel(
                title = "Overall Survival",
                icon = icon("user-clock"),
                plotOutput("survival_hist", height = 350)
              )
            )
          ),
          fluidRow(
            width = 12,
            tabBox(
              width = 6,
              height = "400px",
              tabPanel(
                title = "Demographic Pyramid",
                icon = icon("venus-mars"),
                plotOutput("demographic_pyramid", height = 350)
              )
            ),
            tabBox(
              width = 6,
              height = "400px",
              tabPanel(
                title = "Race",
                icon = icon("earth-americas"),
                plotOutput("race_barplot", height = 350)
              ),
              tabPanel(
                title = "Ethnicity",
                icon = icon("chart-simple"),
                plotOutput("ethnicity_barplot", height = 350)
              ),
              tabPanel(
                title = "Ethnicity by Center",
                icon = icon("chart-simple"),
                plotOutput("ethnicity_heatmap", height = 350)
              )
            )
          )
        ),
        # Data Explorer Tab ----
        tabItem(
          tabName = "data_explorer",
          h2("Data Explorer"),
          dataTableOutput("genie_head")
        ),
        # About Tab ----
        tabItem(
          tabName = "about",
          box(
            title = "About this App",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            collapsible = TRUE,
            tags$div(
              tags$p(
                "This dashboard uses demographic data from ",
                tags$b("AACR Project GENIE (Genomics Evidence Neoplasia Information Exchange)"),
                ", an international cancer genomics initiative led by the ",
                tags$b("American Association for Cancer Research (AACR)"),
                ". GENIE collects and harmonizes clinical–genomic data from cancer centers worldwide, creating one of the largest real-world oncology datasets available."
              ),
              tags$p(
                "The data for this application were obtained through the ",
                tags$b("cBioPortal for Cancer Genomics"),
                ", a widely used open-access platform for exploring cancer genomics datasets. The portal can be accessed at",
                tags$a(href = "https://genie.cbioportal.org", target = "_blank", "https://genie.cbioportal.org"),
              ),
              tags$h4("Purpose of this Dashboard"),
              tags$p(
                "This Shiny app provides an interactive view of the ",
                tags$b("demographic characteristics"),
                " of patients represented in the GENIE dataset. Users can explore distributions and trends across variables such as:"
              ),
              tags$ul(
                tags$li("Age"),
                tags$li("Sex"),
                tags$li("Race and ethnicity"),
                tags$li("Cancer type")
              ),
              tags$h4("Disclaimer"),
              tags$p(
                "This dashboard is intended for ",
                tags$b("research and educational purposes only"),
                ". The GENIE dataset is de-identified, and analyses are limited to aggregate demographic information. Results should not be interpreted as medical advice or guidance. Please acknowledge ",
                tags$b("AACR Project GENIE"),
                " and ",
                tags$b("cBioPortal"),
                " when using insights derived from this tool."
              )
            )
          )
        )
      )
    )
  )
)