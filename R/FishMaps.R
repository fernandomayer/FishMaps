##' @title Proportional symbol mapping for fishery data in batch mode
##'
##' @description Proportional symbol mapping for fishery data in batch
##' mode (lattice version)
##'
##' @docType package
##' @name FishMaps
NULL

##' Baitboat yearly aggregated data
##'
##' Skipjack tuna CPUE by year, caught by the brazilian baitboat fleet, based
##' at Itajai (SC) harbor.
##'
##'
##' @name BB.data.y
##' @docType data
##' @usage data(BB.data.y)
##' @format A data frame with 56 observations on the following 4 variables:
##' \itemize{
##'   \item year: a factor with levels \code{2001}, \code{2002}
##'   \item lat: a numeric vector
##'   \item lon: a numeric vector
##'   \item cpue: a numeric vector
##' }
##' @source Randomly generated data.
##' @keywords datasets
##' @examples
##'
##' data(BB.data.y)
##' str(BB.data.y)
##'
NULL

##' Baitboat quarterly aggregated data
##'
##' Skipjack tuna CPUE by quarter and year, caught by the brazilian baitboat
##' fleet, based at Itajai (SC) harbor.
##'
##'
##' @name BB.data.yq
##' @docType data
##' @usage data(BB.data.yq)
##' @format A data frame with 120 observations on the following 5 variables:
##' \itemize{
##'   \item year: a factor with levels \code{2001}, \code{2002}
##'   \item quarter: a factor with levels \code{1}, \code{2}, \code{3}, \code{4}
##'   \item lat: a numeric vector
##'   \item lon: a numeric vector
##'   \item cpue: a numeric vector
##' }
##' @source Randomly generated data.
##' @keywords datasets
##' @examples
##'
##' data(BB.data.yq)
##' str(BB.data.yq)
##'
NULL

##' Longline yearly aggregated data
##'
##' Swordfish CPUE by year, caught by the brazilian longline fleet, based at
##' Itajai (SC) harbor.
##'
##'
##' @name LL.data.y
##' @docType data
##' @usage data(LL.data.y)
##' @format A data frame with 82 observations on the following 4 variables.
##' \itemize{
##'   \item year: a factor with levels \code{2001}, \code{2002},
##'     \code{2003}, \code{2004}, \code{2005}
##'   \item lat: a numeric vector
##'   \item lon: a numeric vector
##'   \item cpue: a numeric vector
##' }
##' @source Randomly generated data.
##' @keywords datasets
##' @examples
##'
##' data(LL.data.y)
##' str(LL.data.y)
##'
NULL

##' Longline quarterly aggregated data
##'
##' Swordfish CPUE by year and quarter, caught by the brazilian longline fleet,
##' based at Itajai (SC) harbor.
##'
##'
##' @name LL.data.yq
##' @docType data
##' @usage data(LL.data.yq)
##' @format A data frame with 181 observations on the following 5 variables:
##' \itemize{
##'   \item year: a factor with levels \code{2001}, \code{2002},
##'     \code{2003}, \code{2004}, \code{2005}
##'   \item quarter: a factor with levels \code{1}, \code{2}, \code{3},
##'     \code{4}
##' \item lat: a numeric vector
##' \item lon: a numeric vector
##' \item cpue a numeric vector
##' }
##' @source Randomly generated data.
##' @keywords datasets
##' @examples
##'
##' data(LL.data.yq)
##' str(LL.data.yq)
##'
NULL



