##======================================================================
## Changing some values to zero in the original data examples
setwd("./data-raw/")
getwd()
# LL YEAR-QUARTER with ZERO
load("LL.data.yq.rda")
str(LL.data.yq)
set.seed(1982)
idx <- sample(nrow(LL.data.yq), size = 18)
LL.data.yq$cpue[idx] <- 0
summary(LL.data.yq)
save("LL.data.yq", file = "../data/LL.data.yq.rda")
##======================================================================
