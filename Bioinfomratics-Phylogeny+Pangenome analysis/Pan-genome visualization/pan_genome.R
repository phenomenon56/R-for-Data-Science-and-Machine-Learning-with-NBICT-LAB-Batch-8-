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

#make df of totals
fam_dist_df <- data.frame(
  category=c("Singleton", "Accessory", "Core"),
  count=c(n_gene_fams_singletons, n_gene_fams -(n_gene_fams_singletons + n_gene_fams_core_w95per), n_gene_fams_core_w95per)
)

# Compute percentages
fam_dist_df$fraction <- fam_dist_df$count / sum(fam_dist_df$count)
fam_dist_df$fraction

#Compute the cumulative percentages (top of each rectangle)
fam_dist_df$ymax <- cumsum(fam_dist_df$fraction)
fam_dist_df$ymax

# Compute the bottom of each rectangle
fam_dist_df$ymin <- c(0, head(fam_dist_df$ymax, n=-1))
fam_dist_df$ymin


# Compute label position
fam_dist_df$labelPosition <- (fam_dist_df$ymax + fam_dist_df$ymin) / 2
fam_dist_df$labelPosition

# Compute a good label
fam_dist_df$label <- paste0(fam_dist_df$category, "\n", fam_dist_df$count)
fam_dist_df$label



# Plot
p2 <- ggplot(fam_dist_df, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=category)) +  
  geom_rect() +  
  geom_text( x=1.5, aes(y=labelPosition, label=label, color=category), size=4) + 
  # x here controls label position (inner / outer)  
  scale_fill_manual(values=c("blueviolet", "coral",  "darkcyan")) +  
  scale_color_manual(values=c("blueviolet", "coral",  "darkcyan")) +  
  coord_polar(theta="y") +  xlim(c(-1, 4)) +  theme_void() +
  theme(legend.position = "none")

p2

# Gene Accumulation Curve

binary_df <- strains_only %>%   mutate_all(~ as.numeric(nzchar(.)))
binary_df

count_all_ones <- function(df) {  
  num_cols <- ncol(df)  
  count_cases <- df %>%    
    filter(rowSums(.) == num_cols) %>%                                    
    nrow()  
  return(count_cases)}

count_all_ones

find_common_genes <- function(df, cols) {  
  common_genes <- count_all_ones(df[cols])
  return(common_genes)}

# Initialize dataframe to store results
results <- data.frame(  NumGenomes = integer(),  CommonGenes = integer(),  TotalGenes = integer())

# Initialize an empty list to store results
result_list <- list()

library(parallel)

# Setup parallel backend to use many processorscores=detectCores()

cores <- detectCores()
cl <- makeCluster(cores - 2) #not to overload your computer
registerDoParallel(cl) 

# Generate combinations and count common genes
# Initialize an empty list to store results

for(num_genomes in 2:ncol(binary_df)) {  
  rand_combs <- replicate(1000, sample(names(binary_df), num_genomes), simplify = FALSE)
  print(num_genomes)  
  
  local_results <- foreach(i = 1:length(rand_combs), .combine = rbind, .packages = 'dplyr') %dopar% {    
    common_genes_count <- find_common_genes(binary_df, rand_combs[[i]])    
    tota_genes_count <- sum(rowSums(binary_df[rand_combs[[i]]]) > 0)    
    data.frame(NumGenomes = num_genomes, CommonGenes = common_genes_count, TotalGenes = tota_genes_count)  }  
  result_list[[num_genomes - 1]] <- local_results  # Store results in list
}

# Stop the parallel backend
stopCluster(cl)

# Combine all results into one data frame
results <- do.call(rbind, result_list)

# Fit power law

# Log-transform the data

results <- results %>%   
  mutate(log_NumGenomes = log(NumGenomes), log_CommonGenes = log(CommonGenes), log_TotalGenes = log(TotalGenes))

head(results)

#Fit a linear model to the log-transformed data
lm_model_common <- lm(log_CommonGenes ~ log_NumGenomes, data = results)
lm_model_all <- lm(log_TotalGenes ~ log_NumGenomes, data = results)

# Get the coefficients
coefficients_common <- coef(lm_model_common)
intercept_common <- coefficients_common[1]
slope_common <- coefficients_common[2]

coefficients_all <- coef(lm_model_all)
intercept_all <- coefficients_all[1]
slope_all <- coefficients_all[2]

# Create a data frame with the fitted power-law curve
fitted_curve <- results %>%
  mutate(FittedCommonGenes = exp(intercept_common) * NumGenomes^slope_common)

# Estimate core genome size based on the accumulation curve
core_genome_size <- exp(intercept_common) * max(results$NumGenomes)^slope_common

fitted_curve <- fitted_curve %>%  
  mutate(FittedAllGenes = exp(intercept_all) * NumGenomes^slope_all)

p3 <- ggplot(results, aes(x = NumGenomes, y = CommonGenes)) +  
  geom_point(aes(color = "Common Genes"), size = 3) +  
  geom_line(data = fitted_curve, aes(x = NumGenomes, y = FittedCommonGenes, color = "Fitted Curve"), size = 1) +  
  scale_color_manual(name = "",                     values = c("Common Genes" = "grey", "Fitted Curve" = "red")) +  
  labs(title = "Core Gene Accumulation Curve",       x = "Number of Genomes Compared",       y = "Number of Common Genes") +  
  theme_minimal() +  
  theme(legend.position = c(0.95, 0.95),  legend.justification = c("right", "top"))

p3



p4 <- ggplot(results, aes(x = NumGenomes, y = TotalGenes)) +  
  geom_point(aes(color = "Total Genes"), size = 3) +  
  geom_line(data = fitted_curve, aes(x = NumGenomes, y = FittedAllGenes, color = "Fitted Curve"), size = 1) +  
  scale_color_manual(name = "",                     values = c("Total Genes" = "grey", "Fitted Curve" = "red")) +  
  labs(title = "Pan Genome Accumulation Curve",       x = "Number of Genomes Compared",       y = "Number of Total Genes") +  
  theme_minimal() +  
  theme(legend.position = c(0.95, 0.05), legend.justification = c("right", "bottom"))

p4








































