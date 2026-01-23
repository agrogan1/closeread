# try for 3d RGL of model fit

# libraries

library(haven) # read Stata

# library(brms) # Bayes

library(mgcv) # GAM

library(sjPlot) # nice tables inc. for Bayes

library(labelled) # work w labels

library(ggeffects) # model effects

library(ggplot2) # beautiful graphs

library(rgl) # 3D interactive graphs

options(rgl.printRglwidget = TRUE) # display in RStudio viewer

# get data

empathy <- read_dta("empsui_043024.dta")

mod_gam1 <- gam(N_SUTHO ~ s(empathy) + maltreat +
                  sexab + A_AGE + zses, 
                family = binomial(link="logit"), # logistic regression
                data = empathy)

tab_model(mod_gam1)

plot(mod_gam1) # plot of smoother term(s) in fit

mydf <- ggpredict(mod_gam1, 
                  terms = c("empathy",
                            "maltreat")) # dataframe of fit

# plot 3d

with(mydf, plot3d(x, 
                  group, 
                  predicted, 
                  type="s",
                  col = as.numeric(group),
                  xlab = "empathy",
                  ylab = "maltreatment",
                  zlab = "predicted probability"))

# with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
#                   type="s", col=as.numeric(Species)))

# plotly

z_matrix <- xtabs(predicted ~ x + group, data = mydf)

plot_ly(z = ~z_matrix) %>% 
  add_surface()





