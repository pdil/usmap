## Resubmission
This is a resubmission. In this version I have:

* Fixed invalid URLs.

## Test environments
* local macOS install, R 4.0.2

#### On Github Actions
* macOS-latest (release), R 4.0.2
* windows-latest (release), R 4.0.2
* ubuntu-16.04 (oldrel, devel, release), R 4.0.2

## R CMD check results

0 errors | 0 warnings | 2 notes

* `extdata` contains the state and county map data frames
which are vital to the function of this package. The data
is unlikely to change often (at most once per year). 
Here is the ```R CMD check``` output:
```
> checking installed package size ... NOTE
    installed size is  8.4Mb
    sub-directories of 1Mb or more:
      doc       1.6Mb
      extdata   6.4Mb
```

* The following variables are not global but contained within
the data that is used with `ggplot2`. `plot_usmap` has extensive
unit tests to ensure these variables are not undefined.
```
> checking R code for possible problems ... NOTE
  plot_usmap: no visible binding for global variable ‘x’
  plot_usmap: no visible binding for global variable ‘y’
  plot_usmap: no visible binding for global variable ‘group’
  plot_usmap: no visible binding for global variable ‘county’
  plot_usmap: no visible binding for global variable ‘abbr’
  Undefined global functions or variables:
    abbr county group x y
```

## Downstream dependencies

I have also run R CMD check on downstream dependencies of usmap:

* refuge
