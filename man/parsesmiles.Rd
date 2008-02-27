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
parse.smiles(smiles, parser)
}
\arguments{
  \item{smiles}{A SMILES string}
  \item{parser}{A reference to an object of class
  \code{IChemObjecBuilder} that can be obtained from
  \code{\link{get.smiles.parser}}. If this argument is not specified,
  then a parser will be created automatically. However this is
  inefficient if you are parsing many SMILES. In such a case create
  your own parser and supply it as this argument}
}
\value{
  A \code{jobjRef} to a CDK \code{IAtomContainer} object
}
\keyword{programming}
\seealso{
  \code{\link{get.smiles}},
  \code{\link{get.smiles.parser}},
  \code{\link{view.molecule.2d}}
}
\author{Rajarshi Guha (\email{rguha@indiana.edu})}
