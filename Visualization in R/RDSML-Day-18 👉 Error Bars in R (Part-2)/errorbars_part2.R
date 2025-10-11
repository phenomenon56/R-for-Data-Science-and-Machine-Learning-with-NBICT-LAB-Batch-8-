# Importing the dataset
tooth_data = ToothGrowth

# Creating a function for summarizing the data 
# based on the grouping variables

data_summary = function(data, varname, groupnames){
  require(plyr)
  summary_func = function(x, col){
    c(mean = mean(x[[col]], na.rm = TRUE), sd = sd(x[[col]], na.rm = TRUE))
  }
  all_summary = ddply(data, groupnames, .fun = summary_func, varname)
  data_sum = rename(all_summary, c("mean" = varname))
  return( data_sum)
}

d_summary = data_summary(tooth_data, varname = "len", groupnames = c("supp", "dose"))

# Converting 'dose' to a factor variable
d_summary$dose = as.factor(d_summary$dose)
class(d_summary$dose)

# Standard deviation of the mean as error bar with explanation
library(ggplot2)
ggplot(d_summary, aes(x = dose, y = len, fill = supp)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = len-sd  , ymax = len+sd), width = 0.2, position = position_dodge(0.9)) +
  theme_minimal()

