.onLoad <- function(libname, pkgname) {
  .jinit(parameters="-Xmx4g")
    
  .jpackage(pkgname, lib.loc=libname)  
      
  .jaddClassPath(system.file("jri",c("REngine.jar","JRIEngine.jar"),package="rJava"))    
  .jengine(TRUE) # we have to start the JRI before doing anything
}