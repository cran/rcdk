\name{Atoms}
\alias{get.symbol}
\alias{get.point3d}
\alias{get.atomic.number}
\title{
	Operations on atoms
}
\description{
	\code{get.symbol} returns the chemical symbol for an atom.

	\code{get.point3d} returns the 3D coordinates of the atom

	\code{get.atomic.number} returns the atomic number of the atom
}
\usage{
get.symbol(atom)
get.point3d(atom)
get.atomic.number(atom)
}
\arguments{
  \item{atom}{A \code{jObjRef} representing an IAtom object}
}
\value{
	In the case of \code{get.point3d} the return value is a
	3-element vector containing the X, Y and Z coordinates of the
	atom. If the atom does not have 3D coordinates, it returns NULL
}
\keyword{programming}
\seealso{
  \code{\link{get.atoms}}
}
\author{Rajarshi Guha (\email{rguha@indiana.edu})}
