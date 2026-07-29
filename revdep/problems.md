# checkhelper (1.0.0)

* GitHub: <https://github.com/ThinkR-open/checkhelper>
* Email: <mailto:vincent@thinkr.fr>
* GitHub mirror: <https://github.com/cran/checkhelper>

Run `revdepcheck::cloud_details(, "checkhelper")` for more info

## Newly broken

*   checking tests ... ERROR
     ```
     ...
       ══ Skipped tests (5) ═══════════════════════════════════════════════════════════
       • On CRAN (5): 'test-audit-globals.R:8:3', 'test-audit-globals.R:22:3',
         'test-audit-userspace.R:7:3', 'test-fix-globals.R:9:3',
         'test-fix-globals.R:25:3'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Error ('test-find_missing_values.R:79:5'): find_missing_tags works ──────────
       <usethis_error/rlang_error/error/condition>
       Error in `check_uses_roxygen("use_pipe()")`: ✖ Package checkpackage does not use roxygen2.
       ℹ `use_pipe()` can not work without it.
       ℹ You might just need to run `devtools::document()` once, then try again.
       Backtrace:
           ▆
        1. ├─usethis::with_project(...) at test-find_missing_values.R:77:3
        2. │ └─base::force(code)
        3. └─usethis::use_pipe() at test-find_missing_values.R:79:5
        4.   └─usethis:::check_uses_roxygen("use_pipe()")
        5.     └─usethis:::ui_abort(...)
        6.       └─cli::cli_abort(...)
        7.         └─rlang::abort(...)
       
       [ FAIL 1 | WARN 0 | SKIP 5 | PASS 558 ]
       Error:
       ! Test failures.
       Execution halted
     ```

*   checking tests ... ERROR
     ```
     ...
       ══ Skipped tests (5) ═══════════════════════════════════════════════════════════
       • On CRAN (5): 'test-audit-globals.R:8:3', 'test-audit-globals.R:22:3',
         'test-audit-userspace.R:7:3', 'test-fix-globals.R:9:3',
         'test-fix-globals.R:25:3'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Error ('test-find_missing_values.R:79:5'): find_missing_tags works ──────────
       <usethis_error/rlang_error/error/condition>
       Error in `check_uses_roxygen("use_pipe()")`: ✖ Package checkpackage does not use roxygen2.
       ℹ `use_pipe()` can not work without it.
       ℹ You might just need to run `devtools::document()` once, then try again.
       Backtrace:
           ▆
        1. ├─usethis::with_project(...) at test-find_missing_values.R:77:3
        2. │ └─base::force(code)
        3. └─usethis::use_pipe() at test-find_missing_values.R:79:5
        4.   └─usethis:::check_uses_roxygen("use_pipe()")
        5.     └─usethis:::ui_abort(...)
        6.       └─cli::cli_abort(...)
        7.         └─rlang::abort(...)
       
       [ FAIL 1 | WARN 0 | SKIP 5 | PASS 558 ]
       Error:
       ! Test failures.
       Execution halted
     ```

*   checking tests ... ERROR
     ```
     ...
       ══ Skipped tests (5) ═══════════════════════════════════════════════════════════
       • On CRAN (5): 'test-audit-globals.R:8:3', 'test-audit-globals.R:22:3',
         'test-audit-userspace.R:7:3', 'test-fix-globals.R:9:3',
         'test-fix-globals.R:25:3'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Error ('test-find_missing_values.R:79:5'): find_missing_tags works ──────────
       <usethis_error/rlang_error/error/condition>
       Error in `check_uses_roxygen("use_pipe()")`: ✖ Package checkpackage does not use roxygen2.
       ℹ `use_pipe()` can not work without it.
       ℹ You might just need to run `devtools::document()` once, then try again.
       Backtrace:
           ▆
        1. ├─usethis::with_project(...) at test-find_missing_values.R:77:3
        2. │ └─base::force(code)
        3. └─usethis::use_pipe() at test-find_missing_values.R:79:5
        4.   └─usethis:::check_uses_roxygen("use_pipe()")
        5.     └─usethis:::ui_abort(...)
        6.       └─cli::cli_abort(...)
        7.         └─rlang::abort(...)
       
       [ FAIL 1 | WARN 0 | SKIP 5 | PASS 558 ]
       Error:
       ! Test failures.
       Execution halted
     ```

# REDCapExporter (0.3.5)

* GitHub: <https://github.com/dewittpe/REDCapExporter>
* Email: <mailto:peter.dewitt@cuanschutz.edu>
* GitHub mirror: <https://github.com/cran/REDCapExporter>

Run `revdepcheck::cloud_details(, "REDCapExporter")` for more info

## Newly broken

*   checking tests ... ERROR
     ```
     ...
       +   {
       +     build_r_data_package(
       +       x            = avs_raw_core,
       +       path         = temppath,
       +       author_roles = list(dewittp = c("cre", "aut"))
       +     )
       +   },
       +   message = function(m) {
       +     msgs <<- c(msgs, conditionMessage(m))
       +     invokeRestart("muffleMessage")
       +   }
       + )
       > 
       > pkgdir <- file.path(temppath, "rcd14465")
       > 
       > # check the DESCRIPTION file for the built package
       > d <- read.dcf(file.path(pkgdir, "DESCRIPTION"))
       > stopifnot(
       +   d[1, "Package"] == "rcd14465",
       +   grepl("\\d{4}\\.\\d{2}\\.\\d{2}\\.\\d{2}\\.\\d{2}", d[1, "Version"]),
       +   all(c("knitr", "roxygen2") %in% trimws(strsplit(d[1, "Suggests"], ",")[[1]])),
       +   d[1, "Config/roxygen2/version"] == "8.0.0"
       + )
       Error: d[1, "Config/roxygen2/version"] == "8.0.0" is not TRUE
       Execution halted
     ```

