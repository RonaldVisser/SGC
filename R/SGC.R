# Inspired from glk.R from dplR (https://cran.r-project.org/src/contrib/dplR_1.6.7.tar.gz) has been used as inspiration
# author: Ronald Visser
# Published as: Visser, R.M., 2020: On the similarity of tree‐ring patterns: Assessing the influence of semi‐synchronous growth changes on the Gleichläufigkeitskoeffizient for big tree‐ring data sets, Archaeometry 2020.
# DOI: https://doi.org/10.1111/arcm.12600
# SGC = Synchronous Growth Changes
# to extract list of SGC/SSGC use command below
# SSGC <- sgc_mat[lower.tri(sgc_mat)]
# SGC <- sgc_mat[upper.tri(sgc_mat)]

sgc <- function(x, overlap = 50) {
  # checks class rwl and correct overlap
  if(!("rwl" %in% class(x))) warning("'x' is not class rwl")
  if(any(length(overlap)!=1 | !is.numeric(overlap) | 
         overlap%%1!=0 | overlap < 3)){
    stop("'overlap' should be a single integer >=3")
  }
  if(overlap < 50) warning("The minimum number of overlap is lower than 50. This might lead to statistically insignificant matches.")
  # function starts here
  n <- dim(x)[2]
  sgc_mat <- matrix(NA_real_, nrow = n, ncol = n)
  overlap_n <- matrix(NA_real_, nrow = n, ncol = n)
  rownames(sgc_mat) <- colnames(sgc_mat) <- names(x)
  rownames(overlap_n) <- colnames(overlap_n) <- names(x)
  treering_sign <- apply(x, 2, diff)
  treering_sign <- sign(treering_sign)
  for (i in 1:n) {
    treering_GC <- abs(treering_sign[,i]-treering_sign)
    # determine overlap (the number of overlapping growth changes)
    treering_GCol <- colSums(!is.na(treering_GC))
    treering_GCol[treering_GCol==0] <- NA
    treering_GCol[treering_GCol<overlap] <- NA
    # semi synchronous growth changes
    treering_GC1 <- colSums(treering_GC==1,na.rm=TRUE)
    # synchronous growth changes
    treering_GC0 <- colSums(treering_GC==0,na.rm=TRUE)
    SGC_values <- treering_GC0 / treering_GCol
    SSGC_values <- treering_GC1 / treering_GCol
    sgc_mat[i,-seq(1:i)] <- SGC_values[-seq(1:i)]
    # transpose and place SSGC in the lower triangle of the SGC-matrix
    sgc_mat[-seq(1:i),i] <- SSGC_values[-seq(1:i)]
    overlap_n[i,-seq(1:i)] <- treering_GCol[-seq(1:i)]
  }
  # mirror overlap to both triangles of the matrix
  overlap_n[lower.tri(overlap_n)] <- overlap_n[upper.tri(overlap_n)]
  # overlap of self comparisons is length of series - 1
  #diag(overlap_n) <- colSums(!is.na(x))-1
  sgc <- list(sgc_mat,overlap_n)
}
