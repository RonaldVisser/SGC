# glk.R from dplR (https://cran.r-project.org/src/contrib/dplR_1.6.7.tar.gz) has been used as inspiration
# calulate Gleichlaufigkeit
# author: Ronald Visser
GLK <- function(x, overlap = 3) {
  n <- dim(x)[2]
  GLK_mat <- matrix(NA_real_, nrow = n, ncol = n)
  Overlap_n <- matrix(NA_real_, nrow = n, ncol = n)
  rownames(GLK_mat) <- colnames(GLK_mat) <- names(x)
  rownames(Overlap_n) <- colnames(Overlap_n) <- names(x)
  treering_sign <- apply(x, 2, diff)
  treering_sign <- sign(treering_sign)
  for (i in 1:n) {
    treering_GC <- abs(treering_sign[,i]-treering_sign)
    # overlap is the number of overlapping growth changes
    treering_GCol <- colSums(!is.na(treering_GC))
    treering_GCol[treering_GCol==0] <- NA
    treering_GCol[treering_GCol<overlap] <- NA
    GLK_values <- 1-(colSums(treering_GC,na.rm=TRUE)/(2*treering_GCol))
    GLK_mat[i,] <- GLK_values
    Overlap_n[i,] <- treering_GCol
  }
  GLK <- list(GLK_mat,Overlap_n)
}