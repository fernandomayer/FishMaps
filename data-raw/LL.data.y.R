##======================================================================
## Changing some values to zero in the original data examples
setwd("./data-raw/")
getwd()
# LL YEAR with ZERO
load("LL.data.y.rda")
str(LL.data.y)
set.seed(1982)
idx <- sample(nrow(LL.data.y), size = 8)
LL.data.y$cpue[idx] <- 0
summary(LL.data.y)
save("LL.data.y", file = "../data/LL.data.y.rda")
##======================================================================
