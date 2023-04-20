# Factors Lab 
# Jonathan Huang 2023-04-20

# Working with intertidal data. Today you will need to use
# skills that you have learned in working with words to clean
# up some issues with the character data and use what you 
# learned today to reorder your factors into orders that 
# make sense. (Also the column headers could be better...).
# HINT: New package idea to fix this is using the janitor 
# package.
# 
# Your goal, as per usual, is to make a plot, any plot
# where one of the axes is a factor. Save everything in
# the appropriate folders.
# 
# You have two possible files to play with in the data 
# folder (you don't HAVE to use both): intertidal.csv 
# and intertidal_latitude.csv (as well as a data dictionary)
# 
# Importantly, if you decide to visualize anything by
# tide height it should go from low to mid to high tide.

#load libraries
library(tidyverse)
library(here)
library(forcats)
library(janitor)

#load data  - clean with fct_reorder
intertidal <- read_csv(here("week_11","data","intertidaldata.csv")) %>%
  mutate(Quadrat = as_factor(Quadrat),
         Site = as_factor(Site),
         Transect = as_factor(Transect)) %>% 
  mutate(Quadrat = fct_recode(Quadrat, "Low" = "Low  .",
                              "Mid" = "Mid  1")) %>% 
  clean_names()

#clean with strings
intertidal <- read_csv(here("week_11","data","intertidaldata.csv")) %>%
  # mutate(
  #        Quadrat = as_factor(Quadrat), #strings need character
  #        Site = as_factor(Site),
  #        Transect = as_factor(Transect)) %>% 
  # mutate(Quadrat = str_subset(Quadrat,
  #                             pattern = "[A-Z][a-z]{2}"))
    
   mutate( Quadrat = str_trim(str_replace_all(Quadrat,
                         pattern = "[0-9\\W]",
                         replace = " "))) %>% 
  clean_names()


unique(intertidal$Quadrat)
unique(intertidal$Site)
unique(intertidal$Transect)

intertidal_sum <- intertidal %>% 
  select(c(site, transect, quadrat,bare_rock)) %>% 
  pivot_longer(cols = bare_rock,
               names_to = "organism",
               values_to = "percent_cover") %>% 
  group_by( quadrat, organism) %>%
  summarise("avg_cover" = mean(percent_cover)) 

ggplot(intertidal_sum)+
  geom_col(mapping = aes(x = fct_reorder(quadrat, #reorder quadrat
                                         avg_cover, #reorder by
                                         .desc = TRUE),
                         y = avg_cover,
           fill = quadrat))+
  scale_fill_viridis_d(option = "mako")+
  theme_bw()+
  labs(x = "tide level",
       y = "% transect cover",
       fill = "Tide")+
  theme(legend.position = "none")
  
intertidal_sum

ggsave(here("week_11","output","factor_lab.png"))




