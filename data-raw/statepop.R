
statepop <- readxl::read_excel("data-raw/statepop.xlsx")
devtools::use_data(statepop, overwrite = TRUE)
