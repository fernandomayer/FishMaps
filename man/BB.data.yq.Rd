\name{BB.data.yq}
\alias{BB.data.yq}
\docType{data}
\title{Baitboat quarterly aggregated data}

\description{
    Skipjack tuna CPUE by quarter and year, caught by the brazilian baitboat fleet, based at
    Itajai (SC) harbor.
}

\usage{data(BB.data.yq)}

\format{
  A data frame with 120 observations on the following 5 variables.
  \describe{
    \item{\code{year}}{a factor with levels \code{2001} \code{2002}}
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
data(BB.data.yq)
str(BB.data.yq)
}

\keyword{datasets}
