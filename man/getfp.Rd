\name{get.fingerprint}
\alias{get.fingerprint}
\title{
  Evaluate Fingerprints
}
\description{
  This function evaluates fingerprints for a set of molecules or
  a single molecule. Currently only the CDK defaults are used for
  evaluation.

  Depending on whether the input is a single \code{IAtomContainer}
  object, a list or single vector is returned. Each element of the list 
  is a vector containing the bit positions of the fingerprint that are on.
  These lists (or individual vectors) can be manipulated using the
  \code{fingerprint} package
}
\usage{
    get.fingerprint(molecule, depth=6, size=1024)
}
\arguments{
  \item{molecule}{An \code{IAtomContainer} object that can be obtained
    by loading them from disk or drawing them in the editor.
  }
  \item{depth}{The search depth}
  \item{size}{The length of the fingerprint bit string}
}
\value{
  A numeric vectors whose elements indicate the bit positions set to one
}
\seealso{
  \code{\link{draw.molecule}}, \code{link{load.molecules}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
