library(haven)

reffects <- read_dta("positive-and-negative-parenting/reffects.dta")

library(ggplot2)

ggplot(reffects,
       aes(color = country)) +
  geom_segment(aes(x = 0,
                   xend = 1,
                   y = 0,
                   yend = (.023 + u4) * 1)) +
  theme_minimal() +
  theme(legend.position = "none")


