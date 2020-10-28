# glk.R from dplR (https://cran.r-project.org/src/contrib/dplR_1.6.7.tar.gz) has been used as inspiration
# calulate Gleichlaufigkeit
# author of this version: Ronald Visser based on versions by Christian Zang, Mikko Korpela and Allan Buras
glk <- function(x, overlap = 50) {
  if(!("rwl" %in% class(x))) warning("'x' is not class rwl")
  if(any(length(overlap)!=1 | !is.numeric(overlap) | 
         overlap%%1!=0 | overlap < 3)){
    stop("'overlap' should be a single integer >=3")
  }
  if(overlap < 50) warning("The minimum number of overlap is lower than 50. This might lead to statistically insignificant matches.")
  # function starts here
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
  glk <- list(GLK_mat,Overlap_n)
}
