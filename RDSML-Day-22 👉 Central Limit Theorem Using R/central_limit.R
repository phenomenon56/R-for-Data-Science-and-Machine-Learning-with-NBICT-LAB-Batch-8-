# What is a uniform distribution?
# What is a normal distribution?

# Demonstration of CLT in R

# Generating  10000 numbers of uniform distribution
r=runif(10000)
hist(r)
meanr=mean(r)
sdr=sd(r)

# Draw three random samples from the distribution
samples1=sample(r,4)
samples2=sample(r,4)
samples3=sample(r,4)

mean(samples1)
mean(samples2)
mean(samples3)

# Run a For loop in R
cl100=mean(sample(r,100))
cl100

for (i in 1:1000){
  cl100 <- c(cl100, mean(sample(r,100)))
}

hist(cl100)
