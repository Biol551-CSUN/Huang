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
  mutate(date = round_date(date, "minute")) %>% 
  group_by(date) %>% 
  summarize(date = mean(date, na.rm = T),
            depth = mean(Depth, na.rm = TRUE),
            temp = mean(Temperature, na.rm = TRUE),
            sal = mean(Salinity, na.rm = TRUE))




