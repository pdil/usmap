pkgname <- "cpsvote"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('cpsvote')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("cps_download_data")
### * cps_download_data

flush(stderr()); flush(stdout())

### Name: cps_download_data
### Title: Download CPS microdata
### Aliases: cps_download_data

### ** Examples

## Not run: 
##D cps_download_data(path = "cps_docs", years = 2016, overwrite = TRUE)
## End(Not run)




cleanEx()
nameEx("cps_download_docs")
### * cps_download_docs

flush(stderr()); flush(stdout())

### Name: cps_download_docs
### Title: Download CPS technical documentation
### Aliases: cps_download_docs

### ** Examples

## Not run: 
##D cps_download_docs(path = "cps_docs", years = 2016, overwrite = TRUE)
## End(Not run)




cleanEx()
nameEx("cps_label")
### * cps_label

flush(stderr()); flush(stdout())

### Name: cps_label
### Title: Apply factor levels to raw CPS data
### Aliases: cps_label

### ** Examples

cps_label(cps_2016_10k)




cleanEx()
nameEx("cps_load_basic")
### * cps_load_basic

flush(stderr()); flush(stdout())

### Name: cps_load_basic
### Title: load some basic/default CPS data into the environment
### Aliases: cps_load_basic

### ** Examples

## Not run: cps_load-basic(years = 2016, outdir = "data")




cleanEx()
nameEx("cps_read")
### * cps_read

flush(stderr()); flush(stdout())

### Name: cps_read
### Title: Read in CPS data
### Aliases: cps_read

### ** Examples

## Not run: cps_read(years = 2016, names_col = "new_name")




cleanEx()
nameEx("cps_recode_vote")
### * cps_recode_vote

flush(stderr()); flush(stdout())

### Name: cps_recode_vote
### Title: recode the voting variable for turnout calculations
### Aliases: cps_recode_vote

### ** Examples

cps_recode_vote(cps_refactor(cps_label(cps_2016_10k)))




cleanEx()
nameEx("cps_refactor")
### * cps_refactor

flush(stderr()); flush(stdout())

### Name: cps_refactor
### Title: combine factor levels across years
### Aliases: cps_refactor

### ** Examples

cps_refactor(cps_label(cps_2016_10k))




cleanEx()
nameEx("cps_reweight_turnout")
### * cps_reweight_turnout

flush(stderr()); flush(stdout())

### Name: cps_reweight_turnout
### Title: apply weight correction for voter turnout
### Aliases: cps_reweight_turnout

### ** Examples

cps_reweight_turnout(cps_recode_vote(cps_refactor(cps_label(cps_2016_10k))))




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
