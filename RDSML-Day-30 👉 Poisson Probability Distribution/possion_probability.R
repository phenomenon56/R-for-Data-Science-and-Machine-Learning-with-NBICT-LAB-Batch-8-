# a call center receives on average 5 calls per hour
# What is the probability that exactly 3 calls come in during the next hour?

ppois(q = 3,lambda = 5)-ppois(q =2, lambda = 5)

dpois(x = 3, lambda = 5)

# probability of getting 0 t0 5 calls
n = seq(0,5)
n
dpois(x = n, lambda = 5)

# plotting
barplot(dpois(x = n, lambda = 5))

# probability of <4 calls if each hour receives 10 calls on average
library(visualize)
visualize.pois(stat = 4, lambda = 10)

# probability of >8 calls if each hour receives 10 calls on average
visualize.pois(stat = 8, lambda = 10, section = "upper")

# probability of (4-6) calls if each hour receives 10 calls on average
visualize.pois(stat = c(4,6), lambda = 10, section = "bounded")

# chatgpt problem solution  with code
visualize.pois(stat = c(3,3), lambda = 5, section = "bounded")

# probability of x<2 or X>5
visualize.pois(stat = c(2,5), lambda = 5, section = "tails")