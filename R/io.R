.packageName <- "rcdk"

write.molecules <- function(mols, filename, together=TRUE, write.props=FALSE) {
  if (together) {
    value <-.jcall('org/guha/rcdk/util/Misc', 'V', 'writeMoleculesInOneFile',
           .jarray(mols,
                   contents.class = "org/openscience/cdk/interfaces/IAtomContainer"),
           as.character(filename), as.integer(ifelse(write.props,1,0)))
  } else {
    value <- .jcall('org/guha/rcdk/util/Misc', 'V', 'writeMolecules',
           .jarray(mols,
                   contents.class = "org/openscience/cdk/interfaces/IAtomContainer"),
           as.character(filename), as.integer(ifelse(write.props,1,0)))
  }
}

## molfiles should be a vector of strings. Returns a list of
## IAtomContainer objects
load.molecules <- function(molfiles=NA) {
  if (any(is.na(molfiles))) {
    stop("Must supply a vector of file names")
  }
  if (length(molfiles) == 0) {
    stop("Must supply a vector of file names")
  }

  farr <- .jarray(molfiles, contents.class = 'S')
  molecules <- .jcall('org/guha/rcdk/util/Misc', '[Lorg/openscience/cdk/interfaces/IAtomContainer;',
                      'loadMolecules', farr)
  if (is.jnull(molecules)) {
    return(NA)
  } else {
    return(molecules)
  }
}

