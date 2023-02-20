# Chemistry data - week 4 lab
# Created by Jonathan Huang
# Created on 2023-02-16

#load libraries
library(tidyverse)
library(here)

#load data
chemdata <- read.csv(here("week_04","data", "chemicaldata_maunalua.csv"))
glimpse(chemdata)

#Analyze
chemclean <- chemdata %>% 
 drop_na() %>%   #remove NAs
  separate(col = Tide_time,           #separate Tide_time into a "tide" & "time" column
           into = c("tide", "time"),
           sep = "_") %>% 
  filter(tide == "High",         #filter to only have higg tide & spring season
         Season == "SPRING") %>% 
pivot_longer(cols = 9:16,        #make into long format for easy grouping & summarize
               names_to = "variable",
               values_to = "value") %>% 
  group_by(variable,Site) %>%        #group by variable & site
  summarize(variable_mean = mean(value, na.rm = TRUE)) %>% # get the average of each variable
  write_csv(here("week_04", "output", "summary_hw.csv")) #pring to a csv
chemclean

#plot data
chemdata %>% 
  drop_na() %>%   #drop NAs
  separate(col = Tide_time,    #separate Tide_time into a "tide" & "time" column
           into = c("tide", "time"),
           sep = "_") %>% 
  filter(tide == "High",   #filter to only have high tide & spring season
         Season == "SPRING") %>% 
  pivot_longer(cols = Salinity:TA,   #make nutrient columns to long format
               names_to = "variable",
               values_to = "value") %>% 
  ggplot(aes(x = percent_sgd,     #make ggplot with x&y specified, group by nutrient, and differentiate by color & site
             y = value, 
             group = variable,
             color = Temp_in,
             shape = Site))+
  geom_point()+  #scatter plot
  scale_color_gradient(low = "blue", high = "red")+   #make color gradient hot = red, cold = blue
  labs(x = "Groundwater discharge (%)",   #change axis label and add title
      title = element_text("Fall Low tide Nutrient concentration vs SGD discharge during "))+
  theme_bw()+  #theme, change to blank canvas
  theme(axis.text = element_text(size = 10))+  #change axis text size
  facet_wrap(~variable, scales = "free")   # separate plots by variable
  ggsave(here("week_04","output","chemistry_hw.png"),  #save the plot at desired dimensions
         width = 7, height = 5)


