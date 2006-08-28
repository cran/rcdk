\name{eval.desc}
\alias{eval.desc}
\title{
  Evaluate a Molecular Descriptor
}
\description{
  The CDK implements a number of descriptors divided into three main
  groups - atomic, molecular and bond. This method evaluates the
  specified molecular  descriptor for a molecule
}
\usage{
eval.desc(molecule, which.desc)
}
\arguments{
  \item{molecule}{A reference to a CDK \code{IAtomContainer} object}
  \item{which.desc}{The fully qualified class name of the descriptor to evaluate}
}
\value{
  Depending on the nature of the descriptor, a single numeric value or
  else a numeric vector
}
\seealso{
\code{\link{get.desc.classnames}}, \code{\link{eval.desc}}, \code{\link{get.desc.values}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
