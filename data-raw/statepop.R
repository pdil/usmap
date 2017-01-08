
statepop <- readr::read_csv("data-raw/statepop.csv")
devtools::use_data(statepop, overwrite = TRUE)
