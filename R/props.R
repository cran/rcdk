set.property <- function(molecule, key, value) {
  if (!is.character(key)) {
    stop("The property key must be a character")
  }
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }

  if (is.character(value)) {
    value <- .jcall('org/guha/rcdk/util/Misc', 'V', 'setProperty',
           molecule, as.character(key),
           .jcast( .jnew("java/lang/String", value), "java/lang/Object"))
  } else if (is.integer(value)) {
     value <-.jcall('org/guha/rcdk/util/Misc', 'V', 'setProperty',
           molecule, as.character(key), as.integer(value))
  } else if (is.double(value)) {
     value <-.jcall('org/guha/rcdk/util/Misc', 'V', 'setProperty',
           molecule, as.character(key), as.double(value))
  } else if (class(value) == 'jobjRef') {
     value <-.jcall('org/guha/rcdk/util/Misc', 'V', 'setProperty',
           molecule, as.character(key),
           .jcast(value, 'java/lang/Object'))
  }
  
}

get.property <- function(molecule, key) {
  if (!is.character(key)) {
    stop("The property key must be a character")
  }
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }

  value <- .jcall('org/guha/rcdk/util/Misc', 'Ljava/lang/Object;', 'getProperty',
                  molecule, as.character(key))
  if (is.jnull(value)) return(NA)
  else return(.jsimplify(value))
}
remove.property <- function(molecule, key) {
  if (!is.character(key)) {
    stop("The property key must be a character")
  }
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("Must supply an IAtomContainer object")
  }

  if (is.na(get.property(molecule, key))) {
    warning("No such key exists")
  } else {
    value <- .jcall('org/guha/rcdk/util/Misc', 'V', 'removeProperty',
                    molecule, as.character(key))
  }
}

