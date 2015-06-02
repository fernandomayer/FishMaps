##' @title Plots Fishery Data Into Maps.
##' @name levelmap
##'
##' @description Plots georeferenced fishery data (e.g. catch, effort
##' and CPUE) into maps. This function uses the lattice::levelplot to
##' draw a _level_plot _map_ based on latitude and longitude, with a
##' resolution defined by the size of lat/long squares (e.g. 1x1 or 5x5
##' degrees). Coastlines are drawn to display the map, based on two
##' databases: maps::world (lower resolution) and mapdata::worldHires
##' (higher resolution), although none of these packages are required
##' since the databases are buit-in FishMaps.
##'
##' @param x A lattice fomula interface, usually \code{z ~ x + y} where
##' z is the response variable to be plotted, x are the longitude
##' points, and y are the latitude points. It is really important that
##' the longitude and latitude points are centered in the middle of the
##' squares. See Details. Alternativelly the formula generally is of the
##' form \code{z ~ x + y | c1 + c2} where \code{c1} and \code{c2} are
##' conditioning variables, i.e. the plots will be generated for each
##' combination of \code{c1} and \code{c2} (\code{c1} and \code{c2}
##' could be, for example, year and quarter). See more details about
##' lattice formula interface at \code{\link[lattice]{levelplot}}.
##' @param data A data frame where the variables in the formula
##' interface (\code{x}) are contained.
##' @param xlim The x limits for the map. Usually this will be the
##' longitude limits.
##' @param ylim The y limits for the map. Usually this will be the
##' latitude limits.
##' @param breaks A numeric vector of cut points, where the data in
##' \code{z} should be cutted to form the classes.
##' @param square Size of the square. It must be a length one numeric
##' vector (e.g. for squares of 1x1 degrees, this should be 1). Roughly
##' speaking this can be viewed as the resolution of the map.
##' @param key.space The location or the colorkey (legend) of the
##' map. Can be one of \code{"left"}, \code{"right"}, \code{"top"} and
##' \code{"bottom"}. Defaults to \code{"right"}.
##' @param database The maps database to be used to plot the
##' coastlines. Can be one of \code{"world"} (lower resolution) or
##' \code{"worldHires"} (higher resolution). Defaults to
##' \code{"world"}.
##' @param ... Other arguments passed to
##' \code{\link[lattice]{levelplot}}.
##'
##' @return A figure with the map(s) and the data plotted in levels.
##'
##' @author Fernando Mayer \email{fernandomayer@@gmail.com}
##'
##' @seealso \code{\link[lattice]{levelplot}}, \code{\link[lattice]{xyplot}}
##'
##' @import lattice
##'
##' @export
levelmap <- function(x, data, xlim, ylim, breaks,
                     square = 1, key.space = "right",
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
    # middle of a square: to be used inside the panel.fishmaps function
    msq <- square/2
    # color region: the default is grey (this could be more flexible)
    col.reg <- grey.colors(length(breaks) - 1,
                           start = 0.7, end = 0.1)
    # parameter settings for lattice graphics. layout heights equals
    # zero removes the spaces between panels
    par.settings <- list(layout.heights =
                             list(top.padding = 0, bottom.padding = 0))
    ## Main function
    levelplot(x, data = data, map.db = database, msq = msq,
              col.reg = col.reg, breaks = breaks,
              labsx = labsx, labsy = labsy,
              aspect = "iso", as.table = TRUE,
              xlim = xlim, ylim = ylim,
              xlab = "Longitude", ylab = "Latitude",
              strip = strip.custom(bg = "lightgrey"),
              at = breaks, colorkey = list(space = key.space),
              scales = scales, col.regions = col.reg,
              par.settings = par.settings,
              subscripts = TRUE,
              panel = panel.fishmaps, ...)
}
