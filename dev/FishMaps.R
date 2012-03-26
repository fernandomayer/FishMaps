##======================================================================
## This is the main development file for FishMaps. Everything here is
## experimental and is used for tests and examples.
##======================================================================

##----------------------------------------------------------------------
## Datasets for examples
##----------------------------------------------------------------------

# tamanho amostral por ano e trimestre
mapa.latt <- read.csv("./datasets/mapa.latt.csv")
# tamanho amostral por trimestre
mapa.latt.q <- read.csv("./datasets/mapa.latt.q.csv")
# captura whm por trimestre
mapa.whm <- read.csv("./datasets/mapa.whm.csv")
# captura bum por trimestre
mapa.bum <- read.csv("./datasets/mapa.bum.csv")
# captura conjunta (whm e bum) por trimestre
mapa.conj <- read.csv("./datasets/mapa.conj.csv")


##----------------------------------------------------------------------
## Essa parte contem todas as definicoes comuns para todos os tipos de
## mapas que serao feitos
##----------------------------------------------------------------------

# base de dados para o mapa
library(maps)
mm <- map("world", plot = FALSE)

# define os ranges do mapa, e os labels para colocar nos graficos
# aqui estao soh as defincoes para os maps do atlantico sul ,baseado no
# range desses dados. Precisamos tornar isso generico
xlim <- c(-60, 20)
labsx <- seq(-60,20,5)
labsxc <- as.character(labsx)
labsxc[seq(2, length(labsxc), 2)] <- ""
ylim <- c(-50, 5)
labsy <- seq(-50,5,5)
labsyc <- as.character(labsy)
labsyc[seq(2, length(labsyc), 2)] <- ""

# Funcao para adicionar os pontos onde a captura eh zero. Tive que fazer
# a condicao para separar os pontos com zero dos demais, e a unica forma
# que achei foi plotando os positivos com um ponto invisivel. Note que
# se houver um valor nulo e um positivo no mesmo quadrado, o ponto vai
# ser adicionado junto com a cor do levelplot, pois nao consigui fazer
# ele distinguir se naquele ponto houve algum outro valor que foi
# positivo. Isso implica em que geralmente sera nexessario fazer um
# aggregate antes de plotar os dados para que nao haja esse tipo de
# sobreposicao. (Essa funcao foi baseada na panel.corrgram.2() da Figura
# 13.5 do livro do Lattice - o codigo esta no site).
panel.zero.points <- function(x, y, z, subscripts, ...){
    require("grid", quietly = TRUE)
    x <- as.numeric(x)[subscripts]
    y <- as.numeric(y)[subscripts]
    z <- as.numeric(z)[subscripts]
    for(i in seq(along = z)){
        if(z[i] == 0L){
            grid.points(x = x[i], y = y[i], pch = "+")
        } else{
            grid.points(x = x[i], y = y[i], pch = "")
        }
    }
}

##----------------------------------------------------------------------


## Usando a base mapa.latt - aqui varias paginas de graficos sao geradas
##----------------------------------------------------------------------

# define as quebras de classe para serem usadas para calcular os niveis
# (argumento at)
lev <- do.breaks(range(mapa.latt$x), 2)
# adiciona mais uma classe para englobar os valores iguais ao min, caso
# contrario ele fica de fora
lev <- c(0, lev)
# cria um label
levc <- as.character(lev)
levc[1] <- ""

## # final do arquivo com p para portrait
## pdf("mapa_Namostral_p.pdf", width = 8, height = 10)
## # final do arquivo com l para landscape
## pdf("mapa_Namostral_l.pdf", width = 12, height = 10,
##     onefile = TRUE, paper = "a4r")

# define a quebra dos anos
anos <- round(do.breaks(range(mapa.latt$YearC), 13))

# print eh necessario quando uma funcao do çattice eh usada dentro do
# for()
for(i in 2:length(anos)){
print(levelplot(x ~ Lon3 + Lat3 | factor(YearC) + factor(Quarter),
          data = mapa.latt, mm = mm, aspect = "iso",
          subset = YearC %in% (anos[i-1]:anos[i]),
          as.table = TRUE, xlim = xlim, ylim = ylim,
          xlab = expression(paste("Longitude ", "(", degree, ")")),
          ylab = expression(paste("Latitude ", "(", degree, ")")),
          between = list(x = c(1,1), y = c(1,1)), pretty = TRUE,
          scales = list(x = list(at = labsx, labels = labsxc),
          y = list(at = labsy, labels = labsyc)),
          strip = strip.custom(bg = "lightgrey"),
          at = lev, col.regions = rev(grey.colors(length(lev)-1)),
          #col.regions = rev(do.call(grey, list(seq(.1,.9,.3)))),
          colorkey=list(space="right",labels=list(at=lev,labels=levc)),
          panel = function(x, mm, ...){
              panel.levelplot(x, ...)
              panel.grid(h = -length(labsx), v = -length(labsy), ...)
              panel.lines(mm$x, mm$y, col = "black")
          }))
}
# dev.off()

##----------------------------------------------------------------------


## Usando mapa.latt.q - apenas por trimestre, soh uma pagina de graficos
##----------------------------------------------------------------------

# quebras
lev <- round(do.breaks(range(mapa.latt.q$x), 13))
levc <- as.character(lev)
levc[1] <- ""

