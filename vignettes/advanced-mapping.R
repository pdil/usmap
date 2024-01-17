## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("states", labels = TRUE)

## ----fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("counties", include = c("MA", "CT", "RI"), labels = TRUE)

## ----fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("counties",
                  include = c("MA", "CT", "RI"),
                  labels = TRUE, label_color = "blue")

## ----fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("counties",
                  include = c("MA", "CT", "RI"),
                  labels = TRUE, label_color = "blue",
                  fill = "yellow", alpha = 0.25, color = "orange", linewidth = 2)

## ----warning=FALSE------------------------------------------------------------
usmap::usmap_crs()

## ----fig.align='center', fig.width=8, fig.height=5, message=FALSE, warning=FALSE----
library(usmap)
library(ggplot2)

eq_transformed <- usmap_transform(earthquakes)

plot_usmap() +
  geom_sf(data = eq_transformed, aes(size = mag),
          color = "red", alpha = 0.25) +
  labs(title = "US Earthquakes",
       subtitle = "Source: USGS, Jan 1 to Jun 30 2019",
       size = "Magnitude") +
  theme(legend.position = "right")

## ----fig.align='center', fig.height=5, fig.width=8, message=FALSE, warning=FALSE----
library(usmap)
library(ggplot2)

cities_t <- usmap_transform(citypop)

plot_usmap(fill = "yellow", alpha = 0.25) +
  geom_sf(data = cities_t,
          aes(size = city_pop),
          color = "purple", alpha = 0.5) +
  ggrepel::geom_label_repel(data = cities_t,
                            aes(label = most_populous_city, geometry = geometry),
                            size = 3, alpha = 0.8,
                            label.r = unit(0.5, "lines"), label.size = 0.5,
                            segment.color = "red", segment.size = 1,
                            stat = "sf_coordinates", seed = 1002,
                            max.overlaps = 20) +
  scale_size_continuous(range = c(1, 16),
                        label = scales::comma) +
  labs(title = "Most Populous City in Each US State",
       subtitle = "Source: US Census 2010",
       size = "City Population") +
  theme(legend.position = "right")

## ----fig.align='center', fig.height=5, fig.width=8, message=FALSE, warning=FALSE----
library(usmap)
library(ggplot2)

rivers_t <- usmap_transform(usrivers)

plot_usmap("counties", color = "gray80") + 
  geom_sf(data = rivers_t, aes(linewidth = Shape_Length, color = SYSTEM, fill = SYSTEM)) + 
  scale_linewidth_continuous(range = c(0.3, 1.8), guide = "none") +
  scale_color_discrete(guide = "none") +
  labs(title = "Major Rivers in the United States",
       subtitle = "Source: ESRI 2010",
       fill = "River System") +
  theme(legend.position = "right")

