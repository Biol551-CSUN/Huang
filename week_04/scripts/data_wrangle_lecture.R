# Data Wrangling_tidyr R lecture
# Created by Jonathan Huang
# Created 2023-02-16

# load libraries
library(tidyverse)
library(here)

# Read data
chemdata <- read.csv(here("week_04","data", "chemicaldata_maunalua.csv"))
glimpse(chemdata)  


#Analyze data

#two ways to drop NAs from the dataset 
chemclean <- chemdata %>%
  filter(complete.cases(.)) #Base R: nother way to filter anything that is not complete 

chemclean <- chemdata %>% 
  drop_na()

####----SEPARATE-----####
# delimit one column into two

chemfinal <- chemclean %>% 
  separate(    
    col = Tide_time,        # select the column want to separate
    into = c("Tide", "Time"), # separate into specificed column title
    sep = "_",                 # delineate by this value "_"
    remove = FALSE)          # FALSE = Keep the original undelimited column 


####----Unite-----####
#combine two column into one

chemfinal <- chemclean %>% 
  separate(    
    col = Tide_time,        
    into = c("Tide", "Time"), 
    sep = "_",                 
    remove = FALSE) %>% 
  unite(col = "Site_Zone",    #name of NEW column
        c(Site,Zone),        # columns to unite
        sep = ".",            #put a "." in the middle
        remove = FALSE)     # Keep the old columns


####----Unite-----####
#wide to long: pivot_longer()
#long to wide: pivot_wider()

chemlong <- chemfinal %>% 
  pivot_longer(cols = Temp_in:percent_sgd,  #take column x to y to transform to long
               names_to = "variables",      # name of new column with the old column title
               values_to = "Values")        # name of new column with all the values


#summarize the data - save space compared to wide fromat, 
#insead of grou_by every variable (meanphospate = mean(phosphate))
chemlong %>% group_by(variables, Site) %>% 
  summarise(param_mean = mean(Values, na.rm = TRUE),
            param_vars = var(Values, na.rm = TRUE))


#think pair, share
chemlong %>% group_by(variables, Site, Zone,Tide) %>% 
  summarise(vari_mean = mean(Values, na.rm = TRUE),
            vari_vars = var(Values, na.rm = TRUE),
            vari_sd = sd(Values, na.rm = TRUE)) %>% 
  filter(Tide %in% "Low")

#ploting with summary data

chemlong %>% ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~variables, scales = "free")

#convert long back into wide
chemwide <- chemlong %>% 
  pivot_wider(names_from = variables,
              values_from = Values)

# entire work flow
chemdata_clean <- chemdata %>%  #drop na
  drop_na() %>% 
  separate(col = Tide_time,     #separate column
           into = c("Tde", "Time"),
           sep = "_",
           remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd,  #make long format
               names_to = "variables",
               values_to = "values") %>% 
  group_by(variables, Site, Time) %>% 
  summarize(mean_val = mean(values, na.rm = TRUE))%>%   #look at summary statistics
  pivot_wider(names_from = variables,                   #make wide format (better looking)
              values_from = mean_val) %>% 
  write_csv(here("week_04", "output", "summary.csv"))
  
  
  