library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
library(lubridate)
library(scales)
library(ggthemes)


genie <- read.delim("genie_public_clinical_data.tsv") %>%
  rename(
    Age.at.Sequencing = Age.at.Which.Sequencing.was.Reported..Years.
  ) %>% 
  mutate(
    Age.at.Sequencing = ifelse(str_detect(Age.at.Sequencing, "Unknown"), NA, Age.at.Sequencing),
    Age.at.Sequencing = ifelse(str_detect(Age.at.Sequencing, "<18"), "12", Age.at.Sequencing),
    Age.at.Sequencing = ifelse(str_detect(Age.at.Sequencing, ">89"), "90", Age.at.Sequencing),
    Age.at.Sequencing = as.numeric(Age.at.Sequencing),
    Age.at.Death      = as.numeric(Interval.in.days.from.DOB.to.DOD) / 365,
    interval_dod      = Age.at.Death - Age.at.Sequencing,
    Sex = ifelse(str_detect(Sex, "Unknown"), NA, Sex),
    Sex = ifelse(str_detect(Sex, "Other"), NA, Sex),
    Sex = ifelse(str_detect(Sex, "Transsexual"), NA, Sex),
    Primary.Race = if_else(is.na(Primary.Race) | Primary.Race == "Not Collected", 
                           "Unknown", Primary.Race),
    `Ethnicity Category` = if_else(
      is.na(`Ethnicity.Category`) |
        `Ethnicity.Category` == "" |
        `Ethnicity.Category` == "Not Collected",
      "Unknown",
      `Ethnicity.Category`
    ),
    # Clean 'Center' string values
    Center = str_squish(Center),
    Center = na_if(Center, ""),
    
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



# Ethnicity barplot
ethincity_barplot = function(df){
  eth_levels = df %>% 
    count(`Ethnicity Category`, name = "n") %>%
    arrange(desc(n)) %>% 
    pull(`Ethnicity Category`)
  
  eth_levels = c(setdiff(eth_levels, c("Other","Unknown")), intersect(c("Other","Unknown"), eth_levels))
  
  df %>% 
    mutate(`Ethnicity Category` = factor(`Ethnicity Category`, levels = eth_levels)) %>%
    ggplot(aes(x = `Ethnicity Category`)) +
    geom_bar(fill = "steelblue", color = "black") +
    labs(
      title = "Ethnicity",
      x = "Ethnicity",
      y = "Cases"
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
}


ethnicity_heatmap = function(df){
  ## ethnicity heat map: Data preparation
  heatmap = df %>% 
    filter(!is.na(Center), !is.na(`Ethnicity Category`)) %>%
    count(Center, `Ethnicity Category`, name = "n") %>%
    group_by(Center) %>%
    mutate(pct = n / sum(n)) %>%        
    ungroup()

  ggplot(heatmap, aes(x = `Ethnicity Category`, y = Center, fill = pct)) +
    geom_tile() +
    scale_fill_continuous(labels = scales::percent) +
    labs(title = "Ethnicity by Center (proportion within Center)",
         x = "Ethnicity", y = "Center", fill = "Share") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}


demographic_pyramid = function(df){
  df %>% 
    ggplot(aes(x=Age.at.Sequencing, fill = Sex)) +
    geom_histogram(data = df %>% filter(Sex == "Female"),
                   breaks = seq(0,95,5),
                   color = "white")+
    geom_histogram(data = df %>% filter(Sex == "Male"),
                   breaks = seq(0,95,5),
                   mapping = aes(y = ..count..*(-1)),
                   color = "white")+
    coord_flip() +
    labs(
      y = "Number of Cases",
      x = "Age (at sequencing)",
      title = "Cancer Cases by Age & Sex"
    )
}


race_barplot <- function(df){
  df %>%
    count(Primary.Race) %>%                               # get counts
    mutate(Primary.Race = reorder(Primary.Race, -n)) %>%  # reorder by descending count
    ggplot(aes(x = Primary.Race, y = n)) +
    geom_col(fill = "steelblue", color = "black") +        # use geom_col since we have counts
    labs(
      title = "Primary Race",
      x = "Race",
      y = "Cases"
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 14), 
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
}

cancer_barplot <- function(df) {
  df %>%
    filter(!is.na(Cancer.Type)) %>%
    count(Cancer.Type, sort = TRUE) %>%   # count and sort descending
    slice_max(n, n = 15) %>%              # keep top 10
    ggplot(aes(x = reorder(Cancer.Type, n), y = n)) +
    geom_col(fill = "steelblue", color = "black") +
    coord_flip() +                        # flip for readability
    labs(
      title = "Top 15 Cancer Types",
      x = "Cancer Type",
      y = "Cases"
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 14)
    )
}
