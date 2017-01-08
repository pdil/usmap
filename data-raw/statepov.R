
statepov <- readxl::read_excel("data-raw/statepov.xlsx")
devtools::use_data(statepov, overwrite = TRUE)
