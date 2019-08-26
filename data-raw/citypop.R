
citypop <- readxl::read_excel("data-raw/citypop.xlsx")
usethis::use_data(citypop, overwrite = TRUE)
