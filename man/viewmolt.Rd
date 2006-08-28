\name{view.molecule.table}
\alias{view.molecule.table}
\title{
  View Multiple 3D Structure and Associated Data
}
\description{
This function allows you to view multiple structures in 3D alongwith 
associated data in a tabular format. Note that each molecule is represented
by a seperate instance of the Jmol view and so it can become resource
intensive for a large collection of molecules
}
\usage{
view.molecule.table(fnames, cnames, datatable)
}
\arguments{
  \item{fnames}{A \code{character} vector containing the fully qualified
    names of the structure files to view}
  \item{cnames}{A \code{character} vector of column names. Note that the
    number of elements of this vector should be \code{nrow(datatable)+1}}
  \item{datatable}{A \code{data.frame} or \code{matrix} of data to be displayed for
    each structure. The number of rows should be equal to the number of
    filenames specified in \code{fnames}}
}

\value{
 Nothing
}
\seealso{
\code{\link{draw.molecule}}, \code{\link{load.molecules}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
