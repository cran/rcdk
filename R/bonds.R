##get.bond.order <- function(bond) {
##  stop("Doesn't work at this point")
##  if (is.null(attr(bond, 'jclass')) ||
##      attr(bond, "jclass") != "org/openscience/cdk/interfaces/IBond") {
##    stop("Must supply an IBond object")
##  }
##
##  bo <- .jcall(bond, "Lorg/openscience/cdk/interfaces/IBond.Order;", "getBondOrder")
##  bo
##}
##

get.connected.atom <- function(bond, atom) {
  if (is.null(attr(bond, 'jclass')) ||
      attr(bond, "jclass") != "org/openscience/cdk/interfaces/IBond") {
    stop("Must supply an IBond object for bond")
  }

  if (is.null(attr(atom, 'jclass')) ||
      attr(atom, "jclass") != "org/openscience/cdk/interfaces/IAtom") {
    stop("Must supply an IAtom object for atom")
  }

  .jcall(bond, "Lorg/openscience/cdk/interfaces/IAtom;", "getConnectedAtom", atom);
}
