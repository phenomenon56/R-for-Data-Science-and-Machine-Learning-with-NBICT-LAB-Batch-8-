# Importing the dataset
housetasks = read.delim("housetasks.txt", row.names = 1)

# Contingency table visualization using the function ballonplot
# ballonplot draws a graphical matrix where each cell contains a dot 
# whose size refelcts therelative magnitude of the corresponding component

# Way 1: Ballon Plot
# install.packages("gplots")
library(gplots)
dt = as.table(as.matrix(housetasks))
balloonplot(t(dt), main = "Housetasks Visualization",
            label = F, show.margins = F, xlab = "", ylab = "")

# Contingency table visualization using the function mosaic plot
# Way 2: Mosaic plot (built-in R package graphics)
library("graphics")
mosaicplot(dt, shade = T, las = 2, main = "Housetasks")
# Blue colour indicates that the observed value is higher than the expected value
# Red colour indicates that the observed value is lower than the expected value
# observed value: what we see in dataset
# expected value: win-win situation: Here four case, so 25% for each case is expected value
# Chi-square compares between observed and expected value
# Computing the chi-square test in R
chisq <- chisq.test(housetasks)
chisq

# Observed counts
chisq$observed

# Expected counts
round(chisq$expected,2) # for 2 decimal value



