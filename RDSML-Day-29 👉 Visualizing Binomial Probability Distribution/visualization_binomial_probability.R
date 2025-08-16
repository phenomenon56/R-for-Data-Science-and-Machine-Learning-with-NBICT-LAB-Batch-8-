# Recalling previous class functions:
dbinom(x =4, size = 10, prob =0.5)
pbinom(q =4, size =10, prob=0.5)

# Making barplot with probability
n = c(0:10)
n

p = dbinom(x = n, size =10, prob = 0.5)
barplot(p)

# Visualizing binomial distribution using the visualize package
library(visualize)
visualize.binom(stat = 4, size = 10, prob = 0.5, section = 'lower')
# here:
# section = 'lower'

# Testing p value of visualization with function
pbinom(q =4, size =10, prob = 0.5)

# Probability of 4 or more than 4
visualize.binom(stat = 4, size = 10, prob = 0.5, section = 'upper')

# Probability of (4<_x<_6)
visualize.binom(stat = c(4,6), size = 10, prob = 0.5, section = 'bounded')

# Probability of (x<_3 or x>_7)
visualize.binom(stat = c(3,7), size = 10, prob = 0.5, section = 'tails')

# Probability of (x<_4)
visualize.binom(stat = c(4,4), size = 10, prob = 0.5, section = 'bounded')

# Visualization with gridline
grid(nx = NULL, ny = NULL, col = "grey", lty = "dotted")



