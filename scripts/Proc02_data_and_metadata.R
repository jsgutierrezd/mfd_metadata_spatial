
#===============================================================
# Proc02 Joining data and metadata from GitHub
# Sebastian Gutierrez - Aarhus University
# May 22 2023
# Metadata from https://github.com/cmc-aau/mfd_metadata 
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
data <- vect("datasets/test_mapping_noduplicates.shp") %>% 
  as.data.frame
names(data)


# 4) Load metadata --------------------------------------------------------

meta <- read_excel("datasets/2023-05-09_mfd_db.xlsx")
names(meta)
names(meta)[2] <- "fieldsampl"


# 5) Join the data and the metadata by sampleID ---------------------------
data <- dplyr::left_join(data,meta,by="fieldsampl")
data <- vect(data,geom=c("longitude.x", "latitude.x"),crs="epsg:4326")
plot(data)

# 6) Export result as a shapefile -----------------------------------------
writeVector(data,
            "datasets/test_mapping_noduplicates_metadata.shp",
            overwrite=T)

# END ---------------------------------------------------------------------

