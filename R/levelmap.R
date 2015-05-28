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
##' @importFrom latticeExtra as.layer
##'
##' @export
levelmap <- function(x, data, xlim, ylim, breaks,
                     square = 1, key.space = "right",
                     database = c("world", "worldHires")){
    ## get formula
    terms.form <- all.vars(x)
    resp <- terms.form[1]
    lon <- terms.form[2]
    lat <- terms.form[3]
    pipe <- terms.form[4:length(terms.form)]
    pipe <- ifelse(length(pipe) == 1,
               pipe,
               paste(pipe, collapse = " + "))
    resp.vec <- data[, resp]
    if(any(resp.vec == 0)){
        da.zero <- subset(data, get(resp) == 0)
        da.nzero <- subset(data, get(resp) != 0)
    } else{
        da <- data
    }
    ## choose database
    database <- match.arg(database)
    switch(database,
           world = database <- world,
           worldHires = database <- worldHires)
    ## set X and Y ticks and labels
    labs <- xyticks(xlim = xlim, ylim = ylim, square = square)
    labsx <- labs$labsx; labsxc <- labs$labsxc
    labsy <- labs$labsy; labsyc <- labs$labsyc
    ## main function
    if(any(resp.vec == 0)){
        lev <- levelplot(x, data = da.nzero, map.db = database, aspect = "iso",
                         as.table = TRUE, xlim = xlim, ylim = ylim,
                         xlab = "Longitude", ylab = "Latitude",
                         scales = list(
                             x = list(at = labsx, labels = labsxc),
                             y = list(at = labsy, labels = labsyc)),
                         strip = strip.custom(bg = "lightgrey"),
                         at = breaks, colorkey = list(space = key.space),
                         col.regions = grey.colors(length(breaks) - 1,
                             start = 0.7, end = 0.1),
                         par.settings = list(layout.heights = list(top.padding = 0,
                                                 bottom.padding = 0)),
                         panel = function(x, y, z, map.db, ...){
                             panel.levelplot(x, y, z, ...)
                             panel.grid(h = -length(labsx), v = -length(labsy), ...)
                             panel.polygon(map.db$lon, map.db$lat,
                                           border = "black", col = "snow", ...)
                                        #panel.zero.points(x, y, z, ...)
                         })
        xy.form <- as.formula(paste("lat ~ lon", pipe, sep = " | "))
        lev <- lev + as.layer(
            xyplot(xy.form, pch = 4, col = "black", data = da.zero))
    } else{
        lev <- levelplot(x, data = da, map.db = database, aspect = "iso",
                         as.table = TRUE, xlim = xlim, ylim = ylim,
                         xlab = "Longitude", ylab = "Latitude",
                         scales = list(
                             x = list(at = labsx, labels = labsxc),
                             y = list(at = labsy, labels = labsyc)),
                         strip = strip.custom(bg = "lightgrey"),
                         at = breaks, colorkey = list(space = key.space),
                         col.regions = grey.colors(length(breaks) - 1,
                             start = 0.7, end = 0.1),
                         par.settings = list(layout.heights = list(top.padding = 0,
                                                 bottom.padding = 0)),
                         panel = function(x, y, z, map.db, ...){
                             panel.levelplot(x, y, z, ...)
                             panel.grid(h = -length(labsx), v = -length(labsy), ...)
                             panel.polygon(map.db$lon, map.db$lat,
                                           border = "black", col = "snow", ...)
                                        #panel.zero.points(x, y, z, ...)
                         })
    }
    return(lev)
}


## x <- as.numeric(x)[subscripts];
## y <- as.numeric(y)[subscripts];
## z <- as.numeric(z)[subscripts];
## zero <- (z == 0L);
## #if(any(isTRUE(zero))){
## #    panel.levelplot(x[!zero], y[!zero], z[!zero], ...)
##     panel.points(x[zero], y[zero], pch = 4, col = "black", ...)
## #} else{
## #    panel.levelplot(x[subscript], y[subscript], z[subscript], ...)
## #}
