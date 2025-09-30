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
          plotOutput("survival_hist", height = 350)
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
          h2("About")
        )
      )
    )
  )
)