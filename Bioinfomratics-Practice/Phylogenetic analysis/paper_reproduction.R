# 1.Necessary packages
#library(ggtree)
#library(phangorn)
#library(ape)
#library(BiocManager)
#library(Biocversion)
#library(ggplot2)
#library(ggtree)
#library(mgcv)
#library(phangorn)
#library(treeio)
#library(viridis)
#install.packages("ggnewscale")
#library(ggnewscale)


# 2.Creating a basic phylogenetic tree

sal.tree = read.tree('test_salmonella_with_ERRiiiiiiiiiiiii_outgroup3.nex.treefile')
sal.meta = read.table('metadata.csv', sep=',', header=T)

sal.tree = midpoint(sal.tree)

sal.tree = read.iqtree ('test_salmonella_with_ERRiiiiiiiiiiiii_outgroup3.nex.treefile')
sal.tree@phylo = midpoint(sal.tree@phylo)
plot(sal.tree@phylo)


# 3.Ornamenting phylogenetic tree with metadata
t1 = ggtree(sal.tree) %<+% sal.meta +
  geom_tippoint(aes(color = Source), size = 2)
t1

# 4.Circular phylogenetic tree
t1 = ggtree(sal.tree, layout="circular") %<+% sal.meta +
  geom_tippoint(aes(color = Source), size = 2)

t1

# 5.Add bootstrap support

t1$data$bootstrap <- '0'

t1$data[which(t1$data$SH_aLRT >= 70 & t1$data$UFboot  >= 70),]$bootstrap <- '1'


t1 <- t1 + new_scale_color() +
  
  geom_tree(aes(color=bootstrap == '1')) +
  
  scale_color_manual(name='Bootstrap', values=setNames( c('black', 'grey'), c(T,F)), guide = "none")

t1

# 6.Showing metadata in heatmap

# dataframe generation

meta.Susceptiblity <- as.data.frame(sal.meta[,'Susceptiblity'])
colnames(meta.Susceptiblity) <- 'Susceptiblity'
rownames(meta.Susceptiblity) <- sal.meta$Strain

meta.year <- as.data.frame(sal.meta[,'Year'])
colnames(meta.year) <- 'Year'
rownames(meta.year) <- sal.meta$Strain

# 7.Heatmap generation

# Categorical variable
t2 <- gheatmap(t1, meta.Susceptiblity, width = 9, offset = 0.51) + 
  scale_fill_viridis_d(option="A", name="Susceptiblity") +
  new_scale_fill()

# Continuous variable
t2 <- gheatmap(t2, meta.year, width= 7, offset=0.81) + 
  scale_fill_viridis(option="D", name="Year")

# 8.Plot tiplab2

t2 + geom_tiplab2(aes(label=Country), color="gray40", offset=0.06, size=3)













