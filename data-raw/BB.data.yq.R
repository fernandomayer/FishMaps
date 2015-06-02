##======================================================================
## Changing some values to zero in the original data examples
setwd("./data-raw/")
getwd()
# BB YEAR-QUARTER with ZERO
load("BB.data.yq.rda")
str(BB.data.yq)
set.seed(1982)
idx <- sample(nrow(BB.data.yq), size = 18)
BB.data.yq$cpue[idx] <- 0
summary(BB.data.yq)
save("BB.data.yq", file = "../data/BB.data.yq.rda")
##======================================================================
