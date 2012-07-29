# FishMaps 0.2-0

Proportional symbol mapping for fishery data in batch mode.

## Introduction

FishMaps was designed to plot fishery data (catch, effort, CPUE) into
maps. It uses the standard `grid` graphics engine with the `maps`, `mapdata` and `sp` packages to produce [proportional symbol mapping] (http://en.wikipedia.org/wiki/Thematic_map#Proportional_symbol).

Producing this kind of maps in `R` with the above packages is really straightforward, but the difference is that FishMaps can produce lots of maps (*e.g.* from a long time series) with one command (batch mode) and store/display this maps in a convenient way. For example, it includes identification (year, quarter) in each map and saves them in some types of file formats suitable for including in documents (*e.g* LaTeX, doc).

Although FishMaps was designed for fishery data, any kind of georeferenced data can be used. There is a [vignette](https://github.com/fernandomayer/FishMaps/blob/master/inst/doc/FishMaps_paper.pdf?raw=true) available with more details and examples on how to use it.

> NOTE: this software was an experimental `R` package, so internal code is far away from elegant and much more far away from efficient. Anyway, it still can be usefull for simple maps. A new package, FishMaps2, is under development and should be released soon. It promisses many new features (such as bathymetric lines) and more consistency, since it is based on `lattice`. While it is not released, if you have suggestions or experience difficulties with FishMaps, please contact me.

## Download

* Source package for Linux/Mac: [FishMaps_0.2-0.tar.gz] (https://github.com/fernandomayer/FishMaps/blob/master/downloads/FishMaps_0.2-0.tar.gz?raw=true)
* Windows binary: [FishMaps_0.2-0.zip] (https://github.com/fernandomayer/FishMaps/blob/master/downloads/FishMaps_0.2-0.zip?raw=true)

> NOTE: do not unzip it under Windows.

## Installation

### Linux/Mac

Installing from the source code (`tar.gz`) on Linux/Mac (make sure you are on the container file directory):

```
$ R CMD INSTALL -l /path/to/your/R/library FishMaps_0.2-0.tar.gz
```

In this case, make sure you have installed the packages: `maps`, `mapdata`, and `sp`. Or, inside an `R` session:

```R
> install.packages("FishMaps_0.2-0.tar.gz", repos = NULL,
	dependencies = TRUE, lib.loc = "/path/to/your/R/library")
```

Note that `-l /path/to/your/R/library` in the former and `lib.loc = "/path/to/your/R/library` in the latter are optional. Only use it if you want to install in a personal library, other than the standard `R` library.

### Windows

From the binary (`zip`) (**do not unzip it**): put the file in your working directory, and from inside `R`

```R
> install.packages("FishMaps_0.2-0.zip", repos = NULL, dependencies = TRUE)
```

### Platform independent

In any platform you can install FishMaps from this GitHub repository using the `install_github()` function from package `devtools`:

```R
> require(devtools)
> install_github("FishMaps", username = "fernandomayer")
```

## Documentation

* Reference manual: [FishMaps.pdf] (https://github.com/fernandomayer/FishMaps/blob/master/downloads/FishMaps.pdf?raw=true)
* Vignette: [FishMaps_paper.pdf] (https://github.com/fernandomayer/FishMaps/blob/master/inst/doc/FishMaps_paper.pdf?raw=true)

## License

This package is released under the [GNU General Public License (GPL) v. 3.0] (http://www.gnu.org/licenses/gpl-3.0.html)