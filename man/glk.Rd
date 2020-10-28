\encoding{UTF-8}
\name{glk}

\alias{glk}

\title{ Calculate \enc{Gleichläufigkeit}{Gleichlaeufigkeit} }

\description{
  This function calculates the matrix of
  \enc{Gleichläufigkeit}{Gleichlaeufigkeit} for a given set of tree-ring
  records.
}

\usage{
glk(x, overlap = 50)
}

\arguments{
  \item{x}{ a \code{data.frame} of tree-ring data with records in
    columns, and years as rows.}  
  \item{overlap}{ integer value with minimal length of overlapping growth changes (compared number of tree rings - 1). Comparisons with less overlap are not compared.}
}

\details{
  \enc{Gleichläufigkeit}{Gleichlaeufigkeit} is a classical agreement test based on sign tests (Eckstein and Bauch, 1969).  This function   implements \enc{Gleichläufigkeit}{Gleichlaeufigkeit} as the pairwise   comparison of all records in data set, and thus returns a list of two matrices. 
\enumerate{
  \item Matrix with \enc{Gleichläufigkeit}{Gleichlaeufigkeit}
  \item Matrix with number of overlapping growth changes. This is the number of overlapping years minus one.
}
The matrices can be extracted from the list by selecting the index number. The first item in the list is the glk-matrix, the second the overlap. To calculate the global glk of the dataset (assuming the glk is extracted as \code{x.glk}) \code{mean(x.glk, na.rm = TRUE)}.
This vectorized implementation is faster than the previous version and follows the original definition (Huber 1942), instead of the incorrect interpretation that has been used in the past (Schweingruber 1988, see Buras/Wilmking 2015 for the correction) 

improves  the original formulation inasmuch as the case of neighbouring identical measurements in the same years is accounted for.  Here, it is treated as full agreement, in contrast to only partial agreement in the original formulation.
}

\value{
  A \code{matrix} with the \enc{Gleichläufigkeit}{Gleichlaeufigkeit} for
  all possible combinations of records.  If two curves have less than 3
  years of overlap, \enc{Gleichläufigkeit}{Gleichlaeufigkeit} cannot be
  computed, and \code{NA} is returned.
}

\author{ Christian Zang.  Patched and improved by Mikko Korpela.
  Improved by Allan Buras. Further improved by Ronald Visser }

\references{

Buras, A. and Wilmking, M. (2015) Correcting the calculation of Gleichläufigkeit, \emph{Dendrochronologia} \bold{34}, 29–30. DOI: https://doi.org/10.1016/j.dendro.2015.03.003

Eckstein, D. and Bauch, J. (1969) Beitrag zur Rationalisierung eines dendrochronologischen Verfahrens und zur Analyse seiner Aussagesicherheit. \emph{Forstwissenschaftliches Centralblatt}, \bold{88}(1), 230\enc{–}{--}250.

Huber, B. (1943) Über die Sicherheit jahrringchronologischer Datierung. \emph{Holz als Roh- und Werkstoff} \bold{6}, 263–268. DOI: https://doi.org/10.1007/BF02603303


Schweingruber, F. H. (1988) \emph{Tree rings: basics and applications of dendrochronology}, Kluwer Academic Publishers, Dordrecht, Netherlands, 276 p.
}

\seealso{
  \code{\link[=glk_p]{glk_p()}},
  \code{\link[=sgc]{sgc()}} (sgc is a replacement for the glk)
  }

\examples{library(utils)
data(ca533)
ca533.glk <- glk(ca533)
mean(ca533.glk, na.rm = TRUE)
}

\keyword{ ts }
