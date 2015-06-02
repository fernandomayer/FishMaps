# FishMaps 0.3-0

[![Build Status](https://travis-ci.org/fernandomayer/FishMaps.svg)](https://travis-ci.org/fernandomayer/FishMaps)

Plots Fishery Data into Maps

## Introduction

FishMaps was designed to plot georeferenced fishery data (e.g. catch,
effort and CPUE) into maps. This function uses the [lattice][] levelplot
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
[CRAN](http://cran-r.c3sl.ufpr.br/web/packages/devtools/index.html) to
install automatically from this GitHub repository

```r
library(devtools)
install_github("fernandomayer/FishMaps")
```

### Windows

Download Windows binary version:
[FishMaps_0.3-0.zip](https://github.com/fernandomayer/FishMaps/blob/master/downloads/FishMaps_0.3-0.zip?raw=true)

> NOTE: do not unzip it under Windows.

## Documentation

The reference manual in PDF can be found here:
[FishMaps.pdf](https://github.com/fernandomayer/FishMaps/raw/master/downloads/FishMaps-manual.pdf)

## License

This package is released under the
[GNU General Public License (GPL) v. 3.0]
(http://www.gnu.org/licenses/gpl-3.0.html)

[lattice]: http://cran-r.c3sl.ufpr.br/web/packages/lattice/index.html
[maps]: http://cran-r.c3sl.ufpr.br/web/packages/maps/index.html
[mapdata]: http://cran-r.c3sl.ufpr.br/web/packages/mapdata/index.html
