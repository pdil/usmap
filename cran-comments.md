## Resubmission
This is a resubmission. In this version I have:

* Fixed resoures/examples.R URI in README.

## Test environments
* local OS X install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note 

* `extdata` contains the state and county map data frames
which are vital to the function of this package. The data
is unlikely to change often (at most once per year). 
Here is the ```R CMD check``` output:
```
❯ checking installed package size ... NOTE
    installed size is  8.3Mb
    sub-directories of 1Mb or more:
      doc       1.6Mb
      extdata   6.4Mb
```

## Downstream dependencies

I have also run R CMD check on downstream dependencies of usmap:

* refuge
