.onAttach <- function(libname, pkgname) {
  
  version <- read.dcf(file = system.file("DESCRIPTION",
                                         package = pkgname),
                      fields = "Version")
  
  startup_msg <- function() {
    packageStartupMessage("This is ", pkgname, " ", version)
    packageStartupMessage("Please report any issues or ideas at:")
    packageStartupMessage("https://github.com/milanwiedemann/lcsm/issues")
  }
  
  packageStartupMessage(startup_msg())
}
