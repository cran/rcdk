\name{get.desc.engine}
\alias{get.desc.engine}
\title{
  Get the Descriptor Engine
}
\description{
  The CDK \code{DescriptorEngine} class allows automated calculation of
  all available descriptors of a specified type. Note that this may not
  be a good idea under R since certain descriptors may throw exceptions
  which cannot be easily caught in rJava. However it is possible to
  obtaina a variety of information from this object such as the class
  names of the available descriptors, instances of these descriptors and
  so on.
}
\usage{
get.desc.engine(type = 'molecular')
}
\arguments{
  \item{type}{A character argument indicating the type of descriptors to
    consider. Possible values are: bond, atomic, molecular}
}
\value{
  A \code{DescriptorEngine} object
}
\seealso{
\code{\link{get.desc.classnames}}, \code{\link{eval.desc}}, \code{\link{get.desc.values}}
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
