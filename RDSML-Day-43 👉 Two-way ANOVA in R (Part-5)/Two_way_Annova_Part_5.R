# installing Packages
#install.packages(c("tidyverse", "car", "emmeans", "effectsize", "performance", "broom", "kableExtra"))
#install.packages("emmeans")
#install.packages("kableExtra")
or
# install.packages(c(
#   "tidyverse","car","emmeans","effectsize","performance",
#   "broom","broom.helpers","kableExtra","multcomp","multcompView","patchwork"
# ))

library(tidyverse)
library(dplyr)
library(tidyr)
suppressPackageStartupMessages({library(car); library(emmeans); library(effectsize)
  library(performance); library(broom); library(broom.helpers)
  library(kableExtra); library(multcomp); library(multcompView); library(patchwork)
})

# Recommended for Type-III SS (sum-to-zero contrasts)
options(contrasts = c("contr.sum","contr.poly"))
theme_set(theme_classic(base_size = 12))

## ── 1) Import & basic hygiene ----
d <- read.csv("cropdata.csv", stringsAsFactors = FALSE)

# Coerce types safely
d <- d %>%
  mutate(
    y    = as.numeric(y),
    fert = factor(fert),
    irr  = factor(irr)
  ) %>%
  drop_na(y, fert, irr)

# Quick design sanity checks

cat("\nCell counts (balance check):\n")
print(with(d, table(fert, irr)))
cat("\nGroup means (preview):\n")
print(d %>% group_by(fert, irr) %>% summarise(n=dplyr::n(), mean=mean(y), sd=sd(y), .groups="drop"))

## ── 2) EDA: raw + summary plots ----

summs <- d %>%
  group_by(fert, irr) %>%
  summarise(
    n   = dplyr::n(),
    mean= mean(y),
    sd  = sd(y),
    se  = sd/sqrt(n),
    ci  = qt(.975, df=n-1)*se,  # 95% CI
    .groups = "drop"
  )

p_raw <- ggplot(d, aes(irr, y, color=fert)) +
  geom_jitter(width=.08, height=0, alpha=.4) +
  stat_summary(fun=mean, geom="point", position=position_dodge(width=.4), size=2.4) +
  labs(title="Raw data with means", x="Irrigation", y="Yield")

p_ci <- ggplot(summs, aes(irr, mean, group=fert, color=fert)) +
  geom_line(position=position_dodge(width=.3)) +
  geom_point(size=2, position=position_dodge(width=.3)) +
  geom_errorbar(aes(ymin=mean-ci, ymax=mean+ci),
                width=.15, position=position_dodge(width=.3)) +
  labs(title="Means ± 95% CI by Fertilizer × Irrigation", x="Irrigation", y="Mean yield")

(p_raw / p_ci) + plot_annotation(title = "Exploratory view")

## ── 3) Fit model ----
# Type-III ANOVA is robust for unbalanced data (given contr.sum above)

m <- aov(y ~ fert * irr, data = d)
summary(m)

# Publication-ready ANOVA (Type III)

aov_tab <- Anova(m, type = 3) %>%
  tidy() %>%
  mutate(p.value = signif(p.value, 3))

kbl(aov_tab, digits = 3, caption = "Two-way ANOVA") %>%
  kable_classic(full_width = FALSE, html_font = "Times New Roman")


## ── 4) Model diagnostics & assumptions ----
# Visual checks
par(mfrow=c(2,2)); plot(m); par(mfrow=c(1,1))

# Targeted tests (use as guidance, not hard gates)
res <- residuals(m)
shapiro_p <- shapiro.test(res)$p.value
cat("\nShapiro-Wilk p =", signif(shapiro_p,3), "(normality of residuals)\n")

lev <- car::leveneTest(y ~ fert*irr, data = d, center = median)
cat("\nLevene test (median-based) for homogeneity of variance:\n"); print(lev)

# Comprehensive diagnostics (performance)
cat("\nperformance::check_model(m):\n")
print(performance::check_model(m))  # plots/flags common issues

## ── 5) Estimated marginal means (EMMs) & contrasts ----
emm_int <- emmeans(m, ~ fert * irr)

# Simple effects: fert within each irr (with Tukey adj)
fert_within_irr <- contrast(emmeans(m, ~ fert | irr), method = "pairwise", adjust = "tukey")
cat("\nPairwise fert within each irr:\n"); print(fert_within_irr)

# Simple effects: irr within each fert (with Tukey adj)
irr_within_fert <- contrast(emmeans(m, ~ irr | fert), method = "pairwise", adjust = "tukey")
cat("\nPairwise irr within each fert:\n"); print(irr_within_fert)

# Main-effect comparisons (interpret only if interaction is negligible!)
emm_fert <- emmeans(m, ~ fert)
emm_irr  <- emmeans(m, ~ irr)
cat("\nMain effects (fert):\n"); print(contrast(emm_fert, "tukey"))
cat("\nMain effects (irr):\n");  print(contrast(emm_irr,  "tukey"))

# Compact Letter Displays (interaction means)
cld_letters <- multcomp::cld(emm_int, Letters = letters, adjust = "tukey")
print(cld_letters)

# Plot EMMs + CLD letters
emm_df <- as.data.frame(cld_letters)
p_emm <- ggplot(emm_df, aes(irr, emmean, group=fert, color=fert)) +
  geom_line(position=position_dodge(width=.3)) +
  geom_point(size=2, position=position_dodge(width=.3)) +
  geom_errorbar(aes(ymin=lower.CL, ymax=upper.CL),
                width=.15, position=position_dodge(width=.3)) +
  geom_text(aes(label=.group), vjust=-1.1, position=position_dodge(width=.3), show.legend = FALSE) +
  labs(title="EMMs ± 95% CI with CLD letters", x="Irrigation", y="Estimated marginal mean")
print(p_emm)

eta_squared(m, partial = FALSE, alternative="two.sided") 
eta_squared(m, partial = TRUE) 
omega_squared(m)