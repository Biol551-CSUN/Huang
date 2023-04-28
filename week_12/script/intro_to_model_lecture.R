# intro to model lecture

library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance)
library(modelsummary)
library(tidymodels)



# An ancova with palmer penguin - between coninuous & categorical predictor variable
# lm(y ~x) - y as a function of
peng_mod <- lm(bill_length_mm~bill_depth_mm*species, data = penguins)

#performance package to check for assumptions 
check_model(peng_mod)

## two output for LM - summary and anova output
anova(peng_mod) #- gives main effects
summary(peng_mod) #give effect size - if different from 0

# Intercept is the third species


#broom package to turn into tibble
coeff <- tidy(peng_mod)
# give higher level model statistic
results <- glance(peng_mod)
#residuals and predicted values 
resid_fitted <- augment(peng_mod)


#modelsummary package - makes tables and plots to summarize stat model and data 

#new model to compare to
peng_mod_noX <- lm(bill_length_mm~bill_depth_mm, data = penguins)
# make a list of model and name them

models <- list("test" = peng_mod,
               "test2" = peng_mod_noX)

modelsummary(models, output = here("week_12", "output","tabel.docx"))


#plot model coeffieicnets using modelplot - can work with ggplot
modelplot(models)+
  labs(x ="coefficient - effect size",
       y = "term names")


#many models with purr, dplyr, and broom
# mapping to make a list of data frames we want to use and 
# list = multiple data type in same section

models <- penguins %>% 
  ungroup() %>% 
  nest(-species) %>%  # collapse so one row is an entire tibble based on species
  mutate(fit = map(data,
                   ~lm(bill_length_mm~body_mass_g,
                       data = .)))  # refer to first data mentioned before
 results <- models %>%  mutate(coeffs = map(fit, tidy),# model is data, function in maps - tidy
         modelresults = map(fit, glance)) %>% 
#unest to un collaps table - bring back to regular tibble
  select(species, coeffs, modelresults) %>% 
  unnest()
 
 
 # tidy models
 lm_mod<-linear_reg() %>%
   set_engine("lm") %>%  #set engine - changing to "brms" makes it beysian
   fit(bill_length_mm~bill_depth_mm*species, data = penguins) %>% 
  tidy() %>% 
   #directly into ggplot
   ggplot()+
   geom_point(aes(x = term, y = estimate))+
   geom_errorbar(aes(x = term, ymin = estimate-std.error,
                     ymax = estimate+std.error), width = 0.1 )+
   coord_flip()
 lm_mod
