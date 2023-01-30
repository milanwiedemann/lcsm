.onAttach <- function(libname, pkgname) {
  
  version <- read.dcf(file = system.file("DESCRIPTION",
                                         package = pkgname),
                      fields = "Version")
  
  cli::cli_h1(paste0("This is ", pkgname, " ", version))
  cli::cli_alert_info(paste0("Please report any issues or ideas at:"))
  cli::cli_alert_info("https://github.com/milanwiedemann/lcsm/issues/")
}
