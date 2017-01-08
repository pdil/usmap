
countypop <- readxl::read_excel("data-raw/countypop.xlsx")
devtools::use_data(countypop, overwrite = TRUE)
