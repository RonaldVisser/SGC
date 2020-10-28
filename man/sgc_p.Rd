\encoding{UTF-8}
\name{sgc_p}

\alias{sgc_p}

\title{Probability of exceedence of the Synchronous Growth Changes}

\description{
  This function calculates a matrix with the probability of exceedence of synchronous growth changes using the output of \code{\link[=sgc]{sgc()}} as input.
}

\usage{
sgc_p(sgc_list)
}

\arguments{
  \item{sgc_list}{ a \code{list} that is the result of \code{\link[=sgc]{sgc()}}. The list consists of two matrices, one with the sgc/ssgc and one with the length of the overlap}}
  
\details{
The probability of exceedence (p) for the sgc expresses the chance that the sgc is incorrect. The observed value of the sgc is converted to a z-score and based on the standard normal curve the probability of exceedence is calculated. The result is a matrix of all p-values (Visser 2020).
}

\value{
  A \code{matrix} of all probabilities of exceedence for all observed sgc values.
}

\author{ Ronald Visser}

\references{
  Visser, R.M. (2020) On the similarity of tree‐ring patterns: Assessing the influence of semi‐synchronous growth changes on the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} for big tree‐ring data sets,\emph{Archaeometry},
  \bold{XX}, xx\enc{–}{--}xx (DOI: https://doi.org/10.1111/arcm.12600).
}

\seealso{
  \code{\link[=sgc]{sgc()}},
  \code{\link[=glk_p]{glk_p()}}
  }

\examples{
  library(dplR)
  data(ca533)
  ca533.sgclist <- sgc(ca533,50)
  ca533.sgc_p <- sgc_p(ca533.sgclist)
}

