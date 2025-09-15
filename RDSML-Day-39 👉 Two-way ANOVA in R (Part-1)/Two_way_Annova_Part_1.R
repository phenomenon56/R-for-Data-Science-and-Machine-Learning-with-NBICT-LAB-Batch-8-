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


