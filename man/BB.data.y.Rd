\name{BB.data.y}
\alias{BB.data.y}
\docType{data}
\title{Baitboat yearly aggregated data}

\description{
    Skipjack tuna CPUE by year, caught by the brazilian baitboat fleet, based at Itajai (SC) harbor.
}

\usage{data(BB.data.y)}

\format{
  A data frame with 56 observations on the following 4 variables.
  \describe{
    \item{\code{year}}{a factor with levels \code{2001} \code{2002}}
    \item{\code{lat}}{a numeric vector}
    \item{\code{lon}}{a numeric vector}
    \item{\code{cpue}}{a numeric vector}
  }
}

%\details{
%
%}

\source{
  Randomly generated data.
}

%\references{
%  ~~ possibly secondary sources and usages ~~
%}

\examples{
data(BB.data.y)
str(BB.data.y)
}

\keyword{datasets}
