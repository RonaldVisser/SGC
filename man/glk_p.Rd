\encoding{UTF-8}
\name{glk_p}

\alias{glk_p}

\title{Probability of exceedence of the \enc{Gleichläufigkeit}{Gleichlaeufigkeit}}

\description{
  This function calculates a matrix with the probability of exceedence of the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} using the output of \code{\link[=glk]{glk()}} as input.
}

\usage{
glk_p(glk_list)
}

\arguments{
  \item{glk_list}{ a \code{list} that is the result of \code{\link[=glk]{glk()}}. The list consists of two matrices, one with the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} and one with the length of the overlap of each comparison}}
  
\details{
The probability of exceedence (p) for the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} expresses the chance that the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} is incorrect. The observed value of the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} is converted to a z-score and based on the standard normal curve the probability of exceedence is calculated. The result is a matrix of all p-values (Jansma 1995, 60-61, see also Visser 2020).
}

\value{
  A \code{matrix} of all probabilities of exceedence for all observed \enc{Gleichläufigkeit}{Gleichlaeufigkeit} values.
}

\author{ Ronald Visser}

\references{
Jansma, E., 1995. \emph{RemembeRINGs; The development and application of local and regional tree-ring chronologies of oak for the purposes of archaeological and historical research in the Netherlands}, Nederlandse Archeologische Rapporten 19, Rijksdienst voor het Oudheidkundig Bodemonderzoek, Amersfoort.}

\seealso{
  \code{\link[=glk]{glk()}},
  \code{\link[=sgc_p]{sgc_p()}}
  }


\examples{
  library(dplR)
  data(ca533)
  ca533.glklist <- glk(ca533,50)
  ca533.glk_p <- glk_p(ca533.glklist)
}

