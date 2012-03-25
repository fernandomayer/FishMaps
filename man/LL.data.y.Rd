\name{LL.data.y}
\alias{LL.data.y}
\docType{data}
\title{Longline yearly aggregated data}

\description{
    Swordfish CPUE by year, caught by the brazilian longline fleet, based at Itajai (SC) harbor.
}

\usage{data(LL.data.y)}

\format{
  A data frame with 82 observations on the following 4 variables.
  \describe{
    \item{\code{year}}{a factor with levels \code{2001} \code{2002} \code{2003} \code{2004} \code{2005}}
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
%
%}

\examples{
data(LL.data.y)
str(LL.data.y)
}

\keyword{datasets}
