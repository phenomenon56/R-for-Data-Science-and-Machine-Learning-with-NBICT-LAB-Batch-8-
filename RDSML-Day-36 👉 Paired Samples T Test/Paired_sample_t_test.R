# Importing the dataset
mydataset <- read.csv("paired-samples-t-test.csv")

# Calculating the difference
diffs <- mydataset$carb - mydataset$carb_protein

# Checking if the differences are normally distributed
shapiro.test(diffs)

# Check if any data remains in outliers (how much far from mean) using boxplot
# If the plot showed (*) then reject the dataset
# If the plot showed (.) then consider about the dataset
boxplot(diffs)

# Running the paired t test
t.test(x = mydataset$carb, y = mydataset$carb_protein, paired = T)

# Running the Wilcoxon signed-rank test(if data noy on normal distribution/
# non-equivalent parametric test)
wilcox.test(x = mydataset$carb, y = mydataset$carb_protein, paired = T)

# Calculating mean and sd
mean(mydataset$carb)
sd(mydataset$carb)

mean(mydataset$carb_protein)
sd(mydataset$carb_protein)

# Calculating effect size (how much statistically significant) using Cohen's d 
# 0.2 ~ small, 0.5 ~ medium, 0.8 ~ large

#install.packages("effsize")
library(effsize)
cohen.d(mydataset$carb_protein, mydataset$carb, paired = T)

# APA style writing/representing/interpreting the result
# A paired sample t-test was used to determine whether there was a statistically 
# significant mean difference between the distance ran when participates imbibed a carbohydrate
# protein drink compared to imbibed a carbohydrate only drink
# no outlier was detected
# The assumption of normality was not violated, as assesed by Shapiro-Wilk's test
# (p = 0.780).
# participates ran furthur when imbibing the carbohydrate protein drink 
# (Mean =11.302 KM, sd = 0.713 KM)
# As opposed to the carbohydrate only drink
# (Mean =11.167 KM, sd = 0.726 KM)
# statistically significant mean increase of 0.135 KM, 
# 95% CI (0.091, 0.181), t (19) = 6.352, p < = 0.001
# Cohen's d estimate: 0.186634 (negligible)

