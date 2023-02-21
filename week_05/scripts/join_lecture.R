# Lecture notes on Join
#created by Jonathan Huang
#created 2023-02-21


#library load
library(tidyverse)
library(here)

#load data
envir <- read_csv(here("week_05", "data","site.characteristics.data.csv"))
glimpse(envir)
tpc <- read_csv(here("week_05", "data","Topt_data.csv"))
glimpse(tpc)
depth <- read_csv(here("week_05", "data","DepthData.csv"))


#Analysis of data

#tpc and environment data are different formats, 
envir_wide <- envir %>% 
  pivot_wider(names_from = parameter.measured,    #pivot environment to wider format
              values_from = values) %>% 
  arrange(site.letter)  #Arrange site.letter column to alphabetical order ( can be for continuous data)

#left_join
#joins by unique identifiers on the left handed dataset 

fulldata <- left_join(tpc, envir_wide) #left dataset is the tpc - join by automatically 
head(fulldata)

#relocate - change column order
#change to have numerics order after character column
fulldata <- left_join(tpc, envir_wide) %>% 
  relocate(where(is.numeric), .after = where(is.character)) #where is a logical function
#relocate data 


#think, pair, share
summary <- fulldata %>% 
  pivot_longer(cols = E:substrate.cover,
               names_to = "characteristic",
               values_to = "value") %>% 
  group_by(site.letter, characteristic) %>% 
  summarize(mean_val = mean(value, na.rm = TRUE))  #na.rm just removes the na values and keeps others in the row; drop_na removes entire row


summary <- fulldata %>%  #summary at gives the same function but on wide format data
  group_by(site.letter) %>% 
  summarise_at(vars(E:substrate.cover),.funs = list(mean = mean, var = var)) 



#using tibble -tidyverse version of data frame 
#creating tibble

t <- tibble(site.id = c("A","B","C","D"),
            temp = c(1.2,3,4.7,19))
t2 <- tibble(site.id = c("A","B","D","E"),
             ph = c(2,5,8,7.1))


#right vs left join 
left_join(t,t2) #E was dropped completely, ph for C is "NA"
right_join(t, t2) #C was dropped completely, temp for E is NA

#inner join - join only data that is complete
inner_join(t,t2)

#full join - keeps everything from both datasets, 
full_join(t,t2)

#semi join - keeps column from the first dataset - only dataset, not ph
semi_join(t,t2)

#anti join - keep column on the incomplete rows from the first column (t)
anti_join(t,t2)


a <- tibble(fish = c("a","b","c","e"),
            tl = c(23,44,25,22))
b <- tibble(fish = c("a","b","c","d"),
            site = c("top","bottom",NA,"middle"))
left_join(a,b)
full_join(a,b)
semi_join(a,b)
anti_join(b,a)




