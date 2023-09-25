

library(tidyverse)
library(gt)
# Import data & create new variables
topic_mats <- googlesheets4::read_sheet("124fL_0yY26MjpfOTQalg-DR09vC7l8ITmi9mBoNAu8o", 
                                        sheet="weekly_schedule") %>%
  janitor::clean_names() %>% 
  mutate(assignment = gsub("hw", "../hw/hw", hw), 
       slides = sprintf("[%s](%s)", lecture, paste0("../slides/", lecture, ".html")), 
       collab = sprintf("[%s](%s)", collab_notes, collab_notes)) %>% 
  select(slides, collab, reading, assignment, topic_obj, quiz, topic)


# Function to clean strings & separate into lists
create_tabled_list <- function(var){
  var <- var[!is.na(var)]
  z <- str_split(var, "\n", simplify=TRUE)
  Z <- as.data.frame(z[z != ""])
  colnames(Z) <- "Items"
  
  Z |>
    filter(Items != "[NA](NA)") |>
    gt() |>
    fmt_markdown(columns = everything()) |>
    opt_row_striping() |>
    tab_options(table.align = "left")
}


