
earthquakes <- readxl::read_excel("data-raw/earthquakes.xlsx")
devtools::use_data(earthquakes, overwrite = TRUE)
