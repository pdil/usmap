
rivers <- sf::st_read("data-raw/rivers.gdb")
usethis::use_data(rivers, overwrite = TRUE)
