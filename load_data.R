

fev <- read.delim(here::here('slides/data/Lung_081217.txt'))
load( here::here("data/addhealth_clean.Rdata"))
depress <- read.delim(here::here("data/Depress.txt"))
names(depress) <- tolower(names(depress))

