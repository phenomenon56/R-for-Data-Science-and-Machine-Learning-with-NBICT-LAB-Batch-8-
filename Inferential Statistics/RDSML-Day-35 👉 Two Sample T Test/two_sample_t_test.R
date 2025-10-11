# Two sample T test/Independent sample T test
# Loading the dataset
dataset = read.csv("scores.csv")

# Checking the normal distribution
shapiro.test(dataset$Male)
shapiro.test(dataset$Female)

# Checking for the homogeneity of variances
var.test(x = dataset$Male, y = dataset$Female)

# Running the independent sample T test
t.test(x = dataset$Male, y = dataset$Female, var.equal = T)

# Result should be represented in APA style + box plot