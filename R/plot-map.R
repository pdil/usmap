#' Conveniently plot basic US map
#'
#' @inheritParams us_map
#' @param theme The theme that should be used for plotting the map. The default
#'   is \code{\link[ggthemes]{theme_map}}.
#' @param lines The line color to be used in the map. Corresponds to the
#'   \code{colour} option in the \code{\link[ggplot2]{aes}} mapping. The default
#'   is \code{"black"}. \href[http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf]{Click here}
#'   for more color options.
#'
#' @return A \code{\link[ggplot2]{ggplot}} object that contains a basic
#'   US map with the described parameters. Since the result is a \code{ggplot}
#'   object, it can be extended with more \code{geom} layers, scales, labels,
#'   themes, etc.
#'
#' @seealso \code{\link{usmap}}, \code{\link[ggplot2]{theme}}
#'
#' @examples
#' plot_usmap()
#' plot_usmap(regions = "states")
#' plot_usmap(regions = "counties")
#' plot_usmap(regions = "state")
#' plot_usmap(regions = "county")
#'
#' # Output is ggplot object so it can be extended
#' # with any number of ggplot layers
#' library(ggplot2)
#' plot_usmap(include = c("CA", "NV", "ID", "OR", "WA")) +
#'   labs(title = "Western States")
#'
#' @export
plot_usmap <- function(regions = c("states", "state", "counties", "county"),
                       include = c(),
                       theme = theme_map(),
                       lines = "black") {

  regions_ <- match.arg(regions)
  map_df <- us_map(regions = regions_, include = include)

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Please install `ggplot2`. Use: install.packages(\"ggplot2\")")
  }

  ggplot2::ggplot(data = map_df) +
    ggplot2::geom_polygon(
      ggplot2::aes(x = map_df$long, y = map_df$lat, group = map_df$group),
      colour = lines, fill = "white", size = 0.4
    ) +
    ggplot2::coord_equal() +
    theme
}

#' This creates a nice map theme for use in plot_usmap.
#' It is borrowed from the ggthemes package located at this repository:
#'   https://github.com/jrnold/ggthemes
#'
#' This function was manually rewritten here to avoid the need for
#'  another package import.
#'
#' All theme functions (i.e. theme_bw, theme, element_blank, %+replace%)
#'  come from ggplot2.
#'
#' @keywords internal
theme_map <- function(base_size = 9, base_family = "") {
  elementBlank = ggplot2::element_blank()
 `%+replace%` <- ggplot2::`%+replace%`
  unit <- ggplot2::unit

  ggplot2::theme_bw(base_size = base_size, base_family = base_family) %+replace%
    ggplot2::theme(axis.line = elementBlank,
                   axis.text = elementBlank,
                   axis.ticks = elementBlank,
                   axis.title = elementBlank,
                   panel.background = elementBlank,
                   panel.border = elementBlank,
                   panel.grid = elementBlank,
                   panel.spacing = unit(0, "lines"),
                   plot.background = elementBlank,
                   legend.justification = c(0, 0),
                   legend.position = c(0, 0))
}
