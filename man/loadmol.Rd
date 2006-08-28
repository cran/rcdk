\name{load.molecules}
\alias{load.molecules}
\title{
  Load Molecular Structure From Disk
}
\description{
The CDK can read a variety of molecular structure formats. This function
encapsulates the calls to the CDK API to load a structure given its filename
}
\usage{
load.molecules(molfiles=NA)
}
\arguments{
  \item{molfiles}{A \code{character} vector of filenames. Note that the full
  path to the files should be provided}
}
\value{
  A list of CDK \code{Molecule} objects, which can be used in other rcdk 
  functions
}
\seealso{
  \code{\link{view.molecule.3d}},
  \code{\link{view.molecule.2d}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
