release_checklist <- function(email, token, version) {
    # Platform checks
    rhub::validate_email(email, token)
    devtools::check_rhub(email = email, interactive = FALSE)

    devtools::check_win_devel()

    # Reverse dependency checks
    revdepcheck::revdep_reset()
    revdepcheck::revdep_check()

    # Version number updates
    desc::desc_set_version(version)
}
