##' @title A lattice panel function
##' @name panel.fishmaps
##'
##' @description A lattice panel function to draw rectangles where z is
##' different from zero and to draw points where z is exactly zero.
##'
##' @param x From lattice formula x.
##' @param y From lattice formula y.
##' @param z From lattice formula z.
##' @param map.db The map database.
##' @param msq The middle of squares defined in argument \code{square}
##' in \code{\link{levelmap}}.
##' @param breaks The \code{breaks} argument from \code{\link{levelmap}}.
##' @param col.reg The color regions, from \code{\link{levelmap}}.
##' @param labsx The x axis ticks and labels.
##' @param labsy The y axis ticks and labels.
##' @param subscripts Lattice panel subscripts.
##' @param ... Other arguments passed to lattice panel functions.
##'
##' @details All arguments used here are defined in the source of the
##' \code{\link{levelmap}} function.
##'
##' @author Fernando Mayer \email{fernandomayer@@gmail.com}
panel.fishmaps <- function(x, y, z, map.db, msq, breaks, col.reg,
                           labsx, labsy, subscripts, ...){
    x <- as.numeric(x)[subscripts]
    y <- as.numeric(y)[subscripts]
    z <- as.numeric(z)[subscripts]
    ## If thera are any zeroes at z (the reponse variable), identify
    ## those values to plot a different symbol
    zero <- (z == 0L)
    ## Use levelplot for values different than zero
    ## panel.levelplot(x[!zero], y[!zero], z[!zero], subscripts = TRUE,
    ##                 aspect = "iso", ...)
    ## Actually, panel.levelplot dysplay the squares in irregular sizes,
    ## so panel.rect is a better function to control for the square
    ## sizes to remain equal
    panel.rect(xleft = x[!zero] - msq, ybottom = y[!zero] - msq,
               xright = x[!zero] + msq, ytop = y[!zero] + msq,
               col = level.colors(z[!zero], at = breaks, col.regions = col.reg),
               border = 0, ...)
    ## Use points to plot an X where z is zero
    panel.points(x[zero], y[zero], pch = 4, col = "black", ...)
    ## Add a grid according to x and y labels
    panel.grid(h = -length(labsy), v = -length(labsx), ...)
    ## Draw the coastline
    panel.polygon(map.db$lon, map.db$lat,
                  border = "black", col = "snow", ...)
}
