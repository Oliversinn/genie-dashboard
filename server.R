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
  
  output$genie_head <- renderDataTable({
    genie_reactive()
  },
  options = list(
    scrollX = TRUE,        # enables horizontal scrolling
    pageLength = 10,       # show 10 rows per page
    lengthMenu = c(5, 10, 25, 50), # dropdown to change rows/page
    autoWidth = TRUE       # adjust column widths
  ))
}