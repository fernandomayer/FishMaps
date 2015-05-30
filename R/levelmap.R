##' @title Plots fishery data into maps
##' @name levelmap
##'
##' @description Plots georeferenced fishery data into maps. This
##' desciption must be expanded.
##'
##' @param x fomula interface
##' @param data data frame
##' @param xlim x limits
##' @param ylim y limits
##' @param breaks class breaks
##' @param square size of square
##' @param key.space place for the legend
##' @param database world or worldHires
##'
##' @return A map with data
##'
##' @author Fernando Mayer
##'
##' @import lattice
##'
##' @export
levelmap <- function(x, data, xlim, ylim, breaks,
                     square = 1, key.space = "right",
                     database = c("world", "worldHires")){
    ## choose database
    database <- match.arg(database)
    switch(database,
           world = database <- world,
           worldHires = database <- worldHires)
    ## set X and Y ticks and labels
    labs <- xyticks(xlim = xlim, ylim = ylim, square = square)
    labsx <- labs$labsx; labsxc <- labs$labsxc
    labsy <- labs$labsy; labsyc <- labs$labsyc
    ## define variables
    # middle of a square - to be used inside the panel function
    msq <- square/2
    col.reg <- grey.colors(length(breaks) - 1,
                           start = 0.7, end = 0.1)
    ## main function
    levelplot(x, data = data, map.db = database, msq = msq,
              col.reg = col.reg, breaks = breaks,
              labsx = labsx, labsy = labsy,
              aspect = "iso",
              as.table = TRUE, xlim = xlim, ylim = ylim,
              xlab = "Longitude", ylab = "Latitude",
              scales = list(
                  x = list(at = labsx, labels = labsxc),
                  y = list(at = labsy, labels = labsyc)),
              strip = strip.custom(bg = "lightgrey"),
              at = breaks, colorkey = list(space = key.space),
              col.regions = col.reg,
              par.settings = list(layout.heights = list(top.padding = 0,
                                      bottom.padding = 0)),
              subscripts = TRUE,
              panel = panel.fishmaps)
 }
