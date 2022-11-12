## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("states", labels = TRUE)

## ---- fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("counties", include = c("MA", "CT", "RI"), labels = TRUE)

## ---- fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("counties",
                  include = c("MA", "CT", "RI"),
                  labels = TRUE, label_color = "blue")

## ---- fig.align='center', fig.width=7, fig.height=5, message=FALSE, warning=FALSE----
usmap::plot_usmap("counties",
                  include = c("MA", "CT", "RI"),
                  labels = TRUE, label_color = "blue",
                  fill = "yellow", alpha = 0.25, color = "orange", linewidth = 2)

## ---- warning=FALSE-----------------------------------------------------------
usmap::usmap_crs()@projargs

## ---- fig.align='center', fig.width=8, fig.height=5, message=FALSE, warning=FALSE----
library(usmap)
library(ggplot2)

eq_transformed <- usmap_transform(earthquakes)

plot_usmap() +
  geom_point(data = eq_transformed, aes(x = x, y = y, size = mag),
             color = "red", alpha = 0.25) +
  labs(title = "US Earthquakes",
       subtitle = "Source: USGS, Jan 1 to Jun 30 2019",
       size = "Magnitude") +
  theme(legend.position = "right")

## ---- fig.align='center', fig.width=8, fig.height=5, message=FALSE, warning=FALSE----
library(usmap)
library(ggplot2)

cities_t <- usmap_transform(citypop)

plot_usmap(fill = "yellow", alpha = 0.25) +
  ggrepel::geom_label_repel(data = cities_t,
             aes(x = x, y = y, label = most_populous_city),
             size = 3, alpha = 0.8,
             label.r = unit(0.5, "lines"), label.size = 0.5,
             segment.color = "red", segment.size = 1,
             seed = 1002) +
  geom_point(data = cities_t,
             aes(x = x, y = y, size = city_pop),
             color = "purple", alpha = 0.5) +
  scale_size_continuous(range = c(1, 16),
                        label = scales::comma) +
  labs(title = "Most Populous City in Each US State",
       subtitle = "Source: US Census 2010",
       size = "City Population") +
  theme(legend.position = "right")

