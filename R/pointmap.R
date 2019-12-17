##' @title Plots Points into Maps.
##' @name pointmap
##'
##' @description Plots georeferenced data (e.g. sampling points) into
##'     maps.
##'
##' @param x A lattice fomula interface, usually \code{y ~ x} where
##' x are the longitude points, and y are the latitude points.
##' @param data A data frame where the variables in the formula
##' interface (\code{x}) are contained.
##' @param xlim The x limits for the map. Usually this will be the
##' longitude limits.
##' @param ylim The y limits for the map. Usually this will be the
##' latitude limits.
##' @param square Size of the square. It must be a length one numeric
##' vector (e.g. for squares of 1x1 degrees, this should be 1). Roughly
##' speaking this can be viewed as the resolution of the map.
##' @param col.land The color of land in map. Any valid color in R is
##' accepted, see \code{\link[grDevices]{colors}}. By default it's
##' \code{"snow"}, a pale light color.
##' @param pch.points The _p_oint _ch_aracter to be plotted.
##' @param col.points The color of the points to be plotted.
##' @param cex.points The size of the points to be plotted.
##' @param database The maps database to be used to plot the
##' coastlines. Can be one of \code{"world"} (lower resolution) or
##' \code{"worldHires"} (higher resolution). Defaults to
##' \code{"world"}.
##' @param ... Other arguments passed to
##' \code{\link[lattice]{levelplot}}.
##'
##' @details
##' Made to plot sampling points in the ocean.
##'
##' @source The databases \code{"world"} and \code{"worldHires"} were
##' extracted from the databases of the same names in packages
##' \code{maps} and \code{mapdata}, respectively. These databases are
##' from the CIA World Data Bank II, which are in public domain and
##' currently (mid-2003) available at
##' \url{http://www.evl.uic.edu/pape/data/WDB}.
##'
##' @return A figure with the map(s) and the data points.
##'
##' @author Fernando Mayer \email{fernandomayer@@gmail.com}
##'
##' @seealso \code{\link[lattice]{levelplot}}, \code{\link[lattice]{xyplot}}
##'
##' @import lattice
##'
##' @export
pointmap <- function(x, data, xlim, ylim, square = 1, col.land = "snow",
                     pch.points = 20, col.points = "black",
                     cex.points = 1,
                     database = c("world", "worldHires"), ...){
    ## Choose database
    database <- match.arg(database)
    switch(database,
           world = database <- world,
           worldHires = database <- worldHires)
    ## Set X and Y ticks and labels (used in scales)
    labs <- xyticks(xlim = xlim, ylim = ylim, square = square)
    labsx <- labs$labsx; labsxc <- labs$labsxc
    labsy <- labs$labsy; labsyc <- labs$labsyc
    scales <- list(x = list(at = labsx, labels = labsxc),
                   y = list(at = labsy, labels = labsyc))
    ## Define variables
    par.settings <- list(layout.heights =
                             list(top.padding = 0, bottom.padding = 0))
    ## Panel function
    panel.fishmaps.points <- function(x, y, map.db, col.land,
                                      pch.points, col.points,
                                      cex.points, labsx, labsy, ...){
    ## Add a grid according to x and y labels
    panel.grid(h = -length(labsy), v = -length(labsx), ...)
    ## Draw the coastline
    panel.polygon(map.db$lon, map.db$lat,
                  border = "black", col = col.land, ...)
    panel.points(x, y, pch = pch.points, col = col.points, cex = cex.points, ...)
    }
    ## Main function
    xyplot(x, data = data, map.db = database, col.land = col.land,
           pch.points = pch.points, col.points = col.points,
           cex.points = cex.points,
           labsx = labsx, labsy = labsy, aspect = "iso",
           as.table = TRUE, xlim = xlim, ylim = ylim,
           xlab = "Longitude", ylab = "Latitude",
           strip = strip.custom(bg = "lightgrey"), scales = scales,
           par.settings = par.settings, panel = panel.fishmaps.points,
           ...)
}
