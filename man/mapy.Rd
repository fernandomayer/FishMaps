\name{mapy}
\alias{mapy}
\title{Plots yearly fishery data into maps}

\description{
    Plots georeferenced fishery data (catch, effort and CPUE) aggregated by year into maps. 
    This function can use pre-defined maps, such as \code{\link{mapLL}} and \code{\link{mapBB}}, or
    users can specify their own map boundaries. Data are properly separated to form classes and
    each class has a weight. Solid circles proportional to the class weights are plotted in the
    map. A legend is also provided. Resulting maps can be displayed on the screen (each one after
    the user presses the <Enter> key), or automatically saved in PNG or PDF file format, with an
    appropriate name.
}

\usage{
mapy(year, lat, lon, cfu, breaks, type = c("LL", "BB"),
    ident = TRUE, ident.type = c("num", "let"), 
    ident.cex = 1, xlim = NULL, ylim = NULL,
    majortick = NULL, minortick = NULL, mapgrid = TRUE,
    legend = TRUE, leg.pos = "bottomright", leg.cex = 1,
    leg.title = NULL, fig = FALSE, fig.type = c("png", "pdf"),
    fig.w, fig.h, fig.name, fig.par = NULL, ...)
}

\arguments{
  \item{year}{a vector with years relative to data. This can be \code{numeric} or \code{factor}.}
  \item{lat}{a \code{numeric} vector with latitudes in degrees. Southern positions from Equator
    must be negative.}
  \item{lon}{a \code{numeric} vector with longitudes in degrees. Western positions from Greenwich
    must be negative.}
  \item{cfu}{a \code{numeric} vector with catch (c), effort (f), or CPUE (u) data.}
  \item{breaks}{either a numeric vector of cut points or number giving the number of intervals 
    which \code{cfu} is to be cut into. This is the same used in the function \code{cut}. See 
    \code{?cut} for more details. NOTE: if \code{cfu} contains zero values, the best way to specify
    \code{breaks} is only with the number of intervals. If you wish to specify a numeric vector of
    cut points, start with a number different of zero. This function was designed to handle zero
    values in \code{cfu} properly.}
  \item{type}{the type of map to be drawn. \dQuote{LL} (the default) uses the 
    \code{\link{mapLL}} function, and \dQuote{BB} uses the \code{\link{mapBB}} function. 
    Only specify one of them if you want to use the pre-defined maps. If you will specify your 
    own map boundaries, don't specify the type and use the \code{xlim} and \code{ylim} arguments
    (see below).}
  \item{ident}{logical. If TRUE (the default), add an identifier for the map.}
  \item{ident.type}{the type of identifier to be used. \dQuote{num} uses the very same 
    years as in the \code{year} vector. \dQuote{let} will add an uppercase letter, 
    starting with A and so on. The identifier will always be located in the upper left corner of 
    the map.}
  \item{ident.cex}{a numeric value with the character expansion of the identifier.}
  \item{xlim}{a \code{numeric} vector of length 2, giving the range of longitudes in which the map
    will be restricted. Use \code{xlim} only if you want to specify your own map boundaries.}
  \item{ylim}{a \code{numeric} vector of length 2, giving the range of latitudes in which the map
    will be restricted. Use \code{ylim} only if you want to specify your own map boundaries.}
  \item{majortick}{a number specifying the interval at which major ticks will be drawn in the map.
    This will also be the interval at which the number of latitude and longitude will be
    explicitly displayed.}
  \item{minortick}{a number specifying the interval at which minor ticks will be drawn in the map.
    This will also be the interval at which the number of latitude and longitude will NOT be
    explicitly displayed.}
  \item{mapgrid}{should a grid be drawn in the user-defined map? Note that \code{mapgrid} is 
    only used when \code{xlim} and \code{ylim} are specified, i.e, it's a user-defined map. To
    control the grid output in a pre-defined map (when using argument \code{type}), use the
    \code{map.grid} argument which is used in the \code{\link{mapLL}} and \code{\link{mapBB}}
    functions.}
  \item{legend}{logical. Should a legend be displayed in the map?}
  \item{leg.pos}{the legend position. A \code{character} name indicating where the legend should 
    be placed in the map. Must be one of \dQuote{bottomright}, \dQuote{bottom},
    \dQuote{bottomleft}, \dQuote{left}, \dQuote{topleft}, \dQuote{top},
    \dQuote{topright}, \dQuote{right}, \dQuote{center}.}
  \item{leg.cex}{the character expansion for the legend. This is intended to be used in the
    legend title and in the legend itself.}
  \item{leg.title}{a \code{character} title for the legend.}
  \item{fig}{should \code{mapy} make figures of the maps instead of plotting them on the screen? 
  Note that if this is set to TRUE, you willnot see the maps on the screen.}
  \item{fig.type}{the file format for the figures. Must be one of \dQuote{png} (default) or
    \dQuote{pdf}.}
  \item{fig.w}{the figure width. For \dQuote{png} use pixels, and for \dQuote{pdf}
    use inches.}
  \item{fig.h}{the figure height. For \dQuote{png} use pixels, and for \dQuote{pdf}
    use inches.}
  \item{fig.name}{a \code{character} name. This name is used to compose the name of the file
    generated by \code{mapy}. The name of the files are composed of \code{map_fig.name_year.ext}.
    So if \code{fig.type} is \dQuote{png}, and \code{fig.name} is, e.g., 
    \dQuote{cpue}, a typical file name will be \code{map_cpue_2001.png}. The
    \sQuote{year} will vary with the years as in \code{year}. Use \code{fig.name} to
    distinguish your variables in the file names.}
  \item{fig.par}{a \code{list} specifying the graphical parameters for the figure. Any arguments
    used in \code{par()} are allowed. See \code{?par} for more details.}
  \item{\dots}{other arguments from the \code{map} and \code{\link{mapLL}} (or \code{\link{mapBB}})
    functions. See \code{?map}, \code{?mapLL} and \code{?mapBB}.}
}

