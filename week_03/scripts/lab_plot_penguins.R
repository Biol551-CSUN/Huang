# Plotting penguin data - lab plot
# Created by Jonathan Huang on 20230209
# Updated 20230209


#Load libraries
library(tidyverse)
library(palmerpenguins)
library(here)
library(praise)
library(devtools)
# devtools::install_github("an-bui/calecopal") - California color pallate
#devtools::install_github("dill/beyonce") - Beyonce color pallate
library(calecopal)
library(beyonce)

#load data
glimpse(penguins)
view(penguins)
unique(penguins$year)

#data analysis - body mass & sex, by sepcies
#goem_bar and geom_col always need summary statistics
penguins <- penguins %>% mutate(mass = body_mass_g) #rename body_mass_g to easier name
summary <- penguins %>% na.omit() %>%    #make another data frame and omit NAs
  group_by(sex, species) %>%             #group by sex and species to analyze 
  summarize(mean = mean(mass),          #make a column for mean
             sum = sum(mass))            #make a column for sum

ggplot(summary, mapping = aes( x = sex, 
                      y = mean,
                      group = species,
                      fill = species)) + 
  geom_col(position = "dodge2") +
  labs(x = element_blank(),
       y = "Body Mass (g)",
       fill = "Species",
       title = "Mass of penguin")+
  scale_x_discrete(label = c("Female", "Male"))+
  scale_fill_manual(values = cal_palette("bigsur"))+
  theme_bw()+
  theme(axis.text.x = element_text(size = 15),
        axis.title.y = element_text(size = 13))
 ggsave(here("Week_03","output","penguin_mass_bar.png"),
        width = 11, height = 9)


# Density plot
ggplot(penguins %>% na.omit,
       mapping = aes(x = mass,
                    group = species,
                     fill = species))+
  geom_density()+
  labs(x = "Mass (g)") +
  theme_classic()+
  scale_fill_manual(values = cal_palette("bigsur"))+
  facet_grid(species ~ sex )

ggsave(here("Week_03","output","penguin_mass_density.png"),
       width = 11, height = 9)



