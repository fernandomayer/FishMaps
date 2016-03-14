

# FishMaps 0.3.3

[![Build Status](https://travis-ci.org/fernandomayer/FishMaps.svg)](https://travis-ci.org/fernandomayer/FishMaps)

Plots Fishery Data into Maps

## Introduction

FishMaps was designed to plot georeferenced fishery data (e.g. catch,
effort and CPUE) into maps. This package uses the [lattice][] levelplot
to draw a _level_plot _map_ based on latitude and longitude, with a
resolution defined by the size of lat/long squares (e.g. 1x1 or 5x5
degrees). Coastlines are drawn to display the map, based on two
databases: world (lower resolution) and worldHires (higher resolution),
extracted from the databases of the names in [maps][] and [mapdata][]
packages. However, none of these packages are required since the
databases are incorporated inside FishMaps.

Producing this kind of maps in `R` can be really straightforward, but
the difference is that FishMaps can automate this task, producing lots
of maps (*e.g.* from a long time series) with one command and using the
power and the cleverness of lattice graphics.

Although FishMaps was designed for fishery data, any kind of
georeferenced data can be used.

## Download and install

### Linux/Mac

Use the `devtools` package (available from
[CRAN](http://cran-r.c3sl.ufpr.br/web/packages/devtools/index.html)) to
install automatically from the official Git repository:


```r
library(devtools)
install_git("http://git.leg.ufpr.br/fernandomayer/FishMaps.git")
```

or, you can also install from the (mirrored) GitHub repository with:


```r
install_github("fernandomayer/FishMaps")
```

Alternatively, download the package tarball: [FishMaps_0.3.3.tar.gz][]
and run from a UNIX terminal (make sure you are on the container file
directory):


```
R CMD INSTALL -l /path/to/your/R/library FishMaps_0.3.3.tar.gz
```

Or, inside an `R` session:



```
install.packages("FishMaps_0.3.3.tar.gz", repos = NULL,
                 lib.loc = "/path/to/your/R/library",
                 dependencies = TRUE)
```

Note that `-l /path/to/your/R/library` in the former and `lib.loc =
"/path/to/your/R/library"` in the latter are optional. Only use it if you
want to install in a personal library, other than the standard R
library.

### Windows

Download Windows binary version: [FishMaps_0.3.3.zip][] (**do not unzip
it under Windows**), put the file in your working directory, and from
inside `R`:


```
install.packages("FishMaps_0.3.3.zip", repos = NULL,
                 dependencies = TRUE)
```

## Documentation

The reference manual in PDF can be found here: [FishMaps-manual.pdf][]

## License

This package is released under the
[GNU General Public License (GPL) v. 3.0](http://www.gnu.org/licenses/gpl-3.0.html)



[lattice]: http://cran-r.c3sl.ufpr.br/web/packages/lattice/index.html
[maps]: http://cran-r.c3sl.ufpr.br/web/packages/maps/index.html
[mapdata]: http://cran-r.c3sl.ufpr.br/web/packages/mapdata/index.html
[FishMaps_0.3.3.tar.gz]: https://github.com/fernandomayer/FishMaps/raw/master/downloads/FishMaps_0.3.3.tar.gz
[FishMaps_0.3.3.zip]: https://github.com/fernandomayer/FishMaps/raw/master/downloads/FishMaps_0.3.3.zip
[FishMaps-manual.pdf]: https://github.com/fernandomayer/FishMaps/raw/master/downloads/FishMaps-manual.pdf
