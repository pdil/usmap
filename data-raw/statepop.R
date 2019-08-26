
statepop <- readxl::read_excel("data-raw/statepop.xlsx")
usethis::use_data(statepop, overwrite = TRUE)
