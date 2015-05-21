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
##' @param jump gap for lat and lon
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
levelmap <- function(x, data, xlim, ylim, breaks, jump,
                     key.space = "right",
                     database = c("world", "worldHires")){
    database <- match.arg(database)
    switch(database,
           world = database <- world,
           worldHires = database <- worldHires)
    ## library(maps)
    ## mm <- maps::map(database, plot = FALSE, fill = TRUE)
    ## Define os ranges do mapa, e os labels para colocar nos graficos
    ## Isso precisa melhorar e ficar mais generico
    labsx <- seq(min(xlim), max(xlim), jump)
    labsxc <- as.character(labsx)
    labsxc[seq(2, length(labsxc), 2)] <- ""
    labsy <- seq(min(ylim), max(ylim), jump)
    labsyc <- as.character(labsy)
    labsyc[seq(2, length(labsyc), 2)] <- ""
    ## Função para plotar valores zero e NA
    panel.zero.points <- function(x, y, z, subscripts, ...){
        x <- as.numeric(x)[subscripts]
        y <- as.numeric(y)[subscripts]
        z <- as.numeric(z)[subscripts]
        for(i in seq_along(z)){
            if(z[i] == 0L){
                grid::grid.points(x = x[i], y = y[i], pch = "+",
                            size = unit(1, "native"))
            } else if(is.na(z[i])){
                grid::grid.points(x = x[i], y = y[i], pch = "-",
                            size = unit(1, "native"))
            } else{
                grid::grid.points(x = x[i], y = y[i], pch = "")
            }
        }
    }
    levelplot(x, data, mm = database, aspect = "iso",
              as.table = TRUE, xlim = xlim, ylim = ylim,
              xlab = "Longitude",
              ylab = "Latitude",
              scales = list(x = list(at = labsx, labels = labsxc),
                  y = list(at = labsy, labels = labsyc)),
              strip = strip.custom(bg = "lightgrey"),
              at = breaks, colorkey = list(space = key.space),
              col.regions = grey.colors(length(breaks)-1,
                  start = 0.7, end = 0.1),
              par.settings = list(layout.heights = list(top.padding = 0,
                                      bottom.padding = 0)),
              panel = function(x, y, z, mm, ...){
                  panel.levelplot(x, y, z, ...)
                  panel.grid(h = -length(labsx), v = -length(labsy), ...)
                  panel.polygon(mm$lon, mm$lat, border = "black", col =
                                    "snow")
                  panel.zero.points(x, y, z, ...)
              })
}
