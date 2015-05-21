##' @title Plots fishery data into maps
##' @name levelmap
##'
##' @description Plots georeferenced fishery data into maps. This
##' desciption must be expanded.
##'
##' @param x
##' @param data
##' @param xlim
##' @param ylim
##' @param breaks
##' @param jump
##' @param key.space
##' @param database
##' @param bathymetry
##' @param bathymetry.seq
##' @param ...
##'
##' @return A map with data
##'
##' @author Fernando Mayer
##'
##' @import lattice
##' @import latticeExtra
##' @import marelac
##'
##' @export
levelmap <- function(x, data, xlim, ylim, breaks, jump,
                     key.space = "right",
                     database = "world",
                     bathymetry = FALSE,
                     bathymetry.seq = NULL, ...){
    ## Pacotes necessarios: isso deve ser removido daqui antes de virar
    ## pacote. Esses pacotes devem ser dependencias e serao carregados
    ## automaticamente quando o FishMaps2 for carregado
    ## require(grid)
    ## require(lattice)
    ## require(latticeExtra)
    ## require(maps)
    ## require(mapdata)
    ## require(marelac)
    ## Base de dados para os mapas
    load("R/sysdata.rda")
    #data(worldHiresMapEnv)
    mm <- match.arg(database)
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
                grid.points(x = x[i], y = y[i], pch = "+",
                            size = unit(1, "native"))
            } else if(is.na(z[i])){
                grid.points(x = x[i], y = y[i], pch = "-",
                            size = unit(1, "native"))
            } else{
                grid.points(x = x[i], y = y[i], pch = "")
            }
        }
    }
    ## Função para converter a base de dados batimétricos.
    # mudei alguns nomes pra nao confundir com os que ja tinham
    isobath <- function(iso){
        temp <- expand.grid(iso$x, iso$y)
        temp2 <- data.frame(matrix(unlist(iso$z)))
        res <- data.frame(lat = temp[,1], lon = temp[,2], prof = temp2[,1])
        return(res)
    }
    ## levelmap com levelplot
    if(bathymetry){
        data(Bathymetry)
        ## converte as batimetrias em data.frame
        add <- isobath(Bathymetry)
        p <- levelplot(x, data, ..., mm = mm, bathymetry.seq = bathymetry.seq,
                       aspect = "iso", as.table = TRUE, xlim = xlim, ylim = ylim,
                       xlab = expression(paste("Longitude ", "(", degree, ")")),
                       ylab = expression(paste("Latitude ", "(", degree, ")")),
                       scales = list(x = list(at = labsx, labels = labsxc),
                           y = list(at = labsy, labels = labsyc)),
                       strip = strip.custom(bg = "lightgrey"),
                       at = breaks, colorkey = list(space = key.space),
                       col.regions = grey.colors(length(breaks)-1,
                           start = 0.7, end = 0.1),
                       par.settings = list(layout.heights =
                           list(top.padding = 0, bottom.padding = 0)),
                       panel = function(x, y, z, mm, ...){
                           panel.levelplot(x, y, z, ...)
                           panel.grid(h = -length(labsx), v = -length(labsy), ...)
                           panel.polygon(mm$x, mm$y, border = "black",
                                         col = "snow")
                           panel.zero.points(x, y, z, ...)
                       })
        p <- p + layer(
            panel.contourplot(x = lat, y = lon, z = prof,
                              at = bathymetry.seq,
                              col = "gray10", lty = "dashed",
                              contour = TRUE, subscripts = TRUE,
                              xlim = xlim, ylim = ylim,
                              region = FALSE,
                              labels = list(labels = TRUE,
                                  col = "gray10", cex = 0.5),
                              label.style = "flat"),
            data = add)
    } else{
        p <- levelplot(x, data, ..., mm = mm, aspect = "iso",
                       as.table = TRUE, xlim = xlim, ylim = ylim,
                       xlab = expression(paste("Longitude ", "(", degree, ")")),
                       ylab = expression(paste("Latitude ", "(", degree, ")")),
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
    print(p)
}
