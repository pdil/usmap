# workaround for testing in Travis CI
# https://github.com/hadley/testthat/issues/144
Sys.setenv("R_TESTS" = "")

library(testthat)
library(usmap)

test_check("usmap")
