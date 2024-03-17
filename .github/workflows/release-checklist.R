release_checklist <- function(version) {
    # Platform checks
    devtools::check_rhub(interactive = FALSE)
    devtools::check_win_devel()

    # Reverse dependency checks
    revdepcheck::revdep_reset()
    revdepcheck::revdep_check()

    # Version number updates
    desc::desc_set_version(version)
}
