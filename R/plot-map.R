#' Conveniently plot basic US map
#' 
#' @param regions The region breakdown for the map, either \code{"states"}
#'   or \code{"counties"}.
#' @param theme The theme that should be used for plotting the map. The default
#'   is \code{\link[ggthemes]{theme_map}}.
#'
#' @return A \code{\link[ggplot2]{ggplot}} object that contains a basic
#'   US map with the described parameters.
#' 
#' @export
plot_usmap <- function(regions = "states", theme = ggthemes::theme_map()) {
  ggplot2::ggplot(
    data = us_map(regions = regions)
  ) + geom_polygon(
    aes(x = long, y = lat, group = group), 
    colour = "black",
    fill = "white",
    size = 0.4
  ) + theme
}
