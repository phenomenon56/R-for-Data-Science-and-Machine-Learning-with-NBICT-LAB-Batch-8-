# install.packages('data.table')
library(data.table)
library(dplyr)
library(ggplot2)
# install.packages('doParallel')
library(doParallel)
# install.packages('ggpubr')
library(ggpubr)

PIRATE.gene_families = as.data.frame(fread("PIRATE.gene_families.ordered.tsv"))
PIRATE.gene_families$number_genomes <- 0 
PIRATE.gene_families$number_genomes <- rowSums( !(PIRATE.gene_families[ , 23:length(colnames(PIRATE.gene_families))] == "") )
PIRATE.gene_families <- PIRATE.gene_families[ which(PIRATE.gene_families$number_genomes > 0), ]
head(PIRATE.gene_families)
gene_total <- colSums( !(PIRATE.gene_families[ , 23:length(colnames(PIRATE.gene_families))] == ""))
summary(as.vector(gene_total)) 
sd(gene_total)
hist(gene_total)

n_gene_fams<-  nrow(PIRATE.gene_families)
n_gene_fams

cols_to_exclude <- c("allele_name", "gene_family", "consensus_gene_name", "consensus_product", "threshold", "alleles_at_maximum_threshold", "number_genomes", "average_dose", "min_dose", "max_dose", "genomes_containing_fissions", "genomes_containing_duplications", "number_fission_loci",                    "number_duplicated_loci", "no_loci", "products",                    "gene_names", "min_length(bp)", "max_length(bp)",                    "average_length(bp)", "cluster", "cluster_order")


strains_only <- PIRATE.gene_families[, !names(PIRATE.gene_families) %in% cols_to_exclude]
strain_names <- names(strains_only)



ngenomes <- length(unique(strain_names))
ngenomes



n_gene_fams_core_all <- sum(PIRATE.gene_families$number_genomes == ngenomes)
n_gene_fams_core_all





n_gene_fams_core_all <- sum(PIRATE.gene_families$number_genomes == ngenomes)
n_gene_fams_core_all



core_all_percentage <- (n_gene_fams_core_all * 100) / n_gene_fams
core_all_percentage

cutoff <- round(.95* ngenomes)

n_gene_fams_core_w95per <- sum(PIRATE.gene_families$number_genomes >= cutoff)
n_gene_fams_core_w95per


core_gene_percentage <- (n_gene_fams_core_w95per * 100) / n_gene_fams
core_gene_percentage



n_gene_fams_singletons <- sum(PIRATE.gene_families$number_genomes == 1)
n_gene_fams_singletons


accesory_gene_percentage <- (n_gene_fams_singletons*100)/n_gene_fams
accesory_gene_percentage




n_accessory <- n_gene_fams - (n_gene_fams_singletons + n_gene_fams_core_w95per)
n_accessory


(n_accessory*100)/n_gene_fams


n_accessory / ngenomes


# Visualize the distribution of gene presence in a gene family (distribution of core to accessory genes)

# Prepare dataframe for plotting
gene_fam_totals <-as.data.frame(PIRATE.gene_families$number_genomes)

colnames(gene_fam_totals) <- 'count'

# Categorize gene groups
gene_fam_totals$group = 0

for (i in 1:nrow(gene_fam_totals)){  
  if (gene_fam_totals$count[i] == 1) {
    gene_fam_totals$group[i] = "Singleton"  
  } else if (gene_fam_totals$count[i] >= .95*ngenomes){
    gene_fam_totals$group[i] = "Core"  
  } else {
    gene_fam_totals$group[i] = "Accessory"  
  }
}

p1 <- gene_fam_totals %>%  ggplot(aes(x = count)) +  
  geom_bar(aes(fill = group), position = "identity") +  
  ggtitle("Pangenome Distribution by gene ortholog group") +  
  ylab("n gene families") + 
  xlab("n genomes in family") +  
  theme_classic() +  
  theme(plot.title = element_text(size=15), legend.title = element_blank(), legend.position.inside = c(0.85, 0.85)) +  
  scale_fill_manual(name = "", values = c("blueviolet", "coral",  "darkcyan")) +          
  theme_minimal()
p1

# Compute percentages
fam_dist_df$fraction <- fam_dist_df$count / sum(fam_dist_df$count)




