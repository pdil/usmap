pkgname <- "refuge"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('refuge')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("rfg_all_restrooms")
### * rfg_all_restrooms

flush(stderr()); flush(stdout())

### Name: rfg_all_restrooms
### Title: All refuge restrooms
### Aliases: rfg_all_restrooms

### ** Examples





cleanEx()
nameEx("rfg_date")
### * rfg_date

flush(stderr()); flush(stdout())

### Name: rfg_date
### Title: Bathrooms by dates
### Aliases: rfg_date

### ** Examples





cleanEx()
nameEx("rfg_location")
### * rfg_location

flush(stderr()); flush(stdout())

### Name: rfg_location
### Title: Bathroom locations
### Aliases: rfg_location

### ** Examples





cleanEx()
nameEx("rfg_search")
### * rfg_search

flush(stderr()); flush(stdout())

### Name: rfg_search
### Title: Restroom record search
### Aliases: rfg_search

### ** Examples





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
