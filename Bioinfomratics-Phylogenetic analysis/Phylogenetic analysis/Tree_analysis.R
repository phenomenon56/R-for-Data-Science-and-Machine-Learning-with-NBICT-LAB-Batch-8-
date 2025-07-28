dir.create("C:/Users/Irfan/Desktop/Rlibs", showWarnings = FALSE)
.libPaths("C:/Users/Irfan/Desktop/Rlibs")
#install.packages("mgcv")
library(mgcv)
#install.packages("BiocManager")
library(BiocManager)
BiocManager::install("ggtree")
library(ape)
tree = read.tree("C:\\Users\\Irfan\\Downloads\\labeled_example_tree.nwk")

tree

meta = read.csv("C:\\Users\\Irfan\\Downloads\\phylogeny_data.csv", header = TRUE)
head(meta)

plot(tree)
#install.packages("phangorn")
library(phangorn)

tree = midpoint(tree)
plot(tree)
tree$tip.label


t1= ggtree(tree, layout = 'circular') %<+% meta +
  geom_tippoint(aes(color = Host))+
  geom_tiplab(aes(x= x+0.1))
BiocManager::install("treeio")
library(treeio)
#install.packages("viridis")
#install.packages("ggnewscale")
head(meta)
meta.water = as.data.frame (meta[1, 'Host'])
meta.water
rownames(meta.water)= meta$Strain_Name
colnames(meta.water) = 'Water'

head(meta)
meta$Strain_Name
gheatmap(t1, meta.water)
