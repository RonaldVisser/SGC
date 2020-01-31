# glk.R from dplR (https://cran.r-project.org/src/contrib/dplR_1.6.7.tar.gz) has been used as inspiration
# to extract list of SGC/SSGC use command below
# SSGC <- SGC_mat[lower.tri(SGC_mat)]
# SGC <- SGC_mat[upper.tri(SGC_mat)]
SGC <- function(x, overlap = 3) {
    n <- dim(x)[2]
    SGC_mat <- matrix(NA_real_, nrow = n, ncol = n)
    Overlap_n <- matrix(NA_real_, nrow = n, ncol = n)
    rownames(SGC_mat) <- colnames(SGC_mat) <- names(x)
    rownames(Overlap_n) <- colnames(Overlap_n) <- names(x)
    treering_sign <- apply(x, 2, diff)
    treering_sign <- sign(treering_sign)
    for (i in 1:n) {
      treering_GC <- abs(treering_sign[,i]-treering_sign)
      # overlap is the number of overlapping growth changes
      treering_GCol <- colSums(!is.na(treering_GC))
      treering_GCol[treering_GCol==0] <- NA
      treering_GCol[treering_GCol<overlap] <- NA
      # semi synchronous growth changes
      treering_GC1 <- colSums(treering_GC==1,na.rm=TRUE)
      # synchronous growth changes
      treering_GC0 <- colSums(treering_GC==0,na.rm=TRUE)
      SGC_values <- treering_GC0 / treering_GCol
      SSGC_values <- treering_GC1 / treering_GCol
      SGC_mat[i,-seq(1:i)] <- SGC_values[-seq(1:i)]
      # transpose and place SSGC vertical in SGC-matrix
      SGC_mat[-seq(1:i),i] <- SSGC_values[-seq(1:i)]
      Overlap_n[i,-seq(1:i)] <- treering_GCol[-seq(1:i)]
    }
    SGC <- list(SGC_mat,Overlap_n)
}
