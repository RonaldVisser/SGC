# script to get all values from database (PostgreSQL) and read them into workspace
library(tidyverse)
library(dbplyr)
library(DBI)
library(pastecs)
library(dbplot)
library(getPass)
library(tcltk)

source("dbplot_histogram.R")
# working dir to save graphs
datafolder <- tk_choose.dir()
setwd(datafolder)

# Connection to Postgres
con <- DBI::dbConnect(RPostgreSQL::PostgreSQL(),
                      host = "localhost",
                      port = 5432,
                      dbname = "itrdb",
                      user = "postgres",
                      password=getPass::getPass() )
# Get Table
# Continent (af, as, au, eu, mx, sa, us)
continent <- "au"

# get all data from table
itrdb_db <- tbl(con, paste0("GC_", continent, "_tbl"))

# notation numbers
options(scipen = 100)
options(digits =2)
itrdb_db.GLK <- itrdb_db %>% mutate(GLK = SGC + (SSGC/2))

# use summarise to get sum stats
overlap_desc_stat <- itrdb_db %>% select(Overlap) %>% summarise(n = n(), mean = mean(Overlap), st.dev = sd(Overlap), min = min(Overlap), max= max(Overlap))
SGC_desc_stat <- itrdb_db %>% select(SGC) %>% summarise(n = n(), mean = mean(SGC), st.dev = sd(SGC), min = min(SGC), max= max(SGC))
SSGC_desc_stat <-itrdb_db %>% select(SSGC) %>% summarise(n = n(), mean = mean(SSGC), st.dev = sd(SSGC), min = min(SSGC), max= max(SSGC))
GLK_desc_stat <- itrdb_db.GLK %>% summarise(n = n(), mean = mean(GLK), st.dev = sd(GLK), min = min(GLK), max= max(GLK))
SSGC_GLK_desc_stat <- itrdb_db.GLK %>% summarise(n = n(), mean = mean(PercentageSSGC_GLK), st.dev = sd(PercentageSSGC_GLK), min = min(PercentageSSGC_GLK), max= max(PercentageSSGC_GLK))
write.csv(overlap_desc_stat,"Overlap_descr_stats.csv")
write.csv(SGC_desc_stat,"SGC_descr_stats.csv")
write.csv(SSGC_desc_stat,"SSGC_descr_stats.csv")
write.csv(GLK_desc_stat,"GLK_descr_stats.csv")

# Extreme SSGC; more then 10%
itrdb_db.SSGC_10 <- itrdb_db %>% select(SSGC) %>% filter(SSGC > 0.1)
SSGC_desc_stat_10 <- itrdb_db.SSGC_10 %>% summarise(n = n(), mean = mean(SSGC), st.dev = sd(SSGC), min = min(SSGC), max= max(SSGC))
write.csv(SSGC_desc_stat_10,"SSGC_10_descr_stats.csv")

itrdb_db.SSGC_10 %>% dbplot_histogram(SSGC, binwidth = 0.01) + xlim(0.1,0.5)
ggsave("SSGC_10_hist.png", width=10,height=10)


# Histograms
itrdb_db %>% dbplot_histogram(SGC, binwidth = 0.01) + xlim(0,1)
ggsave("SGC_hist.png", width=10,height=10)
itrdb_db %>% dbplot_histogram(SSGC, binwidth = 0.01) + xlim(0,0.5)
ggsave("SSGC_hist.png", width=10,height=10)
itrdb_db %>% dbplot_histogram(Overlap, binwidth = 25) + xlim(0,1500)
ggsave("Overlap_hist.png", width=10,height=10)
itrdb_db.GLK %>% dbplot_histogram(GLK, binwidth = 0.01) + xlim(0,1)
ggsave("GLK_hist.png", width=10,height=10)

# Scatterplots: raster
itrdb_db %>% dbplot_raster(SGC, SSGC,resolution = 100) + xlim(0,1) + ylim(0,0.5)
ggsave("SGC_SSGC.png", width=10,height=10)
itrdb_db %>% dbplot_raster(SGC, Overlap, resolution = 100) + xlim(0,1) + ylim(0,1500)
ggsave("SGC_Overlap.png", width=10,height=10)
itrdb_db %>% dbplot_raster(SSGC, Overlap, resolution = 100) + xlim(0,0.5) + ylim(0,1500)
ggsave("SSGC_Overlap.png", width=10,height=10)
itrdb_db.GLK %>% dbplot_raster(GLK, SGC, resolution = 100) + xlim(0,1) + ylim(0,1)
ggsave("GLK_SGC.png", width=10,height=10)
