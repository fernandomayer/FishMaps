\name{mapLL}
\alias{mapLL}
\title{Draw a map for longline fishery data}
\description{
    Draw a standard map where longline fishery data (catch, effort and CPUE) from the southwestern 
    Atlantic Ocean can be plotted. Maps are built with the standard function \code{map} from the 
    \pkg{maps} package. This function is used by other functions, such as \code{\link{mapy}} and
    \code{\link{mapq}}.
}

\usage{
mapLL(grid = TRUE, names = FALSE, map.data = c("world", "worldHires"), ...)
}

\arguments{
  \item{grid}{logical. If TRUE (the default), a grid is drawn in 5 x 5 squares.}
  \item{names}{logical. if TRUE, the name of coastal countries (i.e. Brazil, Uruguay and 
    Argentina) are drawn in upper case. Uruguay and Argentina are abbreviated.}
  \item{map.data}{the database used to draw the maps. This should be one of \dQuote{world}
    (default - low resolution) or \dQuote{worldHires} (hi resolution). See more details in
    \code{?map}.}
  \item{\dots}{other arguments from the \code{map} function. See \code{?map}.}
}

\details{
The function \code{mapLL} only draw a pre-defined map of the southwestern Atlantic Ocean.
Nothing more is done. The boundaries for this map are: from 10 S to 55 S of latitude and
from 20 W to 65 W of longitude.
}

\value{
    A map from the southwestern Atlantic Ocean.
}

\references{
    Becker, R. A. and Wilks, A. R. 1993. Maps in S. \emph{AT&T Bell Laboratories Statistics 
    Research Report [93.2]}.
}

\author{
    Fernando Mayer \email{fernandomayer@gmail.com}
}

\seealso{
    \code{map} from package \pkg{maps}. \code{degAxis} from \pkg{sp} package,
    from which the map axes were drawn with the degree symbol.
}

\examples{
%\dontrun{
# a simple example
mapLL(grid = FALSE, names = TRUE)
# mapLL with full resolution
mapLL(map.data = "worldHires", resolution = 0)
%}
}

\keyword{hplot}
