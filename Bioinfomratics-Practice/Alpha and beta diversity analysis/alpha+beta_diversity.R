# install.packages(c("vegan", "pheatmap"))
library(vegan)
library(ggplot2)
library(pheatmap)
library(RColorBrewer)

# Load gene presence/absence matrix
pa <- read.table("gene_presence_absence.Rtab", header = TRUE, row.names = 1, sep = "\t", check.names = FALSE)

# Transpose to have samples as rows (needed for vegan)
otu <- t(pa)

# Gene richness (how many genes per genome)
alpha_richness <- rowSums(otu > 0)

# Shannon diversity (optional)
alpha_shannon <- diversity(otu, index = "shannon")


# Combine into one table
alpha_div <- data.frame(
  Genome = rownames(otu),
  Richness = alpha_richness,
  Shannon = alpha_shannon
)

print(alpha_div)

# Jaccard distance (presence/absence based)
beta_jaccard <- vegdist(otu, method = "jaccard")


# Hierarchical clustering
hc <- hclust(beta_jaccard)
plot(hc, main = "Beta Diversity (Jaccard - Panaroo)")

# PCoA (ordination)
pcoa <- cmdscale(beta_jaccard, eig = TRUE, k = 2)
plot(pcoa$points, type = 'n', main = "PCoA of Beta Diversity")
text(pcoa$points, labels = rownames(otu))

# Optional Heatmap of Gene Sharing
pheatmap(as.matrix(otu),
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_rownames = TRUE,
         show_colnames = FALSE,
         color = colorRampPalette(brewer.pal(9, "Blues"))(100))


# color samples by group in PCoA (optional)
meta <- read.table("metadata.tsv", sep="\t", header=TRUE, row.names=1)
group <- meta[rownames(otu), "Group"]
plot(pcoa$points, col=as.factor(group), pch=19)
legend("topright", legend=levels(as.factor(group)), col=1:length(unique(group)), pch=19)


