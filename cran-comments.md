
## Test environments
* local macOS install, R 4.0.3

#### On Github Actions
* macOS-latest (release), R 4.0.3
* windows-latest (release), R 4.0.3
* ubuntu-16.04 (oldrel, devel, release), R 4.0.3

## R CMD check results

0 errors | 0 warnings | 1 notes

* `extdata` contains the state and county map data frames
which are vital to the function of this package. The data
is unlikely to change often (at most once per year). 
Here is the ```R CMD check``` output:
```
> checking installed package size ...
     installed size is  8.4Mb
     sub-directories of 1Mb or more:
       doc       1.6Mb
       extdata   6.4Mb
```

## Downstream dependencies

I have also run R CMD check on downstream dependencies of usmap:

* refuge
