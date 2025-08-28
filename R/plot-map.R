#' Conveniently plot basic US map
#'
#' @inheritParams us_map
#' @param data A data frame containing values to plot on the map. This
#'   parameter should be a data frame consisting of two columns,
#'   a FIPS code (2 characters for state, 5 characters for county)
#'   and the value that should be associated with that region. The
#'   columns of `data` _must_ be `fips` or `state` and
#'   the value of the `values` parameter.
#' @param values The name of the column that contains the values to be associated
#'   with a given region. The default is `"value"`.
#' @param theme The theme that should be used for plotting the map. The default
#'   is `theme_map` from [ggthemes](https://github.com/jrnold/ggthemes).
#' @param labels Whether or not to display labels on the map. Labels are not displayed
#'   by default.
#' @param label_color The color of the labels to display. Corresponds to the `color`
#'   option in the [ggplot2::aes()] mapping. The default is `"black"`.
#'   [Click here](https://usmap.dev/docs/Rcolor.pdf)
#'   for more color options.
#' @param ... Other arguments to pass to [ggplot2::aes()]. These are
#'   often aesthetics, used to set an aesthetic to a fixed value, like `color = "red"`
#'   or `linewidth = 3`. They affect the appearance of the polygons used to render
#'   the map (for example fill color, line color, line thickness, etc.). If any of
#'   `color`/`colour`, `fill`, or `linewidth` are not specified they
#'   are set to their default values of `color="black"`, `fill="white"`,
#'   and `linewidth=0.4`.
#'
#' @return A [ggplot2::ggplot] object that contains a basic
#'   US map with the described parameters. Since the result is a `ggplot`
#'   object, it can be extended with more [ggplot2::Geom] layers, scales, labels,
#'   themes, etc.
#'
#' @details
#' By default, Puerto Rico is not plotted unless it is specifically included
#' via `include = c("PR")` etc. The default behavior can be changed by setting
#' the environment variable `USMAP_DEFAULT_EXCLUDE_PR = FALSE`.
#'
#' @seealso [usmap], [ggplot2::theme()]
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
#' plot_usmap(data = statepop, values = "pop_2022")
#'
#' # Include labels on map (e.g. state abbreviations)
#' plot_usmap(data = statepop, values = "pop_2022", labels = TRUE)
#' # Choose color for labels
#' plot_usmap(data = statepop, values = "pop_2022", labels = TRUE, label_color = "white")
#'
#' @importFrom rlang .data
#' @export
plot_usmap <- function(
  regions = c("states", "state", "counties", "county"),
  include = c(),
  exclude = c(),
  data = data.frame(),
  values = "values",
  theme = theme_map(),
  labels = FALSE,
  label_color = "black",
  data_year = NULL,
  ...
) {
  # check for ggplot2
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("`ggplot2` must be installed to use `plot_usmap`.
         Use: install.packages(\"ggplot2\") and try again.")
  }

  .data <- ggplot2::.data

  # exclude PR by default if env variable is not `FALSE`
  if (Sys.getenv("USMAP_DEFAULT_EXCLUDE_PR", unset = TRUE) == TRUE &&
      !("PR" %in% include || "72" %in% include)) {
    exclude <- unique(c(exclude, "PR", "72"))
  }

  # parse parameters
  regions <- match.arg(regions)
  geom_args <- list(...)

  # set geom_polygon defaults
  if (is.null(geom_args[["colour"]]) && is.null(geom_args[["color"]])) {
    geom_args[["color"]] <- "black"
  }

  if (is.null(geom_args[["linewidth"]])) {
    geom_args[["linewidth"]] <- 0.4
  }

  # set default "fill" if data is not included
  if (is.null(geom_args[["fill"]]) && nrow(data) == 0) {
    geom_args[["fill"]] <- "white"
  }

  # create polygon layer
  if (nrow(data) == 0) {
    map_df <- usmap::us_map(regions = regions, include = include, exclude = exclude, data_year = data_year)
    geom_args[["mapping"]] <- ggplot2::aes()
  } else {
    map_df <- usmap::map_with_data(data, values = values, include = include, exclude = exclude, data_year = data_year)

    if (!is.null(map_df$county)) regions <- "counties"
    geom_args[["mapping"]] <- ggplot2::aes(fill = .data[[values]])
  }

  polygon_layer <- do.call(ggplot2::geom_sf, geom_args)

  # create label layer
  if (labels) {
    if (regions == "state") regions <- "states"
    else if (regions == "county") regions <- "counties"

    centroid_labels <- usmapdata::centroid_labels(regions, data_year = data_year)

    # remove excluded items that are in `include`
    exclude <- setdiff(exclude, include)

    # remove excludes
    if (length(exclude) > 0) {
      centroid_labels <- centroid_labels[!(
        centroid_labels$full %in% exclude |
          centroid_labels$abbr %in% exclude |
          centroid_labels$fips %in% exclude |
          substr(centroid_labels$fips, 1, 2) %in% exclude
      ), ]
    }

    # remove non-includes
    if (length(include) > 0) {
      centroid_labels <- centroid_labels[
        centroid_labels$full %in% include |
          centroid_labels$abbr %in% include |
          centroid_labels$fips %in% include,
      ]
    }

    if (regions == "county" || regions == "counties") {
      label_layer <- ggplot2::geom_sf_text(
        data = centroid_labels,
        ggplot2::aes(label = sub(" County", "", .data$county)),
        color = label_color
      )
    } else {
      label_layer <- ggplot2::geom_sf_text(
        data = centroid_labels,
        ggplot2::aes(label = .data$abbr), color = label_color
      )
    }
  } else {
    label_layer <- ggplot2::geom_blank()
  }

  # construct final plot
  ggplot2::ggplot(data = map_df) + polygon_layer + label_layer + theme
}

#' Convenient theme map
#'
#' @description
#' This creates a nice map theme for use in [plot_usmap()].
#' It originated from the `ggthemes` package located at this repository:
#'   \url{https://github.com/jrnold/ggthemes}.
#'
#' This function was manually rewritten here to avoid the need for
#'  another package import.
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
                   legend.position = "inside",
                   legend.justification.inside = c(0, 0))
}
