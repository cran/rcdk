\name{set.property}
\alias{set.property}
\title{
  Set A Property On A Molecule
}
\description{
  This function allows one to add a keyed property to a molecule. The
  key must be a string, but the value can be string, numeric or even an
  arbitrary Java object (of class \code{jobjRef})
}
\usage{
set.property(molecule, key, value)
}
\arguments{
  \item{molecule}{A Java object of class \code{IAtomContainer}}
  \item{key}{A string naming the property}
  \item{value}{The value of the property. This can be character,
    integer, double or of class \code{jobjRef}}
}
\value{
  None
}
\keyword{programming}
\seealso{
  \code{\link{get.property}},
  \code{\link{remove.property}}
}
\author{Rajarshi Guha (\email{rguha@indiana.edu})}
