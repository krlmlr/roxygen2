# commonmark discards the whitespace a line break stands for, so a break that
# follows the end of a sentence would render as a single space even where the
# author separated the two sentences with two. `Rd2txt()` renders a line break
# followed by whitespace as two spaces after `.`, `?` and `!` -- and as one
# space everywhere else -- so emitting the indent restores the gap exactly
# where it is meant to be, and changes nothing anywhere else.
#
# Breaks are the elements `mdxml_break()` produced, which are the only ones
# equal to a bare newline.
mdxml_keep_sentence_spacing <- function(out, state) {
  breaks <- which(out == "\n")
  breaks <- breaks[breaks > 1L]
  if (length(breaks) == 0L) {
    return(out)
  }

  # Closing quotes and brackets may sit between the punctuation and the break.
  # `perl = TRUE` because a POSIX bracket expression cannot escape `]`.
  closers <- "[)\\]\"\'`\u2019\u201d]*"
  before <- out[breaks - 1L]
  ends_sentence <- grepl(paste0("[.?!]", closers, "$"), before, perl = TRUE)

  # A period that ends a common abbreviation does not end a sentence. Be
  # conservative: the cost of missing a gap is invisible, the cost of inserting
  # one mid-sentence is a visible change to the rendered help.
  abbreviations <- c(
    "e.g",
    "i.e",
    "cf",
    "vs",
    "etc",
    "al",
    "resp",
    "approx",
    "viz",
    "Dr",
    "Mr",
    "Mrs",
    "Ms",
    "Prof",
    "St",
    "Fig",
    "No"
  )
  abbrev_re <- paste0(
    "(?<![[:alnum:]])(",
    paste(gsub(".", "[.]", abbreviations, fixed = TRUE), collapse = "|"),
    ")[.]",
    closers,
    "$"
  )
  ends_sentence <- ends_sentence & !grepl(abbrev_re, before, perl = TRUE)

  # A single letter followed by a period is an initial, not the end of a
  # sentence: `M.E.J.` before `Newman`, or `Kratzer, S.` before `G., Harley`.
  # Author initials sit in `@references` far more often than a sentence ends in
  # a single capital, and a gap inserted mid-name is visible where a missing one
  # is not, so the initial wins.
  initials_re <- paste0("(?<![[:alnum:]])[[:alpha:]][.]", closers, "$")
  ends_sentence <- ends_sentence & !grepl(initials_re, before, perl = TRUE)

  # The next line has to look like the start of a sentence. A lowercase word
  # after the break means the sentence carries on, whatever the punctuation
  # before it suggested.
  after <- ifelse(breaks < length(out), out[pmin(breaks + 1L, length(out))], "")
  after <- drop_rd_tag_placeholder(after, state$subst_id)
  ends_sentence <- ends_sentence & !grepl("^[[:lower:]]", after, perl = TRUE)

  out[breaks[ends_sentence]] <- "\n "
  out
}

# A fragile Rd tag has been swapped out for `<id>-<n>-` by `protect_rd_tags()`
# at this point, and that id is a fresh random string on every call. Left in
# place it would decide the test above by the case of its first character, so a
# break before `\doi{}` or `\url{}` would gain or lose its gap at random from
# one run to the next. Strip the placeholder instead: what remains still starts
# with the space that separated the tag from the text after it, so a tag is
# never mistaken for a lowercase word, and a line that begins with a tag is
# treated as beginning a sentence.
drop_rd_tag_placeholder <- function(x, id) {
  if (is.null(id)) {
    return(x)
  }
  sub(paste0("^(\\Q", id, "\\E-[0-9]+-)+"), "", x, perl = TRUE)
}
