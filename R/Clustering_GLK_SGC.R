library(dplR)
library(dendextend)
library(viridis)
library(tools)

source('SGC.R')
source('GLK.R')

# open file
treeringfile <- file.choose()

# check for csv or rwl
# csv should to be formated as top row names, first column years and tree ring widths as columns
if (file_ext(treeringfile)=="rwl") {
  treering <- read.tucson(treeringfile)
} else if (file_ext(treeringfile)=="csv"){
  treering <- read.csv(treeringfile, row.names = 1)
  class(treering) <- c("rwl", "data.frame")
} else{
  stop("The file is not an rwl or csv")
}

# SGC
GC_mat <- SGC(treering, overlap = 25)
SSGC_mat <- GC_mat[[1]]
SSGC_mat[upper.tri(SSGC_mat)] <- t(SSGC_mat)[upper.tri(SSGC_mat)]
SGC_mat <- GC_mat[[1]]
SGC_mat[lower.tri(SGC_mat)] <- t(SGC_mat)[lower.tri(SGC_mat)]
diag(SGC_mat) <- 1
ol_mat <- GC_mat[[2]]
# GLK
GL_mat <- GLK(treering, overlap = 25)
GLK_mat <- GL_mat[[1]]
ol_GLK_mat <- GL_mat[[2]]

rm(GL_mat, GC_mat)

SGC_mat[is.na(SGC_mat)] <- 0 # replace SGC = NA for 0 for clustering
SGC_dist <- as.dist(1-SGC_mat)
SGC_clust <- hclust(SGC_dist, method = "average")
plot(SGC_clust)
SGC_dendrogram <- as.dendrogram(SGC_clust)
plot(SGC_dendrogram, type = "rectangle", ylab = "Distance: 1-SGC")

GLK_mat[is.na(GLK_mat)] <- 0 # replace SGC = NA for 0 for clustering
GLK_dist <- as.dist(1-GLK_mat)
GLK_clust <- hclust(GLK_dist, method = "average")
plot(GLK_clust)
GLK_dendrogram <- as.dendrogram(GLK_clust)

SSGC_mat[is.na(SSGC_mat)] <- 0 # replace SGC = NA for 0 for clustering
SSGC_dist <- as.dist(1-SSGC_mat)
SSGC_clust <- hclust(SSGC_dist, method = "average")
plot(SSGC_clust)
SSGC_dendrogram <- as.dendrogram(SSGC_clust)

## combi
# SGC  versus GLK
SGC_GLK_d_combi <- dendlist(SGC_dendrogram, GLK_dendrogram)
tanglegram(SGC_GLK_d_combi, sort = TRUE, common_subtrees_color_lines = TRUE,
           highlight_distinct_edges  = FALSE, highlight_branches_lwd = FALSE,
           main_right = "GLK", main_left = "SGC", cex_main = 1.5,
           columns_width = c(5, 2, 5),margin_inner = 4)
