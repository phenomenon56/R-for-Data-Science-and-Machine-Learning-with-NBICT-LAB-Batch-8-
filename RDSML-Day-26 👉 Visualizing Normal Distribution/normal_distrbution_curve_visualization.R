# Installing the visualize package
# install.packages("visualize")
library(visualize)

# Visualize normal distribution
pnorm(-1.96)

# Visualizing left tail
visualize.norm(stat = -1.96)

# Visualizing right tail
visualize.norm(stat = 1.96, section = "upper")

# Visualizing between a range
visualize.norm(stat = c(-1.96, 1.96), section = "bounded")

# Visualizing outrange (out of -1.96 and 1.96)
visualize.norm(stat = c(-1.96, 1.96), section = "tails")

# Visualization of some range (between and out)
visualize.norm(stat = c(-1, 1), section = "bounded")
visualize.norm(stat = c(-3, 3), section = "bounded")
visualize.norm(stat = c(-3, 3), section = "tails")

# Example with practical data
pnorm(2)
1- pnorm(2)

# When mean = 77, standard deviation = 1, chance/probability of >77?
visualize.norm(stat = 77, mu = 75, sd =1, section = "upper")

# When mean = 77, standard deviation = 1, chance/probability of <77?
visualize.norm(stat = 77, mu = 75, sd =1, section = "lower")

# with pnorm without visualization <77
pnorm(77, mean =75, sd =1)

# with pnorm without visualization >77
1-pnorm(77, mean =75, sd =1)
