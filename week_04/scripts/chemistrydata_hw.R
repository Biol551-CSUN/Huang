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
 drop_na() %>% 
  separate(col = Tide_time,
           into = c("tide", "time"),
           sep = "_") %>% 
  filter(tide == "High",
         Season == "SPRING") %>% 
pivot_longer(cols = 9:16,
               names_to = "variable",
               values_to = "value") %>% 
  group_by(variable,Site) %>% 
  summarize(variable_mean = mean(value, na.rm = TRUE)) %>% 
  write_csv(here("week_04", "output", "lab_summary.csv"))
chemclean

#plot data
chemdata %>% 
  drop_na() %>% 
  separate(col = Tide_time,
           into = c("tide", "time"),
           sep = "_") %>% 
  filter(tide == "High",
         Season == "SPRING") %>% 
  pivot_longer(cols = Salinity:TA,
               names_to = "variable",
               values_to = "value") %>% 
  ggplot(aes(x = percent_sgd,
             y = value, 
             group = variable,
             color = Temp_in,
             shape = Site))+
  geom_point()+
  scale_color_gradient(low = "blue", high = "red")+
  labs(x = "Groundwater discharge (%)",
      title = element_text("Fall Low tide Nutrient concentration vs SGD discharge during "))+
  theme_bw()+
  theme(axis.text = element_text(size = 10))+
  facet_wrap(~variable, scales = "free")
  ggsave(here("week_04","output","chemistry_hw.png"),
         width = 7, height = 5)


