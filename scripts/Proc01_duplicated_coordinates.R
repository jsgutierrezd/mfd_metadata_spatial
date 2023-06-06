
#===============================================================
# Proc01 Checking for duplicated coordinates
# Sebastian Gutierrez - Aarhus University
# May 22 2023
#===============================================================
rm(list = ls())
Sys.setenv(language="EN")


# 1) Set working directory ------------------------------------------------

setwd("~/AARHUS_PhD/DSMactivities/2_Biodiversity/mfd_metadata_spatial")


# 2) Load libraries -------------------------------------------------------

pckg <- c('sp',       # classes and methods for spatial data
          'magrittr', # operators which promote semantics
          'rgdal'     # bindings for the 'Geospatial' Data Abstraction Library
)   

usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}

lapply(pckg,usePackage)


# 3) Load point data ------------------------------------------------------
data <- readOGR("datasets/test_mapping.shp")
head(data)


# 4) Detect and remove duplicates -----------------------------------------

data <- remove.duplicates(data, 
                          zero = 0.0, 
                          remove.second = TRUE, 
                          memcmp = TRUE)


# 5) Export as a shapefile ------------------------------------------------
writeOGR(data, "datasets",
          "test_mapping_noduplicates",
         driver="ESRI Shapefile")

# 6) Export as a csv file -------------------------------------------------
write.csv(data@data,
          "datasets/test_mapping_noduplicates.csv",
          row.names = F)


# END ---------------------------------------------------------------------
