# rbinom() with explanation
# Syntax: rbinom(n, size, prob) generate random numbers from a binomial distribution
# Here:
# n: number of random values to generate
# size: Number of trials in each binomial experiment
# prob: Probability of success in each trial

rbinom(n=10, size = 1, prob = 0.5)
# Here:
# 10 --> Number of random values to generate (n=10)
# 1 --> Number of trials in each binomial experiment (size =1)
# 0.5 --> Probability of success on each trial (prob =0.5)

rbinom(n=10, size = 5, prob = 0.5)

# pbinom() with explanation
# pbinom() gives the cumulative probability of getting q or fewer successes 
# in a binomial disribution
# Syntax:pbinom(q, size, prob)
# Here:
# q --> The number of successes
# size --> Number of trials
# prob --> probability of success in each trial

pbinom(q =5, size = 10, prob = 0.5)

# The result means there's about a 62.3% chance of getting 5 or fewer successes in 10 trials
# (e.g- getting 5 or fewer heads in 10 fair coin tosses)

# You toss a coin 5 times, what is the probability of getting  exactly 3 heads

pbinom(q=3, size =5, prob =0.5)-pbinom(q=2, size =5, prob =0.5)


# qbinom() with explanation
# What is the smallest number of successes x in 10 trials 
# (with 50% success chance) such that probability of getting x or fewer 
# successes is at least 30%?

qbinom(p =0.30, size = 10, prob = 0.5)

# Here:
# p =0.30 --> cumulative probability (30%)
# size = 10 --> number of trials (e.g., 10 coin tosses)
# prob =0.5 --> probability of success

# dbinom() with explanation
# Calculating the probability of getting exact number of success

# You toss a coin 5 times, what is the probability of getting  exactly 3 heads
dbinom(x =3, size =5, prob = 0.5)

# dbinom(x, size, prob)
# x = 3 --> number of successes you want (exactly)
# size =5 --> number of indenpendent trials
# prob = 0.5 --> probability of success in each trial





