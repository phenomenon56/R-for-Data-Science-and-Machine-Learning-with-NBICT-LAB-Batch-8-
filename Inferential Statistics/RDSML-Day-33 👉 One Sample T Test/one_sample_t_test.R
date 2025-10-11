# Importing the dataset
myData <- read.csv("bottle_data.csv")

# Checking the normality (Shapiro-Wilk Test-p value should be >0.05)

shapiro.test(myData$value)


# One-Sample T Test in R
t.test(x = myData$value, mu = 150)