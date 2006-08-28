\name{get.desc.values}
\alias{get.desc.values}
\title{
  Extract Descriptor Values
}
\description{
  The result of a call to a CDK Descriptor class is a \code{DescriptorValue}
  object which contains a variety of information. For modeling purposes
  we are interested in extracting the numerical values, which may be a single
  number of a vector of numbers. This function encapsulates the calls to the
  CDK library to extract the numerical values
}
\usage{
get.desc.values(dval)
}
\arguments{
  \item{dval}{A Java object obtained by a call to the \code{calculate} method
  of a CDK \code{Descriptor} class}
}
\value{
  A \code{numeric} of one or more elements
}
\keyword{programming}

\author{Rajarshi Guha (\email{rguha@indiana.edu})}
