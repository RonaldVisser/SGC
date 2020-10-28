\encoding{UTF-8}
\name{sgc}

\alias{sgc}

\title{Synchronous Growth Changes }

\description{
  This function calculates a matrix with synchronous growth changes (sgc) in the upper triangle and semi synchronous growth changes (ssgc) in the lower triangle and a matrix with the length of the compared overlap for a given set of tree-ring records.
}

\usage{
sgc(x,overlap = 50)
}

\arguments{
  \item{x}{ a \code{data.frame} of tree-ring data with records in columns, and years as rows. }
  \item{overlap}{ integer value with minimal length of overlapping growth changes (compared number of tree rings - 1). Comparisons with less overlap are not compared.}
}

\details{
The sgc is a non parametric test based on sign tests.The synchronous growth changes (sgc) and semi synchronous growth changes (ssgc) are proposed to replace the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} (\code{\link[=glk]{glk()}}), since the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} can be strongly influenced by years when one of the compared series shows no growth change. The sgc gives a better description of the similarity (Visser, 2020). The ssgc gives the percentage years that one of the compared series shows no growth change. This function implements sgc and ssgc as the vectorized pairwise comparison of all records in data set. It returns a list of two matrices. 
\enumerate{
  \item Matrix with sgc and ssgc. 
  \itemize{
    \item{Upper triangle: sgc values}
    \item{Lower triange: ssgc values}
  }
  \item Matrix with number of overlapping growth changes. This is the number of overlapping years minus one.
  }
The matrices can be extracted from the list by selecting the index number. The first item in the list is the sgc/ssgc-matrix, the second the overlap. To calculate the global sgc of the dataset (assuming the sgc/ssgc is extracted as \code{x.sgc}) \code{mean(x.sgc[upper.tri(x.sgc), na.rm = TRUE)}. For the global ssgc used: \code{mean(x.sgc[lower.tri(x.sgc), na.rm = TRUE)}

}

\value{
  A \code{list} with a \code{matrix} for the sgc/ssgc and a \code{matrix} for the overlap. Comparisons are only compared if the overlap is above the set theshold and if no threshold is set, this defaults to 50 years.If no comparison can be compared, \code{NA} is returned.
}

\author{ Ronald Visser}

\references{
  Visser, R.M. (2020) On the similarity of tree‐ring patterns: Assessing the influence of semi‐synchronous growth changes on the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} for big tree‐ring data sets,\emph{Archaeometry},
  \bold{XX}, xx\enc{–}{--}xx (DOI: https://doi.org/10.1111/arcm.12600).
  }

\seealso{
  \code{\link[=sgc_p]{sgc_p()}},
  \code{\link[=glk]{glk()}}
  }
 
\examples{
library(dplR)
data(ca533)
ca533.sgclist <- sgc(ca533,50)
ca533.sgc <- as.data.frame(ca533.sgclist[1])
ca533.sgc_ol <- as.data.frame(ca533.sgclist[2])
mean(ca533.sgc[lower.tri(ca533.sgc), na.rm = TRUE)
mean(ca533.sgc[upper.tri(ca533.sgc), na.rm = TRUE)
}


