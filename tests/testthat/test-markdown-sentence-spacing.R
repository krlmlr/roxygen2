test_that("a line break after a sentence keeps the sentence gap", {
  expect_equal(markdown("Alpha ends here.\nBeta starts here."), "Alpha ends here.\n Beta starts here.")
  expect_equal(markdown("Really?\nYes."), "Really?\n Yes.")
  expect_equal(markdown("Wow!\nIndeed."), "Wow!\n Indeed.")
})

test_that("a line break inside a sentence is left alone", {
  expect_equal(markdown("A clause,\nand another."), "A clause,\nand another.")
  expect_equal(markdown("No punctuation\nat all."), "No punctuation\nat all.")
  expect_equal(markdown("A colon:\nnext."), "A colon:\nnext.")
})

test_that("closing quotes and brackets still count as the end of a sentence", {
  expect_equal(markdown("(An aside.)\nNext."), "(An aside.)\n Next.")
  expect_equal(markdown("He said \"go.\"\nNext."), "He said \"go.\"\n Next.")
})

test_that("the gap reaches the rendered help, in every markdown field", {
  out <- roc_proc_text(
    rd_roclet(),
    "
    #' Title
    #'
    #' Alpha ends here.
    #' Beta starts here.
    #'
    #' @details Det ends here.
    #' DetNext here.
    #' @return Ret ends here.
    #' RetNext here.
    #' @param x Par ends here.
    #' ParNext here.
    #' @md
    foo <- function(x) {}"
  )[[1]]

  path <- withr::local_tempfile(fileext = ".Rd")
  write_lines(format(out), path)
  rendered <- paste(
    capture.output(tools::Rd2txt(path, options = list(width = 10000))),
    collapse = "\n"
  )

  expect_match(rendered, "Alpha ends here.  Beta starts here.", fixed = TRUE)
  expect_match(rendered, "Det ends here.  DetNext here.", fixed = TRUE)
  expect_match(rendered, "Ret ends here.  RetNext here.", fixed = TRUE)
  expect_match(rendered, "Par ends here.  ParNext here.", fixed = TRUE)
})

test_that("a link never gains a line break", {
  # `mdxml_break()` already collapses breaks inside a link, because Rd links
  # cannot span lines. The sentence gap must not reintroduce one.
  expect_equal(
    markdown("See [this\nlink][fcn]. Next."),
    "See \\link[=fcn]{this link}. Next."
  )
})

test_that("an abbreviation is not the end of a sentence", {
  expect_equal(markdown("See e.g.\nThe manual."), "See e.g.\nThe manual.")
  expect_equal(markdown("Loading C code, etc.)\nbut note that."), "Loading C code, etc.)\nbut note that.")
  expect_equal(markdown("Smith et al.\nreport otherwise."), "Smith et al.\nreport otherwise.")
})

test_that("a lowercase word after the break means the sentence carries on", {
  expect_equal(markdown("ends with a period.\nbut carries on."), "ends with a period.\nbut carries on.")
})
