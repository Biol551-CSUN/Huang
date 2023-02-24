# lubridate - date and time lecture
#created by Jonathan Huang
#created 2023-02-23


#load libraries
library(tidyverse)
library(here)
library(lubridate)

#create functions

#load dataset
cond <- read_csv(here("week_05","data", "CondData.csv")) %>% 
  mutate(date = as.character(date), #change datatype to character
         date = mdy_hms(date), #change date column to a date factor
         date = round_date(date,"10 seconds"))  #round date to the nearest 10 seconds
glimpse(cond)

depth <- read_csv(here("week_05","data", "DepthData.csv")) #no need to change date column here
glimpse(depth)
  
#join two datafroame together only complete values
wq <- inner_join(cond,depth)  
  glimpse(wq)

#analyze data
wqclean <- wq %>% 
  mutate(date = round_date(date, "minute")) %>%   #round date to the nearest minute
  group_by(date) %>%    # average by the date & time by the minute 
  summarize(date = mean(date, na.rm = T),   #summarize data to have mean
            depth = mean(Depth, na.rm = TRUE),
            temp = mean(Temperature, na.rm = TRUE),
            sal = mean(Salinity, na.rm = TRUE))

#plot data
wqclean %>% ggplot(aes(x = date))+      #set x axis
  geom_line(aes( y = sal, color = "Sal (ppt)"))+  #make one line for salinity
  geom_line(aes( y = temp, color = "Temp (ºC)"))+  #make one line for temp
  labs(y = "Unit", x = "Time")+   #specify axis
  scale_y_continuous()+
  scale_color_manual("Water Quality",    #make color scale for each variable
                     breaks = c("Sal (ppt)", "Temp (ºC)"),   #set by the two categories
                     values = c("Sal (ppt)" = "darkgreen",  #specify color
                                "Temp (ºC)" = "red"))+
  theme_classic()+  #edit theme to be black and white and have grids
  theme_linedraw()

ggsave(here("week_05","output","lubridate_hw.png"),  #save the plot at desired dimensions
       width = 7, height = 5)
  


