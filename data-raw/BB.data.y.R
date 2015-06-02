##======================================================================
## Changing some values to zero in the original data examples
setwd("./data-raw/")
getwd()
# BB YEAR with ZERO
load("BB.data.y.rda")
str(BB.data.y)
set.seed(1982)
idx <- sample(nrow(BB.data.y), size = 8)
BB.data.y$cpue[idx] <- 0
summary(BB.data.y)
save("BB.data.y", file = "../data/BB.data.y.rda")
##======================================================================
