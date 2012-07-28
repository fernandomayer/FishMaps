# FishMaps 0.2-0

Proportional symbol mapping for fishery data in batch mode.

## Introduction

FishMaps was designed to plot fishery data (catch, effort, CPUE) into
maps. It uses the standard `grid` graphics engine with the `maps`, `mapdata` and `sp` packages to produce [proportional symbol mapping] (http://en.wikipedia.org/wiki/Thematic_map#Proportional_symbol).

Producing this kind of maps in `R` with the above packages is really straightforward, but the difference is that FishMaps can produce lots of maps (*e.g.* from a long time series) with one command (batch mode) and store/display this maps in a convenient way. For example, it includes identification (year, quarter) in each map and saves them in some types of file formats suitable for including in documents (*e.g* LaTeX, doc).

Although FishMaps was designed for fishery data, any kind of georeferenced data can be used. There is a [vignette](https://github.com/fernandomayer/FishMaps/blob/master/inst/doc/FishMaps_paper.pdf) available with more details and exemples on how to use it.

> NOTE: this software was an experimental `R` package, so internal code is far away from elegant and much more far away from efficient. Anyway, it still can be usefull for simple maps. A new package, FishMaps2, is under development and should be released soon. It promisses many new features (such as bathymetric lines) and more consistency, since it is based on `lattice`. While it is not released, if you have suggestions or experience difficulties with FishMaps, please contact me.


# Installation

Download the source code and install via the command line

```
$ R CMD INSTALL -l /path/to/your/R/library FishMaps<version>.tar.gz
```

or inside an `R` session

```R
> install.packages("FishMaps<version>.tar.gz", repos = NULL, lib.loc = "/path/to/your/R/library")
```
