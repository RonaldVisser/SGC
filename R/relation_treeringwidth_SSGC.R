# script to compare tree ring width to years with SSGC

library(dplR)
library(tidyverse)

treeringfile <- file.choose() # choose file
treering <- read.tucson(treeringfile,header = TRUE)

# check for missing rings
missing_rings <- treering == 0
if (length(missing_rings) > 0) {
  missing_rings <- apply(missing_rings,2,which)
  missing_rings <- lapply(missing_rings,length)
  # place series with too many missing rings (more than 1/3 of overlap SGC) in seperate dataframe
  ex_mr = missing_rings[missing_rings==0]
  vec_ex_mr <- unlist(names(ex_mr))
  treering_mr <- treering[ ,names(treering) %in% vec_ex_mr]
  # continue analysis with series with less dan "max_missing" rings
  treering <- treering[ ,!names(treering) %in% vec_ex_mr]
  rm(vec_ex_mr,ex_mr,missing_rings)
}

# find positions where there is no growth change in relation to previous year
treering_sign <- apply(treering, 2, diff)
treering_sign <- sign(treering_sign)
SSGC_years <- treering_sign==0
# select tree-ring widths where there is no growth change (SSGC)
treering_SSGC_values <- treering[SSGC_years]
#select tree-ring widths where there isgrowth change (SGC or AGC)
treering_A_SGC_values <- treering[!SSGC_years]
treering_SSGC_values_list <- na.omit(unlist(treering_SSGC_values))
treering_A_SGC_values_list <- na.omit(unlist(treering_A_SGC_values))
# create data.frames for trw with SSGC or not
trw_SSGC <- data.frame(treering_SSGC_values_list, rep("SSGC",length(treering_SSGC_values_list)))
colnames(trw_SSGC) <- c("trw", "SSGC_or_not")
trw_A_SGC <- data.frame(treering_A_SGC_values_list, rep("A_SGC",length(treering_A_SGC_values_list)))
colnames(trw_A_SGC) <- c("trw", "SSGC_or_not")
trw_SSGC <- rbind(trw_SSGC,trw_A_SGC)
# replace two letters of continent (AF, AS, AU, EU, MX, SA, US)
continent <- rep("US", dim(trw_SSGC)[1])
trw_SSGC <- data.frame(trw_SSGC,continent)
# remove temporary data
rm(trw_A_SGC, treering_SSGC_values, treering_SSGC_values_list,treering_A_SGC_values,treering_A_SGC_values_list)

#combine all
#trw_SSGC_all <- trw_SSGC

trw_SSGC_all <- rbind(trw_SSGC_all,trw_SSGC)
rm(trw_SSGC)

saveRDS(trw_SSGC_all,'trw_SSGC_all.rds')

trw_SSGC_all %>%
  group_by(SSGC_or_not) %>% t.test(trw ~ SSGC_or_not, data = ., conf.level = 0.95)

# plot boxplots of SSGC trws
trw_SSGC_all %>%
  ggplot(aes(y=trw, x=SSGC_or_not)) + geom_boxplot()
trw_SSGC_all %>%
  ggplot(aes(y=trw, x=SSGC_or_not, fill=continent)) + geom_boxplot()
trw_SSGC_all %>%
  ggplot(aes(y=trw, x=SSGC_or_not)) + geom_violin()
trw_SSGC_all %>%
  ggplot(aes(y=trw, x=SSGC_or_not, fill=continent)) + geom_violin()
trw_SSGC_all %>%
  ggplot(aes(x=trw)) + geom_histogram() + facet_grid(~SSGC_or_not)
