# install.packages("adegenet")
library("adegenet")
library("ggplot2")

snp <- fasta2genlight('core.full.aln', snpOnly=T)
meta <- read.table('meta.csv', sep=',', header = T)

snp$ploidy

snp$pop = as.factor(meta[match(snp$ind.names, meta$Strain),]$SamplingSite)

# Heat map of genotype
glPlot(snp)

# PCA_basic
pca <- glPca(snp, nf=10)
barplot(100*pca$eig/sum(pca$eig), main="Eigenvalues", col=heat.colors(length(pca$eig)))

# PCA_classic
pca_full <- glPca(snp, nf = nInd(snp))  # or use nf=500 to be safe
barplot(100 * pca_full$eig / sum(pca_full$eig), 
        main = "Eigenvalues", 
        col = heat.colors(length(pca_full$eig)),
        border = NA)

# fast plot
scatter(pca, psi='bottomright')

# Optimization of the plot

pca.dataset = as.data.frame(pca$scores)
pca.dataset$isolates = rownames(pca.dataset)
pca.dataset$pop = as.factor(meta[match(snp$ind.names, meta$Strain),]$SamplingSite)
pca.dataset$spp = as.factor(meta[match(snp$ind.names, meta$Strain),]$Species)

ggplot(pca.dataset, aes(PC1, PC2, fill=spp)) + geom_point(shape=21, size=3, alpha=0.7)
ggplot(pca.dataset, aes(PC1, PC3, fill=spp)) + geom_point(shape=21, size=3, alpha=0.7)




