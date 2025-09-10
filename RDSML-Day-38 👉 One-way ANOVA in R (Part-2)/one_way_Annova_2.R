# Importing the dataset
PlantGrowth <- PlantGrowth

# Importing the dplyr library
library(dplyr)

# Computing the group means, sd, and se
stats <- PlantGrowth %>%
  group_by(group) %>%
  summarise(
    mean = mean(weight),
    sd = sd(weight),
    se = sd(weight) / sqrt(n())
  )
print(stats)

# Visualization by creating groupwise boxplots and meanplots
# boxplot
boxplot(weight ~ group, 
        data = PlantGrowth, 
        main = "PlantGrowth data",
        ylab = "Dried weight of plants", 
        col = "lightgray"
       )
# meanplot
# install.packages("ggpubr")
library(ggpubr)
ggline(PlantGrowth,
       x = "group",
       y = "weight",
       add = c("mean_se", "jitter")
       )
# Running the One-way Annova test
anova <- aov(weight ~ group, data = PlantGrowth)
summary(anova)

# Tukey multiple pairwise-comparisons (kind of post-hoc test)
# if ANOVA test with no assumption of equal variances (p-value) is < 0.05
TukeyHSD(anova)

# Homogeneity of variances
plot(anova, 1)
library(car)
leveneTest(weight ~ group, data = PlantGrowth)

# ANOVA test with no assumption of equal variances
oneway.test(weight ~ group, data = PlantGrowth)

# Pairwise t-tests with no assumption of equal variances
# if not maintained homogeneity of variance
pairwise.t.test(PlantGrowth$weight, PlantGrowth$group,
                p.adjust.method = "BH", pool.sd = F)

# Checking for Normal Distribution
plot(anova, 2)

# Extracting the residuals
aov_res <- residuals(object = anova)
aov_res

# Running the Shapiro-Wilk test
shapiro.test(aov_res)

# if data is normally ditributed, but variances are not same
# we need to use only weltch test 
# kruskal test is only done if the normality assumption not met

kruskal.test(weight ~ group, data = PlantGrowth)
pairwise.wilcox.test(PlantGrowth$weight, PlantGrowth$group,
                     p.adjust.method = "BH")