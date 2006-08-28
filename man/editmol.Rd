\name{draw.molecule}
\alias{draw.molecule}
\title{
  Edit a 2D Molecular Structure
}
\description{
  This function allows you to draw a 2D structure and obtain the resultant
  structure as a \code{Molecule} object. Note that the structure that is
  returned contains only 2D coordinates
}
\usage{
draw.molecule(molecule = NA)
}
\arguments{
  \item{molecule}{A CDK \code{IAtomContainer} object. If specified, then
    the editor is loaded with the molecule. If \code{NA}, the editor
    will be blank}
}
\value{
  A \code{list} of \code{Molecule} objects
}
\seealso{
  \code{\link{view.molecule.table}},
  \code{\link{view.molecule.3d}},
  \code{\link{view.molecule.2d}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
