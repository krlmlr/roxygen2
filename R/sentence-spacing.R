# commonmark discards the whitespace a line break stands for, so a break that
# follows the end of a sentence would render as a single space even where the
# author separated the two sentences with two. `Rd2txt()` renders a line break
# followed by whitespace as two spaces after `.`, `?` and `!` -- and as one
# space everywhere else -- so emitting the indent restores the gap exactly
# where it is meant to be, and changes nothing anywhere else.
#
# Breaks are the elements `mdxml_break()` produced, which are the only ones
# equal to a bare newline.
mdxml_keep_sentence_spacing <- function(out) {
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
  abbreviations <- c("e.g", "i.e", "cf", "vs", "etc", "al", "resp", "approx",
                     "viz", "Dr", "Mr", "Mrs", "Ms", "Prof", "St", "Fig", "No")
  abbrev_re <- paste0(
    "(?<![[:alnum:]])(", paste(gsub(".", "[.]", abbreviations, fixed = TRUE), collapse = "|"),
    ")[.]", closers, "$"
  )
  ends_sentence <- ends_sentence & !grepl(abbrev_re, before, perl = TRUE)

  # The next line has to look like the start of a sentence. A lowercase word
  # after the break means the sentence carries on, whatever the punctuation
  # before it suggested.
  after <- ifelse(breaks < length(out), out[pmin(breaks + 1L, length(out))], "")
  ends_sentence <- ends_sentence & !grepl("^[[:lower:]]", after, perl = TRUE)

  out[breaks[ends_sentence]] <- "\n "
  out
}
