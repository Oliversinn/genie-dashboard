server <- function(input, output) { 
  genie_reactive <- reactive({
    df <- genie
    
    if (!is.null(input$sex_selector) && length(input$sex_selector) > 0) {
      df <- df %>% filter(Sex %in% input$sex_selector)
    }
    if (!is.null(input$race_selector) && length(input$race_selector) > 0) {
      df <- df %>% filter(Primary.Race %in% input$race_selector)
    }
    if (!is.null(input$ethnicity_selector) && length(input$ethnicity_selector) > 0) {
      df <- df %>% filter(Ethnicity.Category %in% input$ethnicity_selector)
    }
    if (!is.null(input$cancer_type_selector) && length(input$cancer_type_selector) > 0) {
      df <- df %>% filter(Cancer.Type %in% input$cancer_type_selector)
    }
    if (!is.null(input$cancer_type_detailed_selector) && length(input$cancer_type_detailed_selector) > 0) {
      df <- df %>% filter(Cancer.Type.Detailed %in% input$cancer_type_detailed_selector)
    }
    if (!is.null(input$center_selector) && length(input$center_selector) > 0) {
      df <- df %>% filter(Center %in% input$center_selector)
    }
    
    df
  })
  
  # Value Boxes ----
  ## Centers ----
  output$box_centers <- renderValueBox({
    number_of_centers <- genie_reactive() %>%
      summarise(n_centers = n_distinct(Center)) %>%
      pull(n_centers)
    valueBox(
      vb_style(
        number_of_centers, "font-size: 90%;"
      ),
      vb_style(
        "Number of centers", "font-size: 95%;"
      ),
      icon = icon("hospital"),
      color = "orange"
    )
  })
  
  ## Cases ----
  output$box_cases <- renderValueBox({
    number_of_cases <- genie_reactive() %>%
      summarise(n_cases = n_distinct(Patient.ID)) %>%
      pull(n_cases)
    valueBox(
      vb_style(
        number_of_cases, "font-size: 90%;"
      ),
      vb_style(
        "Number of cases", "font-size: 95%;"
      ),
      icon = icon("user-group"),
      color = "orange"
    )
  })
  
  ## Cancer Type ----
  output$box_cancer_type <- renderValueBox({
    number_of_cancers <- genie_reactive() %>%
      summarise(n_cancers = n_distinct(Cancer.Type)) %>%
      pull(n_cancers)
    valueBox(
      vb_style(
        number_of_cancers, "font-size: 90%;"
      ),
      vb_style(
        "Number of cancer types", "font-size: 95%;"
      ),
      icon = icon("disease"),
      color = "orange"
    )
  })
  
  ## Interval of Death ----
  output$box_interval_of_death <- renderValueBox({
    avg_interval_dod <- genie_reactive() %>%
      filter(!is.na(interval_dod), interval_dod >= 0) %>%
      summarise(avg_dod = mean(interval_dod)) %>%
      pull(avg_dod) %>%
      round(2)
    valueBox(
      vb_style(
        avg_interval_dod, "font-size: 90%;"
      ),
      vb_style(
        "Avg. interval of death (years)", "font-size: 95%;"
      ),
      icon = icon("clock"),
      color = "orange"
    )
  })
  
  # Genie data table ----
  
  output$genie_head <- renderDataTable({
    genie_reactive()
  },
  options = list(
    scrollX = TRUE,
    pageLength = 10,
    lengthMenu = c(5, 10, 25, 50),
    autoWidth = TRUE
  ))
  
  
  output$survival_hist <- renderPlot({
    df <- genie_reactive()
    if (nrow(df) == 0) return(NULL)
    survival_bar_plot(df)
  })
  
  output$cancer_barplot <- renderPlot({
    df <- genie_reactive()
    if (nrow(df) == 0) return(NULL)
    cancer_barplot(df)
  })
  
  output$demographic_pyramid <- renderPlot({
    df <- genie_reactive()
    if (nrow(df) == 0) return(NULL)
    demographic_pyramid(df)
  })
  
  output$ethnicity_barplot <- renderPlot({
    df <- genie_reactive()
    if (nrow(df) == 0) return(NULL)
    ethincity_barplot(df)
  })
  
  output$ethnicity_heatmap <- renderPlot({
    df <- genie_reactive()
    if (nrow(df) == 0) return(NULL)
    ethnicity_heatmap(df)
  })
  
  output$race_barplot <- renderPlot({
    df <- genie_reactive()
    if (nrow(df) == 0) return(NULL)
    race_barplot(df)
  })
}