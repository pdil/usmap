
countypov <- readxl::read_excel("data-raw/countypov.xlsx")
devtools::use_data(countypov, overwrite = TRUE)
