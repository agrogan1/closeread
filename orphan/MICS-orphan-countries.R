# shapefile of countries for MICS-orphans

library(readr)

library(rnaturalearth)

library(countrycode)

library(dplyr)

library(ggplot2)

library(sf)

MICS_orphan_countries <- read_csv("orphan/MICS-orphan-countries.csv")

MICS_orphan_countries$country_iso <- 
  countrycode(MICS_orphan_countries$country, 
              'country.name', 
              'iso3c')

mapdata <- ne_countries(scale = "medium", # medium scale
                        returnclass = "sf") # as sf object

MICS <- mapdata %>% 
  filter(iso_a3 %in% MICS_orphan_countries$country_iso)

ggplot(MICS) + geom_sf()

st_write(MICS, 
         "orphan/MICS-orphan-countries/MICS-orphan-countries.shp")






