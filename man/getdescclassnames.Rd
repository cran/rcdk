\name{get.desc.classnames}
\alias{get.desc.classnames}
\title{
  Get Descriptor Class Names
}
\description{
  The CDK implements a number of descriptors divided into three main
  groups - atomic, molecular and bond. This method uses a CDK Object of
  class \code{DescriptorEngine} to get the class names of all
  descriptors of a specific type. The class names can then be used to
  obtain descriptor values for a molecule.
}
\usage{
get.desc.classnames(dengine)
}
\arguments{
  \item{dengine}{A reference to a CDK \code{DescriptorEngine} object}
}
\value{
  A character vector of descriptor class names
}
\seealso{
\code{\link{get.desc.classnames}}, \code{\link{eval.desc}}, \code{\link{get.desc.values}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
