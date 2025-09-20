# installing Packages
#install.packages(c("tidyverse", "car", "emmeans", "effectsize", "performance", "broom", "kableExtra"))
#install.packages("emmeans")
#install.packages("kableExtra")
library(tidyverse)
library(dplyr)

# Importing the dataset
d <- read.csv("cropdata.csv")

# Quick Exploratory Descriptive Analysis
summs <- d %>%
  group_by(fert, irr) %>%
  summarise(mean = mean(y), se = sd(y)/sqrt(n()), .groups = "drop")
  
# Quick Data Summary Visualization
library(ggplot2)
ggplot(summs, aes(irr, mean, group = fert))+
  geom_line() +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = mean-se, ymax = mean+se), width = 0.2) +
  facet_wrap(~fert, nrow = 1) +
  labs(x = "Irrigation", y = "Mean yield",
       title = "Interaction of Fertilizer x Irrigation") +
  theme_classic(base_size = 12)

# Fit the Model/Interaction between two variables
m <- aov(y ~ fert + irr + fert*irr, data = d)
summary(m)

# Assumptions Visual checks
par(mfrow=c(2,2))
plot(m)
par(mfrow=c(1,1))

# Shapiro-Wilk on Residuals (Normality)
res <- residuals(m)
shapiro.test(res)

# Levene's test for equal variances
library(car) 
leveneTest(y ~ fert*irr, data =d, center = median)

# Post‑hoc & simple‑effects with emmeans/
# Interaction contrasts(simple effects): effect of fert at each level of irr
library(emmeans)
contrast(emmeans(m, ~ fert | irr), method = "pairwise", adjust = "tukey")

# Post‑hoc & simple‑effects with emmeans/
# Interaction contrasts(simple effects): effect of irr at each level of fert
library(emmeans)
contrast(emmeans(m, ~ irr | fert), method = "pairwise", adjust = "tukey")

# Main‑effect comparisons (only if interaction is negligible/
# considering 1 variable constant (e.g-irrigation here)
contrast(emmeans(m, ~fert), method = "tukey")

# Main‑effect comparisons (only if interaction is negligible/
# considering 1 variable constant (e.g- fertilization here)
contrast(emmeans(m, ~irr), method = "tukey")

# CLD (Compact Letter Display) Letters
library
# install.packages("TH.data", repos = "https://cran.rstudio.com/")
# install.packages("multcomp")
# install.packages("multcompView")
library(multcomp)
library(multcompView)
library(emmeans)
library(emmeans) 
library(multcomp)
group_letters <- cld(emmeans(m, ~ fert * irr), Letters = letters)
print(group_letters)

