
citypop <- readxl::read_excel("data-raw/citypop.xlsx")
devtools::use_data(citypop, overwrite = TRUE)
