library(shiny)
library(shinydashboard)
library(dplyr)

genie <- read.delim("genie_public_clinical_data.tsv")

list_sex <- sort(unique(genie$Sex))
list_race <- sort(unique(genie$Primary.Race))
list_ethnicity <- sort(unique(genie$Ethnicity.Category))
list_cancer_type <- sort(unique(genie$Cancer.Type))
list_cancer_type_detailed <- sort(unique(genie$Cancer.Type.Detailed))
list_center <- sort(unique(genie$Center))
