.packageName <- "rcdk"

#
# Rajarshi Guha <rajarshi@presidency.com>
# 02/20/06
#
# Update 08/28/06 - moved to rJava
# Update 08/29/06 - added a method to remove hydrogens
# Update 09/16/06 - added methods to write molecules, get/set properties
#
# .First.lib code taken from iPlots

require(rJava, quietly=TRUE)

.trim.whitespace <- function(x) {
  x <- gsub('^[[:space:]]+', '', x)
  gsub('[[:space:]]+$', '',x)
}

.First.lib <- function(lib, pkg) {
    dlp<-Sys.getenv("DYLD_LIBRARY_PATH")
    if (dlp!="") { # for Mac OS X we need to remove X11 from lib-path
        Sys.putenv("DYLD_LIBRARY_PATH"=sub("/usr/X11R6/lib","",dlp))
    }

    jar.rcdk <- paste(lib,pkg,"cont","rcdk.jar",sep=.Platform$file.sep)
    jar.cdk <- paste(lib,pkg,"cont","cdk-svn-20061122.jar",sep=.Platform$file.sep)
    jar.jmol <- paste(lib,pkg,"cont","Jmol.jar",sep=.Platform$file.sep)
    jar.jcp <- paste(lib,pkg,"cont","cdk-jchempaint.jar",sep=.Platform$file.sep)        
    .jinit(classpath=c(jar.jmol, jar.cdk, jar.jcp, jar.rcdk))
}
    


remove.hydrogens <- function(molecule) {
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  newmol <- .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
                   'Lorg/openscience/cdk/interfaces/IAtomContainer;',
                   'removeHydrogens',
                   molecule);
  newmol
}

get.total.hydrogen.count <- function(molecule) {
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
         'I',
         'getTotalHydrogenCount',
         molecule);
}

get.total.charge <- function(molecule) {
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
         'D',
         'getTotalCharge',
         molecule);
}  


get.fingerprint <- function(molecule, depth=6, size=1024) {
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }

  mode(size) <- 'integer'
  mode(depth) <- 'integer'
  
  fingerprinter <- .jnew('org/openscience/cdk/fingerprint/Fingerprinter', size, depth)
  bitset <- .jcall(fingerprinter, "Ljava/util/BitSet;", "getFingerprint", molecule)
  bitset <- .jcall(bitset, "S", "toString")
  s <- gsub('[{}]','', bitset)
  s <- strsplit(s, split=',')[[1]]
  return(new("fingerprint", nbit=size, bits=as.numeric(s), provider="CDK"))
}



