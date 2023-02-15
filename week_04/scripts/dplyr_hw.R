#Week 4 homework 1 - dplyr into graphs
#created by Jonathan Huang
#created 2023-02-14


#Load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(viridis)
library(calecopal)

#load functions

#load data
glimpse(penguins) #taking a look at the penguins data frame
view(penguins)

#data analysis


#calculate the mean and variance of bodymass by sepcies, island, and sex w/out NA

one <- penguins %>% #use penguins dataframe
  drop_na() %>%  #drop all NAs in the df
  group_by(species, island, sex) %>%  #group analysis by species, island, sex
  summarise(mean = mean(body_mass_g, na.rm = TRUE),  #calculate the mean body mass
            variance = var(body_mass_g, na.rm = TRUE)) #calculate the variance of body mass
one

#filters out (i.e. excludes) male penguins, then calculates the log body mass, then
# selects only the columns for species, island, sex, and log body mass, then use these
# data to make any plot. Make sure the plot has clean and clear labels and follows best
# practices. Save the plot in the correct output folder.


penguins %>% 
  filter(sex == "female") %>%  #filter out male to have only female
  mutate(logmass = log(body_mass_g)) %>%  #calculate base log of bodymass
  select(species, island, sex, logmass) %>% #select to only have species, island, sex, logmass
  ggplot() +
  geom_boxplot(aes(x = island,      #x of island
                   y = logmass,     #y of base log(mass)
                   fill = species), #color boxplots by species
              color = "darkgray" )+ # boxplot outline color
  geom_jitter(aes(x = island,       #jitter plot
                  y = logmass,
                  color = species), #color dots by species
              size = 0.5,           #change dot size
              alpha = 2,            #change transparency 
              position = position_jitterdodge(jitter.width = .5, dodge = .8))+   #change the position of dots to put over boxplot
  labs(y = "log(mass)",   #change the lab name
       x = "",  
       fill = "Species",   #change legend title for boxplot and dots
       color = "Species",
       caption = "Happy Valentines day :)")+  #add a caption
  scale_color_manual(values = cal_palette("vermillion"))+ # specify color of dots
  scale_fill_manual(values = cal_palette("vermillion"))+  #specify fill color
  theme_bw()+   #edit theme - gives blank canvas
  theme(panel.background = element_rect(fill = "lavenderblush2"), #change background color
        axis.title.y = element_text(size = 15),    #change text size 
        axis.text.y = element_text(size = 15),     #change text size 
        axis.text.x = element_text(size = 15),     #change text size 
        plot.caption = element_text(hjust = 1.2))  #adjust caption position

ggsave(here("Week_04/output/dplyr_hw.png"),
       width = 7, height = 5)





