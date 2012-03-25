\name{LL.data.yq}
\alias{LL.data.yq}
\docType{data}
\title{Longline quarterly aggregated data}

\description{
        Swordfish CPUE by year and quarter, caught by the brazilian longline fleet, based at
        Itajai (SC) harbor.
}
\usage{data(LL.data.yq)}

\format{
  A data frame with 181 observations on the following 5 variables.
  \describe{
    \item{\code{year}}{a factor with levels \code{2001} \code{2002} \code{2003} \code{2004} 
        \code{2005}}
    \item{\code{quarter}}{a factor with levels \code{1} \code{2} \code{3} \code{4}}
    \item{\code{lat}}{a numeric vector}
    \item{\code{lon}}{a numeric vector}
    \item{\code{cpue}}{a numeric vector}
  }
}

%\details{
%  ~~ If necessary, more details than the __description__ above ~~
%}

\source{
    Randomly generated data.
}

%\references{
%  ~~ possibly secondary sources and usages ~~
%}

\examples{
    data(LL.data.yq)
    str(LL.data.yq)
}

\keyword{datasets}
