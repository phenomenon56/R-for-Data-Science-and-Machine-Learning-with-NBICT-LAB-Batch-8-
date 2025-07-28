# The rnorm() function
x = rnorm(10000, mean =0, sd =1)
x
mean(x)
sd(x)

y = rnorm(100, mean =100, sd =3)
y
mean(y)
sd(y)

# The pnorm() function

# At Z = 0 then the value of probability is 0.5
pnorm(0)
pnorm(-1.96)
pnorm(-1.64)

# The qnorm() function
qnorm(0.5)
qnorm(0.025)


# The dnorm() function
#  Y axis value for z = 0
dnorm(0)

# Using dnorm() to draw the normal distribution
Zvalues = seq(-4.0, 4.0, by = 0.1)
Zvalues
dvalues = dnorm(Zvalues)
dvalues


plot(Zvalues, dvalues)
