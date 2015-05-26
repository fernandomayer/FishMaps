##' @title A lattice panel function
##' @name panel.zero.points
##'
##' @description A lattice panel function to plot special characters to
##' maps when data is zero
##'
##' @param x from lattice fomrmula x
##' @param y from lattice fomrmula y
##' @param z from lattice fomrmula z
##' @param subscripts lattice subscripts
##' @param ... other arguments passed to other lattice panels
##'
##' @return Nothing.
##'
##' @author Fernando Mayer
panel.zero.points <- function(x, y, z, subscripts, ...){
    x <- as.numeric(x)[subscripts]
    y <- as.numeric(y)[subscripts]
    z <- as.numeric(z)[subscripts]
    for(i in seq_along(z)){
        if(z[i] == 0L){
            grid::grid.points(x = x[i], y = y[i], pch = "+",
                              size = grid::unit(1, "native"))
        } else if(is.na(z[i])){
            grid::grid.points(x = x[i], y = y[i], pch = "-",
                              size = grid::unit(1, "native"))
        } else{
            grid::grid.points(x = x[i], y = y[i], pch = "")
        }
    }
}
