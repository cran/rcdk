\name{parse.smiles}
\alias{parse.smiles}
\title{
  Parse a SMILES String
}
\description{
  This function parses a SMILES string to generate an
  \code{IAtomContainer} object. Note that the resultant molecule will
  not have any 2D or 3D coordinates.
}
\usage{
parse.smiles(smiles)
}
\arguments{
  \item{smiles}{A SMILES string}
}
\value{
  A \code{jobjRef} to a CDK \code{IAtomContainer} object
}
\keyword{programming}
\seealso{
  \code{\link{get.smiles}},
  \code{\link{view.molecule.2d}}
}
\author{Rajarshi Guha (\email{rguha@indiana.edu})}
