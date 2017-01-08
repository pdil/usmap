
countypop <- readr::read_csv("data-raw/countypop.csv")
devtools::use_data(countypop, overwrite = TRUE)
