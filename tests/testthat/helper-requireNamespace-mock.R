
# Mocks `requireNamespace` to return `FALSE` for
# provided dependency package "pkg" to test that
# error occurs when it's not installed.
expect_package_error <- function(pkg, code, msg) {
  with_mocked_bindings({
    expect_error(code, paste0("`", pkg, "` must be installed"))
  },
  requireNamespace = function(package, ...) package != pkg,
  .package = "base"
  )
}
