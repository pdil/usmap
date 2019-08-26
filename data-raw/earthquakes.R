
earthquakes <- readxl::read_excel("data-raw/earthquakes.xlsx")
usethis::use_data(earthquakes, overwrite = TRUE)
