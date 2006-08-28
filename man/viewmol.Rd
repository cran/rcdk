\name{view.molecule.3d}
\alias{view.molecule.3d}
\title{
  View a 3D Molecular Structure
}
\description{
This function allows you to view a 3D molecular structure using the
Jmol viewer. It is also possible to supply a script that Jmol will evaluate.
Once the viewer window is shown, all the available Jmol commands and functionality
is available
}
\usage{
view.molecule.3d(molecule, ncol = 4, cellx = 200, celly = 200, script = NA)
}
\arguments{
  \item{molecule}{A \code{jobjRef}, list of \code{jobjRef} objects or \code{character} indicating the path to the structure
    file}
  \item{ncol}{The number of columns if a grid is desired}
  \item{cellx}{The width of the grid cells}
  \item{celly}{The height of the grid cells}
  \item{script}{A \code{character} containing valid Jmol scripting commands}
}

\details{
  If a \code{jobjRef} is passed it should be a reference to an
  \code{IAtomContainer} object. In case the first argument is of class
  character it is assumed to be a file and is loaded by the function.
  
  This function can be used to view a single molecule or multiple
  molecules. If a \code{list} of molecule objects is supplied the
  molecules are displayed as a grid of Jmol viewers. In case a file is
  specified, it will display a single molecule or multiple molecules
  depending on how many molecules are loaded.
}

\value{
 Nothing
}
\seealso{
  \code{\link{view.molecule.table}},
  \code{\link{view.molecule.2d}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