# levelplot
## pdf("mapa_tam_amostral_quarter.pdf", w=12, h=10)
levelplot(x ~ Lon3 + Lat3 | factor(Quarter),
          data = mapa.latt.q, mm = mm, aspect = "iso",
          as.table = TRUE, xlim = xlim, ylim = ylim,
          xlab = expression(paste("Longitude ", "(", degree, ")")),
          ylab = expression(paste("Latitude ", "(", degree, ")")),
          between = list(x = c(1,1), y = c(1,1)), pretty = TRUE,
          scales = list(x = list(at = labsx, labels = labsxc),
          y = list(at = labsy, labels = labsyc)),
          strip = strip.custom(bg = "lightgrey"),
          at = lev, col.regions = rev(grey.colors(length(lev)-1)),
          colorkey = list(space="right", labels=list(at=lev, labels=levc)),
          panel = function(x, mm, ...){
              panel.levelplot(x, ...)
              panel.grid(h = -length(labsx), v = -length(labsy), ...)
              panel.lines(mm$x, mm$y, col = "black")
          })
# dev.off()

##---------------------------------------------------------------------


## Mapa de WHM
##----------------------------------------------------------------------

# define as quebras de classe para serem usadas para calcular os niveis
# (argumento at)
lev <- pretty(mapa.whm$x[mapa.whm$x > 0], 40)
lev[1] <- 1

# levelplot - NOTE que pelo fato dos niveis (lev) terem sido criados sem
# a inclusao do zero, o que faz com que os valores calculados e plotados
# pelo levelplot nao incluam o zero. A funcao panel.zero.points()
# (definida acima), serve para incluir os pontos onde existem dados
# (inclusive os zeros)
levelplot(x ~ Lon3 + Lat3 | factor(Quarter),
          data = mapa.whm, mm = mm, aspect = "iso",
          as.table = TRUE, xlim = xlim, ylim = ylim,
          xlab = expression(paste("Longitude ", "(", degree, ")")),
          ylab = expression(paste("Latitude ", "(", degree, ")")),
          between = list(x = c(1,1), y = c(1,1)), pretty = TRUE,
          scales = list(x = list(at = labsx, labels = labsxc),
          y = list(at = labsy, labels = labsyc)),
          strip = strip.custom(bg = "lightgrey"),
          at = lev, col.regions = rev(grey.colors(length(lev)-1)),
          colorkey = list(space="right"),
          panel = function(x, y, z, mm, ...){
              panel.levelplot(x, y, z, ...)
              panel.grid(h = -length(labsx), v = -length(labsy), ...)
              panel.lines(mm$x, mm$y, col = "black")
              panel.zero.points(x, y, z, ...)
          })

##----------------------------------------------------------------------


## Mapa de BUM
##----------------------------------------------------------------------

# define as quebras de classe para serem usadas para calcular os niveis
# (argumento at)
lev <- pretty(mapa.bum$x[mapa.bum$x > 0], 40)
lev[1] <- 1

# levelplot
levelplot(x ~ Lon3 + Lat3 | factor(Quarter),
          data = mapa.bum, mm = mm, aspect = "iso",
          as.table = TRUE, xlim = xlim, ylim = ylim,
          xlab = expression(paste("Longitude ", "(", degree, ")")),
          ylab = expression(paste("Latitude ", "(", degree, ")")),
          between = list(x = c(1,1), y = c(1,1)), pretty = TRUE,
          scales = list(x = list(at = labsx, labels = labsxc),
          y = list(at = labsy, labels = labsyc)),
          strip = strip.custom(bg = "lightgrey"),
          at = lev, col.regions = rev(grey.colors(length(lev)-1)),
          colorkey = list(space="right"),
          panel = function(x, y, z, mm, ...){
              panel.levelplot(x, y, z, ...)
              panel.grid(h = -length(labsx), v = -length(labsy), ...)
              panel.lines(mm$x, mm$y, col = "black")
              panel.zero.points(x, y, z, ...)
          })

##----------------------------------------------------------------------


## Mapa CAPTURA - conjunto
##----------------------------------------------------------------------

# define os levels conjuntos
lev <- with(mapa.conj, pretty(c(WHM[WHM>0], BUM[BUM>0]), 40))
lev[1] <- 1

# levelplot
# pdf("mapa_captura.pdf", w=12, h=10, paper="a4r")
levelplot(WHM + BUM ~ Lon3 + Lat3 | factor(Quarter), outer = TRUE,
          data = mapa.conj, mm = mm, aspect = "iso",
          as.table = TRUE, xlim = xlim, ylim = ylim,
          xlab = expression(paste("Longitude ", "(", degree, ")")),
          ylab = expression(paste("Latitude ", "(", degree, ")")),
          between = list(x = c(1,1), y = c(1,1)), pretty = TRUE,
          scales = list(x = list(at = labsx, labels = labsxc),
          y = list(at = labsy, labels = labsyc)),
          strip = strip.custom(bg = "lightgrey"),
          at = lev, col.regions = rev(grey.colors(length(lev)-1)),
          colorkey = list(space="right"),
          panel = function(x, y, z, mm, ...){
              panel.levelplot(x, y, z, ...)
              panel.grid(h = -length(labsx), v = -length(labsy), ...)
              panel.lines(mm$x, mm$y, col = "black")
              panel.zero.points(x, y, z, ...)
          })
# dev.off()
