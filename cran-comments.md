## Test environments
* local OS X install, R 3.4.0
* ubuntu 12.04 (on travis-ci), R 3.4.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note 

* `extdata` contains the state and county map data frames
which are vital to the function of this package. The data
is unlikely to change often (at most once per year). 
Here is the ```R CMD check``` output:
```
checking installed package size ... NOTE
  installed size is  7.0Mb
  sub-directories of 1Mb or more:
    extdata   6.2Mb
```

## Reverse dependencies

There are no reverse dependencies.