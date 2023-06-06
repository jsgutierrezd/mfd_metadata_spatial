
#===============================================================
# Proc03 Checking land use from metadata and from spatial layers
# Sebastian Gutierrez - Aarhus University
# May 22 2023
# Metadata from https://github.com/cmc-aau/mfd_metadata
# Land use from basemap 2011-2021
#===============================================================

rm(list = ls())
Sys.setenv(language="EN")


# 1) Set working directory ------------------------------------------------

setwd("~/AARHUS_PhD/DSMactivities/2_Biodiversity/mfd_metadata_spatial")


# 2) Load libraries -------------------------------------------------------
pckg <- c('readxl',
          'magrittr',
          'terra',
          'readr'
)

usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}
lapply(pckg,usePackage)


# 3) Load point data ------------------------------------------------------
data <- vect("datasets/test_mapping_noduplicates_metadata.shp")
names(data)


# 4) Load land use layer -------------------------------------------------

# Layer from 2021
lu21 <- rast("O:/Tech_AGRO/Jord/Sebastian/BaseMapDenmark/Basemap04_2021/lu_agg_2021.tif") %>% 
  as.factor
# levels(lu21)

# 5) Data and land use information ----------------------------------------

data <- terra::extract(lu21,data,bind=T)
data
# head(data)

# 6) Shapefile ------------------------------------------------------------
data %>% as.data.frame() %>% write_csv("datasets/test_mapping_noduplicates_EPSG25832METADBasemap04.csv")
# writeVector(data,
#             "datasets/test_mapping_noduplicates_EPSG25832METADBasemap04.shp",
#             overwrite=T)

# END ---------------------------------------------------------------------


