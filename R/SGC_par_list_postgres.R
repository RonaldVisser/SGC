# script to read tree ring files and store values of SGC, SSGC and overlap in a postgresql database
library(dplR)
library(RPostgreSQL)
library(pastecs)
library(getPass)

treeringfile <- file.choose()
datafolder <- dirname(treeringfile)
setwd(datafolder)
treering <-read.tucson(treeringfile,header = TRUE)
# remove duplicate tree ring series
treering_duplicated <- treering[, duplicated(t(treering))]
treering <- treering[, !duplicated(t(treering))]
# minimal overlap for SGC
SGC_overlap = 50
# check for long periods with missing rings
missing_rings <- treering == 0
# check for missing rings
if (length(missing_rings) > 0) {
  missing_rings <- apply(missing_rings,2,which)
  missing_rings <- lapply(missing_rings,length)
  # place series with too many missing rings (more than 1/3 of overlap SGC) in seperate dataframe
  max_missing = 0
  ex_mr = missing_rings[missing_rings>max_missing]
  vec_ex_mr <- unlist(names(ex_mr))
  treering_mr <- treering[ ,names(treering) %in% vec_ex_mr]
  # continue analysis with series with less dan "max_missing" rings
  treering <- treering[ ,!names(treering) %in% vec_ex_mr]
}

#
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user='postgres', password=getPass::getPass(), dbname='itrdb')
#
    n <- dim(treering)[2]
    treering_sign <- apply(treering, 2, diff)
    treering_sign <- sign(treering_sign)
    for (i in 1:(n - 2)) {
      treering_GC <- abs(treering_sign[,i]-treering_sign[,-seq(1:i)])
      treering_GCol <- colSums(!is.na(treering_GC))
      treering_GCol[treering_GCol==0] <- NA
      treering_GCol[treering_GCol<SGC_overlap] <- NA
      treering_GC1 <- colSums(treering_GC==1,na.rm=TRUE)
      treering_GC0 <- colSums(treering_GC==0,na.rm=TRUE)
      SGC_values <- treering_GC0 / treering_GCol
      SSGC_values <- treering_GC1 / treering_GCol
      Overlap_n_list <- treering_GCol
      print(paste(i, "of", n)) # print counter to keep track op progress
      SGC <- SGC_values[!is.na(SGC_values)]
      SSGC <- SSGC_values[!is.na(SSGC_values)]
      Overlap <- treering_GCol[!is.na(treering_GCol)]
      ID1 <- names(Overlap)
      ID2 <- rep(names(treering[i]),length(Overlap))
      GC_table <- cbind(ID1,ID2,SGC,SSGC,Overlap)
      dbWriteTable(con, "GC_eu_tbl", as.data.frame(GC_table), append=TRUE, row.names = FALSE)
    }

dbDisconnect(con)
dbUnloadDriver(drv)
