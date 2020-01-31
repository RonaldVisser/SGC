# read and analyse tree ring data per continent.
library(dplR)
library(pastecs)


# Read and correct data ---------------------------------------------------------------

treeringfile <- file.choose() # choose file
datafolder <- dirname(treeringfile) # set working dir to location of rwl-file
#datafolder <- './data/' # set working dir to projectfolder/data/
setwd(datafolder)
treering <-read.tucson(treeringfile,header = TRUE)
# load function
source('SGC.R')
# remove duplicate tree ring series
treering_duplicated <- treering[, duplicated(t(treering))]
treering <- treering[, !duplicated(t(treering))]
# minimal overlap for SGC
SGC_overlap = 25
# check for long periods with missing rings
missing_rings <- treering == 0
# check for missing rings
if (length(missing_rings) > 0) {
  missing_rings <- apply(missing_rings,2,which)
  missing_rings <- lapply(missing_rings,length)
  # place series with too many missing rings (more than 1/3 of overlap SGC) in seperate dataframe
  max_missing = ceiling(SGC_overlap/3)
  ex_mr = missing_rings[missing_rings>=max_missing]
  vec_ex_mr <- unlist(names(ex_mr))
  treering_mr <- treering[ ,names(treering) %in% vec_ex_mr]
  # continue analysis with series with less dan "max_missing" rings
  treering <- treering[ ,!names(treering) %in% vec_ex_mr]
}


# calculate SGC, SSGC en overlap for all series (matrix) ------------------
GC_result <- SGC(treering,overlap=SGC_overlap)
# Split result in tree different matrices
SGC_mat <- GC_result[[1]]
SSGC <- SGC_mat[lower.tri(SGC_mat)]
SGC <- SGC_mat[upper.tri(SGC_mat)]
Overlap_n <- GC_result[[2]]
OL <- Overlap_n[upper.tri(Overlap_n)]

# remove joint matrix (result of R-funtion only to have 1 resulting variable)
rm(GC_result)


# get descriptive statistics ---------------------------------------------
options(scipen = 100)
options(digits =2)
SSGC_desc_stat <- stat.desc(SSGC[!is.na(SSGC)])
SGC_desc_stat <- stat.desc(SGC[!is.na(SGC)])
overlap_desc_stat <- stat.desc(Overlap_n[!is.na(Overlap_n)])
# export to csv
write.csv(SSGC_desc_stat,"SSGC_descr_stats.csv")
write.csv(SGC_desc_stat,"SGC_descr_stats.csv")
write.csv(overlap_desc_stat,"Overlap_descr_stats.csv")

# descriptive statistics of tree ring series
write.csv(ex_mr,"too_many_missing_rings.csv")
tr_stats <- rwl.stats(treering)
tr_sum_stats <- summary(tr_stats)
write.csv(tr_stats,"treering_stats.csv")
write.csv(tr_sum_stats,"treering_summary_stats.csv")
# sample depth
sample_depth <- rowSums(!is.na(treering))
write.csv(sample_depth,"sample_depth.csv")
jpeg("sample_depth.jpg")
barplot(sample_depth, border = 'grey')
dev.off()


# Various plots -----------------------------------------------------------

jpeg("SGC_SSGC.jpg")
plot(SGC,SSGC,pch=20)
dev.off()
jpeg("SGC_hist.jpg")
hist(SGC, breaks = 100, col = 2)
dev.off()
jpeg("SSGC_hist.jpg")
hist(SSGC, breaks = 100, col = 2)
dev.off()
jpeg("Overlap_hist.jpg")
hist(OL, breaks = 100, col = 2)
dev.off()
jpeg("SGC_boxplot.jpg")
boxplot(SGC, pch=20, col=2)
dev.off()
jpeg("SSGC_boxplot.jpg")
boxplot(SSGC, pch=20, col=2)
dev.off()
jpeg("Overlap_boxplot.jpg") 
boxplot(OL, pch=20, col=2)
dev.off()
