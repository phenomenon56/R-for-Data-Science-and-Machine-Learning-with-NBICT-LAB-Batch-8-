# install.packages("hierfstat")
library("hierfstat")
library("adegenet")

# Lets load the fasta file by extract only the SNPs
seq.snp = fasta2DNAbin('core.full.aln', snpOnly=T)
obj = DNAbin2genind(seq.snp)

# Load the meta file that contains population structure 
meta <- read.table('meta.csv', sep=',', header = T)

# Add the structure I want to test in the GenInd object
obj$pop = as.factor(meta[match(rownames(obj$tab), meta$Strain),]$SamplingSite)

# Convert genind object into hierfstat object
obj.hf = genind2hierfstat(obj)

# Various estimation of Fst
genet.dist(obj.hf, method='Nei87', diploid=F)
genet.dist(obj.hf, method='Dch', diploid=F)