# Environment preparation

library(pheatmap)
library(RColorBrewer)
library(ggplot2)
library(tidyr)
library(dplyr)

# Loading the dataset
df <- read.csv("heatmap.csv", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)

# Command not to include first column header as data and matrix preparation
df_numeric <- df[, -1]
df_mat <- as.matrix(df_numeric)

rownames(df_mat) <- df$Strain

# Here i have (microgram symbol in my dataset), iconv convert this and other types of 
# characters to UTF-8 to visualize in graph)

colnames(df_mat) <- iconv(colnames(df_mat), from = "", to = "UTF-8", sub = "u")

# Basic heatmap
pheatmap(df_mat, 
         cluster_rows = TRUE, cluster_cols = TRUE,
         clustering_distance_cols = 'euclidean',
         clustering_distance_rows = 'euclidean',
         clustering_method = 'ward.D')
# Expand margin
pheatmap(df_mat,
         cluster_rows = TRUE, cluster_cols = TRUE,
         clustering_distance_cols = 'euclidean',
         clustering_distance_rows = 'euclidean',
         clustering_method = 'ward.D',
         angle_col = 90,
         fontsize_row = 8,
         fontsize_col = 8,
         treeheight_row = 30,   # control dendrogram space
         treeheight_col = 30)
# Enhanced heatmap with better formatting
pheatmap(df_mat,
         cluster_rows = TRUE, 
         cluster_cols = TRUE,
         clustering_distance_cols = 'euclidean',
         clustering_distance_rows = 'euclidean',
         clustering_method = 'ward.D',
         angle_col = 0,
         fontsize_row = 8,
         fontsize_col = 8,
         treeheight_col = 30,  # control column dendrogram height
         treeheight_row = 30,  # control row dendrogram height
         col = brewer.pal(10, 'RdYlGn'),
         legend = FALSE,
         main = "Antibiotic resistance profiling of isolated pathogens")
# With legend
pheatmap(df_mat,
         cluster_rows = TRUE, 
         cluster_cols = TRUE,
         clustering_distance_cols = 'euclidean',
         clustering_distance_rows = 'euclidean',
         clustering_method = 'ward.D',
         fontsize_row = 7,
         fontsize_col = 7,
         treeheight_col = 30,  # control column dendrogram height
         treeheight_row = 30,  # control row dendrogram height
         col = brewer.pal(10, 'RdYlGn'),
         main = "Antibiotic resistance profiling of isolated pathogens")

# Heatmap with Annotation 

pathogen_info <- read.csv("Pathogen_info.csv", stringsAsFactors = FALSE)
pathogen_annotation <- pathogen_info
rownames(pathogen_annotation) <- pathogen_annotation$Strain
pathogen_annotation <- pathogen_annotation[, -1, drop = FALSE]

pathogen_colors <- list(
  Pathogen = c("Salmonella spp." = "#1f77b4", 
               "E.coli" = "#ff7f0e", 
               "Pseudomonas spp." = "#2ca02c", 
               "Klebsiella spp." = "#5E2A72")
)


pheatmap(df_mat,
         cluster_rows = TRUE, 
         cluster_cols = TRUE,
         clustering_distance_cols = 'euclidean',
         clustering_distance_rows = 'euclidean',
         clustering_method = 'ward.D',
         fontsize_row = 7,
         fontsize_col = 7,
         treeheight_col = 30,  # control column dendrogram height
         treeheight_row = 30,  # control row dendrogram height
         col = brewer.pal(10, 'RdYlGn'),
         annotation_row = pathogen_annotation,
         annotation_colors = pathogen_colors,
         main = "Antibiotic resistance profiling of isolated pathogens",
         cellwidth = 20,
         cellheight = 10)
