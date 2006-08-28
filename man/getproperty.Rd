\name{get.property}
\alias{get.property}
\title{
  Get the Value of a Molecule Property
}
\description{
  This function retrieves the value of a keyed property that has
  previously been set on the molecule
}
\usage{
get.property(molecule, key)
}
\arguments{
  \item{molecule}{A Java object of class \code{IAtomContainer}}
  \item{key}{A string naming the property}
}
\value{
 The value of the property is the key is found else NA
}
\keyword{programming}
\seealso{
  \code{\link{set.property}},
  \code{\link{remove.property}}
}
\author{Rajarshi Guha (\email{rguha@indiana.edu})}
