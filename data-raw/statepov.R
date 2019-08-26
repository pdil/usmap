
statepov <- readxl::read_excel("data-raw/statepov.xlsx")
usethis::use_data(statepov, overwrite = TRUE)
