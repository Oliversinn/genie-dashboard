# server.R
# Server logic for GENIE Dashboard

function(input, output, session) {
  
  # Value boxes for overview
  output$total_samples <- renderValueBox({
    valueBox(
      value = format_number(nrow(sample_genie_data)),
      subtitle = "Total Samples",
      icon = icon("vial"),
      color = "blue"
    )
  })
  
  output$total_patients <- renderValueBox({
    valueBox(
      value = format_number(length(unique(sample_genie_data$patient_id))),
      subtitle = "Total Patients", 
      icon = icon("user"),
      color = "green"
    )
  })
  
  output$cancer_types <- renderValueBox({
    valueBox(
      value = length(unique(sample_genie_data$cancer_type)),
      subtitle = "Cancer Types",
      icon = icon("heartbeat"),
      color = "yellow"
    )
  })
  
  # Cancer type distribution plot
  output$cancer_type_plot <- renderPlotly({
    cancer_counts <- sample_genie_data %>%
      count(cancer_type, name = "count") %>%
      arrange(desc(count))
    
    p <- ggplot(cancer_counts, aes(x = reorder(cancer_type, count), y = count)) +
      geom_bar(stat = "identity", fill = dashboard_colors$primary) +
      coord_flip() +
      labs(
        title = "Sample Count by Cancer Type",
        x = "Cancer Type",
        y = "Number of Samples"
      ) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Age distribution plot
  output$age_distribution <- renderPlotly({
    p <- ggplot(sample_genie_data, aes(x = age_at_diagnosis)) +
      geom_histogram(bins = 20, fill = dashboard_colors$info, alpha = 0.7) +
      labs(
        title = "Age at Diagnosis Distribution",
        x = "Age at Diagnosis",
        y = "Frequency"
      ) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Sample data table
  output$sample_table <- DT::renderDataTable({
    DT::datatable(
      sample_genie_data,
      options = list(
        pageLength = 15,
        scrollX = TRUE,
        searchHighlight = TRUE
      ),
      filter = "top",
      rownames = FALSE
    )
  })
  
  # Detailed cancer type analysis
  output$cancer_detailed_plot <- renderPlotly({
    cancer_stage_data <- sample_genie_data %>%
      count(cancer_type, stage) %>%
      arrange(cancer_type, stage)
    
    p <- ggplot(cancer_stage_data, aes(x = cancer_type, y = n, fill = stage)) +
      geom_bar(stat = "identity", position = "stack") +
      coord_flip() +
      labs(
        title = "Cancer Types by Stage",
        x = "Cancer Type",
        y = "Number of Samples",
        fill = "Stage"
      ) +
      theme_minimal() +
      theme(legend.position = "bottom")
    
    ggplotly(p)
  })
  
  # Cancer statistics table
  output$cancer_stats <- renderTable({
    stats <- sample_genie_data %>%
      group_by(cancer_type) %>%
      summarise(
        Samples = n(),
        `Avg Age` = round(mean(age_at_diagnosis, na.rm = TRUE), 1),
        `Avg Mutations` = round(mean(mutation_count, na.rm = TRUE), 1),
        .groups = "drop"
      ) %>%
      arrange(desc(Samples))
    
    stats
  }, striped = TRUE, hover = TRUE)
  
  # Mutation distribution plot
  output$mutation_plot <- renderPlotly({
    p <- ggplot(sample_genie_data, aes(x = mutation_count)) +
      geom_histogram(bins = 20, fill = dashboard_colors$warning, alpha = 0.7) +
      labs(
        title = "Distribution of Mutation Counts",
        x = "Number of Mutations",
        y = "Number of Samples"
      ) +
      theme_minimal()
    
    ggplotly(p)
  })
}