.packageName <- "rcdk"

#
# Rajarshi Guha <rguha@indiana.edu>
# 04/01/08
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
        Sys.setenv("DYLD_LIBRARY_PATH"=sub("/usr/X11R6/lib","",dlp))
    }

    jar.rcdk <- paste(lib,pkg,"cont","rcdk.jar",sep=.Platform$file.sep)
    jar.cdk <- paste(lib,pkg,"cont","cdk.jar",sep=.Platform$file.sep)
    ##jar.jmol <- paste(lib,pkg,"cont","Jmol.jar",sep=.Platform$file.sep)
    ##jar.jcp <- paste(lib,pkg,"cont","cdk-jchempaint.jar",sep=.Platform$file.sep)        
    .jinit(classpath=c(jar.cdk, jar.rcdk))
}
    


remove.hydrogens <- function(molecule) {
  if (is.null(attr(molecule, 'jclass')) ||
      attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  newmol <- .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
                   'Lorg/openscience/cdk/interfaces/IAtomContainer;',
                   'removeHydrogens',
                   molecule);
  newmol
}

get.total.hydrogen.count <- function(molecule) {
  if (is.null(attr(molecule, 'jclass')) ||
      attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
         'I',
         'getTotalHydrogenCount',
         molecule);
}

get.exact.mass <- function(molecule) {
    if (is.null(attr(molecule, 'jclass')) ||
        attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
         'D',
         'getTotalExactMass',
         molecule);
}

get.total.charge <- function(molecule) {
  if (is.null(attr(molecule, 'jclass')) ||
      attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator',
         'D',
         'getTotalCharge',
         molecule);
}

convert.implicit.to.explicit <- function(molecule) {
  if (is.null(attr(molecule, 'jclass')) ||
      attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }
  .jcall('org/openscience/cdk/tools/manipulator/AtomContainerManipulator', 'V', 'convertImplicitToExplicitHydrogens', molecule)
}


get.fingerprint <- function(molecule, depth=6, size=1024) {
  if (is.null(attr(molecule, 'jclass')) ||
      attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }

  mode(size) <- 'integer'
  mode(depth) <- 'integer'
  
  fingerprinter <- .jnew('org/openscience/cdk/fingerprint/Fingerprinter', size, depth)
  bitset <- .jcall(fingerprinter, "Ljava/util/BitSet;", "getFingerprint", molecule)
  bitset <- .jcall(bitset, "S", "toString")
  s <- gsub('[{}]','', bitset)
  s <- strsplit(s, split=',')[[1]]
  moltitle <- get.property(molecule, 'Title')
  if (is.na(moltitle)) moltitle <- ''
  return(new("fingerprint", nbit=size, bits=as.numeric(s), provider="CDK", name=moltitle))
}

get.atoms <- function(object) {
  if (is.null(attr(object, 'jclass')))
    stop("object must be of class IAtomContainer or IObject or IBond")
  
  if (attr(object, 'jclass') != "org/openscience/cdk/interfaces/IAtomContainer" &&
      attr(object, 'jclass') != "org/openscience/cdk/interfaces/IObject" &&
      attr(object, 'jclass') != "org/openscience/cdk/interfaces/IBond")
    stop("object must be of class IAtomContainer or IObject or IBond")

  natom <- .jcall(object, "I", "getAtomCount")
  atoms <- list()
  for (i in 0:(natom-1))
    atoms[[i+1]] <- .jcall(object, "Lorg/openscience/cdk/interfaces/IAtom;", "getAtom", as.integer(i))
  atoms
}

get.bonds <- function(molecule) {
  if (is.null(attr(molecule, 'jclass')))
    stop("molecule must be of class IAtomContainer or IMolecule")
  if (attr(molecule, 'jclass') != "org/openscience/cdk/interfaces/IAtomContainer" &&
      attr(molecule, 'jclass') != "org/openscience/cdk/interfaces/IMolecule")
    stop("molecule must be of class IAtomContainer or IMolecule")

  nbond <- .jcall(molecule, "I", "getBondCount")
  bonds <- list()
  for (i in 0:(nbond-1))
    bonds[[i+1]] <- .jcall(molecule, "Lorg/openscience/cdk/interfaces/IBond;", "getBond", as.integer(i))
  bonds
}


