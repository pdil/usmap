
countypop <- readxl::read_excel("data-raw/countypop.xlsx")
usethis::use_data(countypop, overwrite = TRUE)
