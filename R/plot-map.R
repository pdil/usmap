#' Conveniently plot basic US map
#'
#' @inheritParams us_map
#' @param data A data frame containing values to plot on the map. This
#'   parameter should be a data frame consisting of two columns,
#'   a fips code (2 characters for state, 5 characters for county)
#'   and the value that should be associated with that region. The
#'   columns of \code{data} \emph{must} be \code{fips} or \code{state} and
#'   the value of the `values` parameter.
#' @param values The name of the column that contains the values to be associated
#'   with a given region. The default is \code{"value"}.
#' @param theme The theme that should be used for plotting the map. The default
#'   is \code{theme_map} from \href{https://github.com/jrnold/ggthemes}{ggthemes}.
#' @param labels Whether or not to display labels on the map. Labels are not displayed
#'   by default. For now, labels only work for state maps.
#'   County labels may be added in the future.
#' @param label_color The color of the labels to display. Corresponds to the \code{color}
#'   option in the \code{\link[ggplot2]{aes}} mapping. The default is \code{"black"}.
#'   \href{http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf}{Click here}
#'   for more color options.
#' @param ... Other arguments to pass to \code{ggplot2::aes()}. These are
#'   often aesthetics, used to set an aesthetic to a fixed value, like \code{color = "red"}
#'   or \code{size = 3}. They affect the appearance of the polygons used to render
#'   the map (for example fill color, line color, line thickness, etc.). If any of
#'   \code{color}/\code{colour}, \code{fill}, or \code{size} are not specified they
#'   are set to their default values of \code{color="black"}, \code{fill="white"},
#'   and \code{size=0.4}.
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
#' # Color maps with data
#' plot_usmap(data = statepop, values = "pop_2015")
#'
#' # Include labels on map (e.g. state abbreviations)
#' plot_usmap(data = statepop, values = "pop_2015", labels = TRUE)
#' # Choose color for labels
#' plot_usmap(data = statepop, values = "pop_2015", labels = TRUE, label_color = "white")
#'
#' @importFrom rlang .data
#' @export
plot_usmap <- function(regions = c("states", "state", "counties", "county"),
                       include = c(),
                       exclude = c(),
                       data = data.frame(),
                       values = "values",
                       theme = theme_map(),
                       labels = FALSE,
                       label_color = "black",
                       ...) {

  # check for ggplot2
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("`ggplot2` must be installed to use `plot_usmap`.
         Use: install.packages(\"ggplot2\") and try again.")
  }

  .data <- ggplot2::.data

  # parse parameters
  regions_ <- match.arg(regions)
  geom_args <- list(...)

  # set geom_polygon defaults
  if (is.null(geom_args[["colour"]]) && is.null(geom_args[["color"]])) {
    geom_args[["color"]] <- "black"
  }

  if (is.null(geom_args[["linewidth"]])) {
    geom_args[["linewidth"]] <- 0.4
  }

  # only use "fill" setting if data is not included
  if (is.null(geom_args[["fill"]]) && nrow(data) == 0) {
    geom_args[["fill"]] <- "white"
  } else if (!is.null(geom_args[["fill"]]) && nrow(data) != 0) {
    warning("`fill` setting is ignored when `data` is provided. Use `fill` to
            color regions with solid color when no data is being displayed.")
  }

  # create polygon layer
  if (nrow(data) == 0) {
    map_df <- usmap::us_map(regions = regions_, include = include, exclude = exclude)
    geom_args[["mapping"]] <- ggplot2::aes(x = .data$x, y = .data$y, group = .data$group)
  } else {
    map_df <- usmap::map_with_data(data, values = values, include = include, exclude = exclude)
    geom_args[["mapping"]] <- ggplot2::aes(
      x = .data$x,
      y = .data$y,
      group = .data$group,
      fill = .data[[values]]
    )
  }

  polygon_layer <- do.call(ggplot2::geom_polygon, geom_args)

  # create label layer
  if (labels) {
    if (regions_ == "state") regions__ <- "states"
    else if (regions_ == "county") regions__ <- "counties"
    else regions__ <- regions_

    centroid_labels <- usmapdata::centroid_labels(regions__)

    if (length(include) > 0) {
      centroid_labels <- centroid_labels[
        centroid_labels$full %in% include |
          centroid_labels$abbr %in% include |
          centroid_labels$fips %in% include, ]
    }

    if (length(exclude) > 0) {
      centroid_labels <- centroid_labels[!(
        centroid_labels$full %in% exclude |
          centroid_labels$abbr %in% exclude |
          centroid_labels$fips %in% exclude |
          substr(centroid_labels$fips, 1, 2) %in% exclude), ]
    }

    if (regions_ == "county" || regions_ == "counties") {
      label_layer <- ggplot2::geom_text(
        data = centroid_labels,
        ggplot2::aes(x = .data$x, y = .data$y, label = sub(" County", "", .data$county)),
        color = label_color)
    } else {
      label_layer <- ggplot2::geom_text(
        data = centroid_labels,
        ggplot2::aes(x = .data$x, y = .data$y, label = .data$abbr), color = label_color)
    }
  } else {
    label_layer <- ggplot2::geom_blank()
  }

  # construct final plot
  ggplot2::ggplot(data = map_df) + polygon_layer + label_layer + ggplot2::coord_equal() + theme
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
  element_blank <- ggplot2::element_blank()
 `%+replace%` <- ggplot2::`%+replace%` # nolint: object_name_linter
  unit <- ggplot2::unit

  ggplot2::theme_bw(base_size = base_size, base_family = base_family) %+replace%
    ggplot2::theme(axis.line = element_blank,
                   axis.text = element_blank,
                   axis.ticks = element_blank,
                   axis.title = element_blank,
                   panel.background = element_blank,
                   panel.border = element_blank,
                   panel.grid = element_blank,
                   panel.spacing = unit(0, "lines"),
                   plot.background = element_blank,
                   legend.justification = c(0, 0),
                   legend.position = c(0, 0))
}
