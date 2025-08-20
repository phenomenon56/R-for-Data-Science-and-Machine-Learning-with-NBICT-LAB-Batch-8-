# One_Sample_Z_test

# install.packages("BSDA")
library(BSDA)

# importing the dataset
dataset <- read.csv("Perfume.csv")
mean(dataset$Machine.1)

# One-tailed/upper test/if sample mean is significantly upper than population mean
# when population mean =150, sd =2

z.test(x = dataset$Machine.1,
       alternative = "greater", 
       mu = 150, 
       sigma.x = 2)