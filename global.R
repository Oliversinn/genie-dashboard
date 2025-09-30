library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)


genie <- read.delim("genie_public_clinical_data.tsv") %>% 
  mutate(
    Age.at.Sequencing = as.numeric(Age.at.Which.Sequencing.was.Reported..Years.),
    # convert days -> years using 365
    Age.at.Death      = as.numeric(Interval.in.days.from.DOB.to.DOD) / 365,
    interval_dod      = Age.at.Death - Age.at.Sequencing
  )

list_sex <- sort(unique(genie$Sex))
list_race <- sort(unique(genie$Primary.Race))
list_ethnicity <- sort(unique(genie$Ethnicity.Category))
list_cancer_type <- sort(unique(genie$Cancer.Type))
list_cancer_type_detailed <- sort(unique(genie$Cancer.Type.Detailed))
list_center <- sort(unique(genie$Center))


vb_style <- function(msg = "", style = "font-size: 100%;") {
  tags$p(msg, style = style)
}

survival_bar_plot <- function(df) {
  df %>%
    filter(!is.na(interval_dod), interval_dod >= 0) %>%
    mutate(
      interval_group = ifelse(interval_dod < 1, "<1",
                              ifelse(interval_dod < 2, "1",
                                     ifelse(interval_dod < 3, "2",
                                            ifelse(interval_dod < 4, "3",
                                                   ifelse(interval_dod < 5, "4",
                                                          ifelse(interval_dod < 6, "5", "6+"))))))
    ) %>%
    group_by(interval_group) %>%
    summarise(count = n()) %>%
    ggplot(aes(x = interval_group, y = count)) +
    geom_col(fill = "steelblue") +
    scale_x_discrete(
      limits = c("<1", "1", "2", "3", "4", "5", "6+")
    ) +
    labs(
      title = "Patient Survival after Cancer Sequencing",
      x = "Years from Sequencing to Death",
      y = "Number of Cases"
    ) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
}