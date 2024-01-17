
usrivers <- sf::st_read("data-raw/usrivers.gdb")
usethis::use_data(usrivers, overwrite = TRUE)
