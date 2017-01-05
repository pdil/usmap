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
plot_usmap <- function(regions = "states", theme = theme_map()) {
  ggplot2::ggplot(
    data = us_map(regions = regions)
  ) + geom_polygon(
    aes(x = long, y = lat, group = group), 
    colour = "black",
    fill = "white",
    size = 0.4
  ) + theme
}

#' This creates a nice map theme. 
#' It is borrowed from the ggthemes package located at this repository:
#'  https://github.com/jrnold/ggthemes
#' 
#' This function was manually rewritten here to avoid the need for
#'  another package import.
#'
#' @keywords internal
theme_map <- function(base_size = 9, base_family = "") {
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          panel.background = element_blank(),
          panel.border = element_blank(),
          panel.grid = element_blank(),
          panel.spacing = unit(0, "lines"),
          plot.background = element_blank(),
          legend.justification = c(0, 0),
          legend.position = c(0, 0))
}
