library(devtools)
install_github("dcaud/usmap")
library(usmap)

# notice new last data points for San Juan, Puerto Rico
data <- data.frame(
  lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86, -66.104),
  lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31, 18.466),
  pop = c(8398748, 2325502, 3990456, 2705994, 32113, 347397, 347052)
)

# Transform data
transformed_data <- usmap_transform(data)

# Plot transformed data on map
library(ggplot2)

plot_usmap() + geom_point(
  data = transformed_data,
  aes(x = lon.1, y = lat.1, size = pop),
  color = "red", alpha = 0.5
)


#########

plot_usmap(include = c("HI", "GA", "FL", "PR"))


centroid_labels <- utils::read.csv(system.file("extdata", paste0("us_", "PR", "_centroids.csv"), package = "usmap"),
                                   colClasses = centroidLabelsColClasses,
                                   stringsAsFactors = FALSE)
