
This is a re-submission for version 0.6.3 which fixes the following issue:

Found the following (possibly) invalid URLs:
URL: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
From: man/plot_usmap.Rd
Status: 404
Message: Not Found


## Test environments
* local macOS install, R 4.3.0

#### On Github Actions
* macOS-latest (release), R 4.3.0
* windows-latest (release), R 4.3.0
* ubuntu-22.04 (oldrel, devel, release), R 4.2.3

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

I have also run R CMD check on downstream dependencies of usmap:

* cpsvote
* ecocomDP
* PracTools
