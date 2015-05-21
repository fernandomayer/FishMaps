##======================================================================
## Importing databases from the maps and mapdata package
## The databases "world" (from package maps) and "worlHires" (from the
## package mapdata) comes from a "[...] thinned cleaned-up version of
## the CIA World Data Bank II data [...]". The CIA WDB II raw data can
## be found in
## https://www.evl.uic.edu/pape/data/WDB/
## The raw data is freely available, and there is no specific
## license. The maps and mapdata package are distributed under GPL-2, so
## I assume I can compress these datasets and distribute here under
## GPL-3.
##======================================================================

##----------------------------------------------------------------------
## WORLD: Load package and load database
library(maps)
data(worldMapEnv)
# to get a complete map with boundaries, I will use fill = TRUE
mb <- map(database = "world", plot = FALSE, fill = TRUE)
str(mb)
# here I will extract only latitude and longitude points for the
# boundary polygons
world <- data.frame(lon = mb$x, lat = mb$y)
str(world)
plot(world, type = "l")
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## WORLDHIRES: Load package and load database
library(mapdata)
data(worldHiresMapEnv)
# to get a complete map with boundaries, I will use fill = TRUE
mbh <- map(database = "worldHires", plot = FALSE, fill = TRUE)
str(mbh)
# here I will extract only latitude and longitude points for the
# boundary polygons
worldHires <- data.frame(lon = mbh$x, lat = mbh$y)
str(worldHires)
plot(worldHires, type = "l")
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## saving and exporting datasets
save(world, worldHires, file = "R/sysdata.rda")
# checking file info
file.info("R/sysdata.rda")
file.size("R/sysdata.rda")
# check rda to verify the best compression
tools::checkRdaFiles("R/sysdata.rda")
# resave rda with a better compression if available
tools::resaveRdaFiles("R/sysdata.rda")
tools::checkRdaFiles("R/sysdata.rda")




