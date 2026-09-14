test_that("can regenerate NAMESPACE even if its broken", {
  path <- local_package_copy(test_path("broken-namespace"))
  expect_snapshot(roxygenise(path))
})

test_that("roxygenise() leaves the search path as it found it", {
  path <- local_package_copy(test_path("testRbuildignore"))
  # test-load.R attaches it by calling load_pkgload() directly
  if ("package:testRbuildignore" %in% search()) {
    detach("package:testRbuildignore")
  }
  # roxygenise() records the package in a global option, which would otherwise
  # leak a now-deleted path into later test files
  withr::defer(roxy_meta_clear())

  # The package has to be attached while roxygen2 runs, because an Rmd included
  # with @includeRmd is rendered in the global environment
  attached <- NULL
  load_code <- function(path) {
    env <- load_pkgload(path)
    attached <<- "package:testRbuildignore" %in% search()
    env
  }

  before <- search()
  suppressMessages(roxygenise(path, load_code = load_code))

  expect_true(attached)
  expect_false("package:testRbuildignore" %in% search())
  expect_equal(search(), before)
})
