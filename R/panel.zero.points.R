##' @title A lattice panel function
##' @name panel.zero.points
##'
##' @description A lattice panel function to plot special characters to
##' maps when data is zero.
##'
##' @param x From lattice fomrmula x.
##' @param y From lattice fomrmula y.
##' @param z From lattice fomrmula z.
##' @param subscripts Lattice panbel subscripts.
##' @param ... Other arguments passed to lattice panel functions.
##'
##' @author Fernando Mayer \email{fernandomayer@@gmail.com}
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
