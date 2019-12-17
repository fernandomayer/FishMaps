##======================================================================
## This is the main development file for FishMaps. Everything here is
## experimental and is used for tests and examples.
##======================================================================

## Para carregar as funcoes (simula o pacote instalado e carregado)
devtools::load_all()
## Para atualizar a documentacao
devtools::document()
## Para conferir a documantacao
devtools::check_man()
## Para conferir o pacote completo
devtools::check()

## testando a funcao levelmap
args(levelmap)

##----------------------------------------------------------------------
## Bait Boat
##----------------------------------------------------------------------

## BB YEAR
levelmap(cpue ~ lon + lat | year, data = BB.data.y,
         xlim = c(-60, -40), ylim = c(-35, -20),
         key.space = "right", database = "world",
         breaks = pretty(BB.data.y$cpue), square = 1,
         col.land = "darkgrey")

## BB YEAR with ZERO
str(BB.data.y)
set.seed(1982)
idx <- sample(nrow(BB.data.y), size = 8)
bait.boat.y0 <- BB.data.y
bait.boat.y0$cpue[idx] <- 0
levelmap(cpue ~ lon + lat | year, data = bait.boat.y0,
         xlim = c(-60, -40), ylim = c(-35, -20),
         key.space = "right", database = "world",
         breaks = pretty(bait.boat.y0$cpue), square = 1)

## BB YEAR with ZERO and NA
bait.boat.y0na <- bait.boat.y0
## -25.5/-45.5 (2001)
bait.boat.y0na$cpue[9] <- NA
## -23.5/-41.5 (2002)
bait.boat.y0na$cpue[28] <- NA
levelmap(cpue ~ lon + lat | year, data = bait.boat.y0na,
         xlim = c(-60, -40), ylim = c(-35, -20),
         key.space = "right", database = "world",
         breaks = pretty(bait.boat.y0na$cpue), square = 1)

## BB YEAR-QUARTER
levelmap(cpue ~ lon + lat | year + quarter, data = BB.data.yq,
         xlim = c(-60, -40), ylim = c(-35, -20),
         key.space = "right", database = "world",
         breaks = pretty(BB.data.yq$cpue), square = 1)

## BB YEAR-QUARTER with ZERO
str(BB.data.yq)
set.seed(1982)
idx <- sample(nrow(BB.data.yq), size = 18)
bait.boat.yq0 <- BB.data.yq
bait.boat.yq0$cpue[idx] <- 0
levelmap(cpue ~ lon + lat | year + quarter, data = bait.boat.yq0,
         xlim = c(-60, -40), ylim = c(-35, -20),
         key.space = "right", database = "world",
         breaks = pretty(bait.boat.yq0$cpue), square = 1)

## BB YEAR-QUARTER with ZERO and NA
bait.boat.yq0na <- bait.boat.yq0
## -32.5/-50.5 (2001/2)
bait.boat.yq0na$cpue[34] <- NA
## -23.5/-41.5 (2002/1)
bait.boat.yq0na$cpue[61] <- NA
levelmap(cpue ~ lon + lat | year + quarter, data = bait.boat.yq0na,
         xlim = c(-60, -40), ylim = c(-35, -20),
         key.space = "right", database = "world",
         breaks = pretty(bait.boat.yq0na$cpue), square = 1)
##----------------------------------------------------------------------

##----------------------------------------------------------------------
## Long Line
##----------------------------------------------------------------------

## LL YEAR
levelmap(cpue ~ lon + lat | year, data = LL.data.y,
         xlim = c(-60, -20), ylim = c(-50, -10),
         key.space = "right", database = "world",
         breaks = pretty(LL.data.y$cpue), square = 5)

## LL YEAR with ZERO
str(LL.data.y)
set.seed(1982)
idx <- sample(nrow(LL.data.y), size = 8)
long.line.y0 <- LL.data.y
long.line.y0$cpue[idx] <- 0
levelmap(cpue ~ lon + lat | year, data = long.line.y0,
         xlim = c(-60, -20), ylim = c(-50, -10),
         key.space = "right", database = "world",
         breaks = pretty(long.line.y0$cpue), square = 5)

## LL YEAR with ZERO and NA
long.line.y0na <- long.line.y0
## -27.5/-37.5 (2002)
long.line.y0na$cpue[26] <- NA
## -37.5/-32.5 (2005)
long.line.y0na$cpue[72] <- NA
levelmap(cpue ~ lon + lat | year, data = long.line.y0na,
         xlim = c(-60, -20), ylim = c(-50, -10),
         key.space = "right", database = "world",
         breaks = pretty(long.line.y0na$cpue), square = 5)

## LL YEAR-QUARTER
levelmap(cpue ~ lon + lat | year + quarter, data = LL.data.yq,
         xlim = c(-60, -20), ylim = c(-50, -10),
         key.space = "right", database = "world",
         breaks = pretty(LL.data.yq$cpue), square = 5)

## LL YEAR-QUARTER with ZERO
str(LL.data.yq)
set.seed(1982)
idx <- sample(nrow(LL.data.yq), size = 18)
long.line.yq0 <- LL.data.yq
long.line.yq0$cpue[idx] <- 0 # alguns ficaram escondidos
levelmap(cpue ~ lon + lat | year + quarter, data = long.line.yq0,
         xlim = c(-60, -20), ylim = c(-50, -10),
         key.space = "right", database = "world",
         breaks = pretty(long.line.yq0$cpue), square = 5)

## LL YEAR-QUARTER with ZERO and NA
long.line.yq0na <- long.line.yq0
## -32.5/-47.5 (2002/3)
long.line.yq0na$cpue[64] <- NA
## -32.5/-32.5 (2005/1)
long.line.yq0na$cpue[154] <- NA
levelmap(cpue ~ lon + lat | year + quarter, data = long.line.yq0na,
         xlim = c(-60, -20), ylim = c(-50, -10),
         key.space = "right", database = "world",
         breaks = pretty(long.line.yq0na$cpue), square = 5)
##----------------------------------------------------------------------


##----------------------------------------------------------------------
## Base de dados para o mapa
library(maps)
library(mapdata)
mm <- map("world", plot = FALSE, fill = TRUE)
##----------------------------------------------------------------------

##======================================================================
## Teste pointmap
da <- ## ver dados
str(da)
xlim <- c(-49, -48)
ylim <- c(-26.1, -25)

args(pointmap)
pointmap(Lat ~ Lon | factor(Semana), data = da,
         xlim = xlim, ylim = ylim,
         square = 0.1,
         database = "worldHires", col.land = "lightgrey")