\details{
    Coming soon.
}

\value{
    This function plots maps with solid circles proportional to a variable (catch, effort or CPUE) 
    on the current graphics device. Each map is shown after the <Enter> key is pressed by the user.
    If \code{fig = TRUE} then the maps are not seen on the screen, but are saved to files (as PNG 
    or PDF file formats) in the working directory.
}

\references{
    Becker, R. A. and Wilks, A. R. 1993. Maps in S. \emph{AT&T Bell Laboratories Statistics 
    Research Report [93.2]}.
}

\author{
    Fernando Mayer \email{fernandomayer@gmail.com}
}

\seealso{
    \code{map} from the \pkg{maps} package. \code{\link{mapLL}} and \code{\link{mapBB}} from 
    \pkg{FishMaps}. \code{cut}, which is used to separete data into classes.
    
}

\examples{
%\dontrun{
## loading longline data
data(LL.data.y)
attach(LL.data.y)
# a simple example
mapy(year,lat,lon,cpue,breaks=4)
# an enhanced map: full resolution, legend title and no grid
mapy(year,lat,lon,cpue,breaks=4,map.data="worldHires",resolution=0,
    grid=FALSE,leg.title="CPUE\n(kg/1000 hooks)")
# a user-defined map
mapy(year,lat,lon,cpue,breaks=4,xlim=c(-70,-15),ylim=c(-60,-5),
    majortick=10,minortick=5,border=0)
detach(LL.data.y)

## loading baitboat data
data(BB.data.y)
attach(BB.data.y)
# a simple example
mapy(year,lat,lon,cpue,type="BB",breaks=4)
# an enhanced map: full resolution, legend title and no grid
mapy(year,lat,lon,cpue,type="BB",breaks=4,map.data="worldHires",
    resolution=0,grid=FALSE,leg.title="CPUE\n(t/fishing day)")
# a user-defined map
mapy(year,lat,lon,cpue,breaks=4,xlim=c(-52,-40),ylim=c(-34,-22),
    majortick=2,minortick=1,border=0)
detach(BB.data.y)
%}
}

\keyword{iplot}
