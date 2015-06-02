##' @title Creates the ticks for the maps.
##' @name xyticks
##'
##' @description Creates the ticks and labels to print in the maps. This
##' is an internal function.
##'
##' @inheritParams levelmap
##'
##' @return A list with 4 components, to be used in levelmap.
##'
##' @author Fernando Mayer \email{fernandomayer@@gmail.com}
xyticks <- function(xlim, ylim, square){
    labsx <- seq(min(xlim), max(xlim), square)
    labsxc <- as.character(labsx)
    labsxc[seq(2, length(labsxc), 2)] <- ""
    labsy <- seq(min(ylim), max(ylim), square)
    labsyc <- as.character(labsy)
    labsyc[seq(2, length(labsyc), 2)] <- ""
    labs <- list(labsx = labsx, labsxc = labsxc,
                 labsy = labsy, labsyc = labsyc)
    return(labs)
}
