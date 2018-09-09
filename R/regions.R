
#' New England census division
#'
#' @description
#' US Census Bureau regional division containing Connecticut, Maine,
#' Massachusetts, New Hampshire, Rhode Island, and Vermont.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .new_england, labels = TRUE)
#' @export
.new_england <- c("CT", "MA", "ME", "NH", "RI", "VT")
#' Mid-Atlantic census division
#'
#' @description
#' US Census Bureau regional division containing New Jersey, New York,
#' and Pennsylvania.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .mid_atlantic, labels = TRUE)
#' @export
.mid_atlantic <- c("NJ", "NY", "PA")

#' East North Central census division
#'
#' @description
#' US Census Bureau regional division containing Illinois, Indiana, Michigan,
#' Ohio, and Wisconsin.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .east_north_central, labels = TRUE)
#' @export
.east_north_central <- c("IL", "IN", "MI", "OH", "WI")
#' West North Central census division
#'
#' @description
#' US Census Bureau regional division containing Iowa, Kansas, Minnesota,
#' Missouri, Nebraska, North Dakota, and South Dakota.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .west_north_central, labels = TRUE)
#' @export
.west_north_central <- c("IA", "KS", "MN", "MO", "NE", "ND", "SD")

#' South Atlantic census division
#'
#' @description
#' US Census Bureau regional division containing Delaware, Florida, Georgia,
#' Maryland, North Carolina, South Carolina, Virginia,
#' District of Columbia, and West Virginia.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .south_atlantic, labels = TRUE)
#' @export
.south_atlantic <- c("DC", "DE", "FL", "GA", "MD", "NC", "SC", "VA", "WV")
#' East South Central census division
#'
#' @description
#' US Census Bureau regional division containing Alabama, Kentucky,
#' Mississippi, and Tennessee.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .east_south_central, labels = TRUE)
#' @export
.east_south_central <- c("AL", "KY", "MS", "TN")
#' West South Central census division
#'
#' @description
#' US Census Bureau regional division containing Arkansas, Louisiana, Oklahoma,
#' and Texas.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .west_south_central, labels = TRUE)
#' @export
.west_south_central <- c("AR", "LA", "OK", "TX")

#' Mountain census division
#'
#' @description
#' US Census Bureau regional division containing Arizona, Colorado, Idaho,
#' Montana, Nevada, New Mexico, Utah, and Wyoming.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .mountain, labels = TRUE)
#' @export
.mountain <- c("AZ", "CO", "ID", "MT", "NV", "NM", "UT", "WY")
#' Pacific census division
#'
#' @description
#' US Census Bureau regional division containing Alaska, California, Hawaii,
#' Oregon, and Washington.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .pacific, labels = TRUE)
#' @export
.pacific <- c("AK", "CA", "HI", "OR", "WA")

#' Northeast census region
#'
#' @description
#' US Census Bureau region containing the New England and Mid-Atlantic
#' divisions.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .northeast_region, labels = TRUE)
#' @export
.northeast_region <- c(.new_england, .mid_atlantic)
#' North-Central census region
#'
#' @description
#' Former US Census Bureau region containing the East North Central and West
#' North Central divisions. This region has been designated as "Midwest"
#' since June 1984.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .north_central_region, labels = TRUE)
#' @export
.north_central_region <- c(.east_north_central, .west_north_central)
#' Midwest census region
#'
#' @description
#' US Census Bureau region containing the East North Central and West
#' North Central divisions. This region was designated as "North Central Region"
#' prior to June 1984.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .midwest_region, labels = TRUE)
#' @export
.midwest_region <- .north_central_region
#' South census region
#'
#' @description
#' US Census Bureau region containing the South Atlantic, East South Central,
#' and West South Central divisions.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .midwest_region, labels = TRUE)
#' @export
.south_region <- c(.south_atlantic, .east_south_central, .west_south_central)
#' West census region
#'
#' @description
#' US Census Bureau region containing the Mountain and Pacific divisions.
#'
#' @details
#' See
#' \url{https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf}
#'
#' @examples
#' plot_usmap(include = .midwest_region, labels = TRUE)
#' @export
.west_region <- c(.mountain, .pacific)
