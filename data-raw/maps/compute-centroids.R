#'
#' https://gis.stackexchange.com/a/265475
#'
#' find the center of mass / furthest away from any boundary
#'
#' Takes as input a spatial polygon
#' @param pol One or more polygons as input
#' @param ultimate optional Boolean, TRUE = find polygon furthest away from centroid. False = ordinary centroid

require(rgeos)
require(sp)

centroid <- function(pol, ultimate = TRUE, iterations = 5, initial_width_step = 10) {
  if (ultimate) {
    new_pol <- pol
    # for every polygon do this:
    for (i in 1:length(pol)) {
      width <- -initial_width_step
      area <- gArea(pol[i, ])
      centr <- pol[i, ]
      wasNull <- FALSE

      for (j in 1:iterations) {
        if (!wasNull){ # stop when buffer polygon was already too small
          centr_new <- gBuffer(centr, width = width)
          # if the buffer has a negative size:
          substract_width <- width / 20
          while (is.null(centr_new)) { # gradually decrease the buffer size until it has positive area
            width <- width - substract_width
            centr_new <- gBuffer(centr, width = width)
            wasNull <- TRUE
          }
          # if (!(is.null(centr_new))) {
          #   plot(centr_new, add = TRUE)
          # }
          new_area <- gArea(centr_new)
          # linear regression:
          slope <- (new_area - area) / width
          # aiming at quarter of the area for the new polygon
          width <- (area / 4 - area) / slope
          # preparing for next step:
          area <- new_area
          centr <- centr_new
        }
      }
      # take the biggest polygon in case of multiple polygons:
      d <- disaggregate(centr)
      if (length(d) > 1){
        biggest_area <- gArea(d[1, ])
        which_pol <- 1
        for (k in 2:length(d)){
          if (gArea(d[k, ]) > biggest_area){
            biggest_area <- gArea(d[k, ])
            which_pol <- k
          }
        }
        centr <- d[which_pol, ]
      }
      # add to class polygons:
      new_pol@polygons[[i]] <- remove.holes(new_pol@polygons[[i]])
      new_pol@polygons[[i]]@Polygons[[1]]@coords <- centr@polygons[[1]]@Polygons[[1]]@coords
    }

    centroids <- data.frame(gCentroid(new_pol, byid = TRUE))
  } else {
    centroids <- data.frame(gCentroid(pol, byid = TRUE))
  }

  centroids <- cbind(centroids, as.character(pol@data$GEOID))
  colnames(centroids) <- c("x", "y", "fips")

  return(centroids)
}

# Given an object of class Polygons, returns
# a similar object with no holes
remove.holes <- function(Poly) {
  # remove holes
  is.hole <- lapply(Poly@Polygons, function(P) P@hole)
  is.hole <- unlist(is.hole)
  polys <- Poly@Polygons[!is.hole]
  Poly <- Polygons(polys, ID = Poly@ID)
  # remove 'islands'
  max_area <- largest_area(Poly)
  is.sub <- lapply(Poly@Polygons, function(P) P@area<max_area)
  is.sub <- unlist(is.sub)
  polys <- Poly@Polygons[!is.sub]
  Poly <- Polygons(polys, ID = Poly@ID)
  Poly
}

largest_area <- function(Poly) {
  total_polygons <- length(Poly@Polygons)
  max_area <- 0
  for (i in 1:total_polygons) {
    max_area <- max(max_area, Poly@Polygons[[i]]@area)
  }
  max_area
}
