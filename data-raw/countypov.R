
countypov <- readxl::read_excel("data-raw/countypov.xlsx")
usethis::use_data(countypov, overwrite = TRUE)
