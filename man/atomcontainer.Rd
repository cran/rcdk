\name{Molecule}
\alias{get.exact.mass}
\alias{convert.implicit.to.explicit}
\title{
	Operations on molecules
}
\description{
	Various functions to perform operations on molecules. 

	\code{get.exact.mass} returns the exact mass of a molecule

	\code{convert.implicit.explicit} converts implicit hydrogens
	to explicit hydrogens. This function does not return any value
	but rather modifies the molecule object passed to it
}
\usage{
get.exact.mass(molecule)
convert.implicit.to.explicit(molecule)
}
\arguments{
  \item{molecule}{A \code{jObjRef} representing an IAtomContainer or IMolecule object}
}
\value{
	\code{exact.mass} returns a numeric

	\code{convert.implicit.to.explicit} has no return value
}
\keyword{programming}
\seealso{
  \code{\link{get.atoms}}
}
\author{Rajarshi Guha (\email{rajarshi.guha@gmail.com})}
