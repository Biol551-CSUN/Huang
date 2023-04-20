# Factors lecture

library(tidyverse)
library(here)
library(forcats)


income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

fruits <- factor(c("Apple","Grape","Banana"))
fruits


#Forcats package = function for categroical data
glimpse(starwars)

#check unique species
starwars %>% 
  drop_na(species) %>% 
  count(species, sort = TRUE)

#lump species w/ less than 3 individuals
star_counts <- starwars %>% 
  drop_na(species) %>% 
  mutate(species = fct_lump(species, n = 3)) %>% #convert data to factor and lump
  count(species)
star_counts #factors in 

#basic ggplot

star_counts %>% 
  ggplot(aes(x= fct_reorder(species, #what are we ordering
                             n,# reorder by n
                            .desc = TRUE), # by decending order
                             y =n))+
  geom_col()


###### REORDERING LINE PLOTS######
glimpse(income_mean)

total_income<-income_mean %>%
  group_by(year, income_quintile)%>% 
  summarise(income_dollars_sum = sum(income_dollars))%>% #sume of income
  mutate(income_quintile = factor(income_quintile)) # make it a factor

total_income %>% 
  ggplot(aes(x = year, y =income_dollars_sum, 
             color = fct_reorder2(income_quintile, 
                                  year, 
                                  income_dollars_sum)))+  #reorder so it orders multiple things at once
  geom_line()+
  labs( color = "income quartile")


#manual reorder

factor(c("Jan","Mar","Apr","Dec"),
       levels = c("Jan","Mar","Apr","Dec")) #specify the levels



#######subset data with factors######
# filter out so n>3
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>%  # only keep species that have more than 3
  #levels still within dataset but just hidden\
  #if filter, then always want to drop levels or it can cause NAs
  droplevels() %>%  #fct_drop would be the same
  mutate(species = fct_recode(species, #rename a level
                              "Humanoid" = "Human")) #new name old name

levels(starwars_clean$species) 

