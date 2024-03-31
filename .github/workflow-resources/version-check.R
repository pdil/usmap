verify_version <- function(new_version) {
    current_version <- desc::desc_get_version()
    if (utils::compareVersion(new_version, current_version) != 1) {
        Sys.setenv(INVALID_VERSION = "true")
    }
}
