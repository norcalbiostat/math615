
library(tidyverse)
library(gt)

topic_mats <- googlesheets4::read_sheet("19EBk4rX0bS2a0eYZPxdpEGs18lnwu02hxukFfB3-TNc", 
                                               sheet="module_overview", 
                                               col_types = c("nnccccccc")) 
  # janitor::clean_names() %>% 
  # mutate(assignment = gsub("hw", "../hw/hw", hw), 
  #      slides = sprintf("[%s](%s)", lecture, paste0("../slides/", lecture, ".html")), 
  #      collab = sprintf("[%s](%s)", collab_notes, collab_notes)) %>% 
  # select(slides, collab, reading, assignment, topic_obj, quiz, topic)


# Function to clean strings & separate into lists
create_tabled_list <- function(var){
  var <- var[!is.na(var)]
  z <- str_split(var, "\n", simplify=TRUE)
  Z <- as.data.frame(z[z != ""])
  colnames(Z) <- "Items"
  
  Z |>
    filter(!grepl("[NA]", Items, fixed=TRUE)) |>
    gt() |>
    fmt_markdown(columns = everything()) |>
    opt_row_striping() |>
    tab_options(table.align = "left")
}

