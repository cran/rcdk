## An example of getting all the coordinates for a molecule
## atoms <- get.atoms(mol)
## coords <- do.call('rbind', lapply(apply, get.point3d))
get.point3d <- function(atom) {
  if (is.null(attr(atom, 'jclass')) ||
      attr(atom, "jclass") != "org/openscience/cdk/interfaces/IAtom") {
    stop("Must supply an IAtom object")
  }
  
  p3d <- .jcall(atom, "Ljavax/vecmath/Point3d;", "getPoint3d")
  c(.jfield(p3d, name='x'),
    .jfield(p3d, name='y'),
    .jfield(p3d, name='z'))
}

get.symbol <- function(atom) {
  if (is.null(attr(atom, 'jclass')) ||
      attr(atom, "jclass") != "org/openscience/cdk/interfaces/IAtom") {
    stop("Must supply an IAtom object")
  }
  .jcall(atom, "S", "getSymbol")
}

get.atomic.number <- function(atom) {
  if (is.null(attr(atom, 'jclass')) ||
      attr(atom, "jclass") != "org/openscience/cdk/interfaces/IAtom") {
    stop("Must supply an IAtom object")
  }
  .jcall(atom, "I", "getAtomicNumber")
}
