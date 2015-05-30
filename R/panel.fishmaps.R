##' @title A lattice panel function
##' @name panel.fishmaps
##'
##' @description A lattice panel function to draw rectangles where z is
##' different from zero and to draw points where z is exactly zero
##'
##' @param x from lattice fomrmula x
##' @param y from lattice fomrmula y
##' @param z from lattice fomrmula z
##' @param map.db map database
##' @param msq middle square
##' @param breaks from main function
##' @param col.reg from main function
##' @param labsx from main function
##' @param labsy from main function
##' @param subscripts lattice subscripts
##' @param ... other arguments passed to other lattice panels
##'
##' @return Nothing
##'
##' @author Fernando Mayer
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
    panel.points(x[zero], y[zero], pch = 4, ...)
    ## Add a grid according to x and y labels
    panel.grid(h = -length(labsx), v = -length(labsy), ...)
    ## Draw the coastline
    panel.polygon(map.db$lon, map.db$lat,
                  border = "black", col = "snow", ...)
}
