
us_map <- function(region, include = c()) {
  if (region %in% c("states", "counties")) {
    load(system.file("extdata", paste0("us_", region, ".rda"), package = "usmap"))
    return(map)
  } else {
    stop("Region must be either `states` or `counties`.")
  }
}