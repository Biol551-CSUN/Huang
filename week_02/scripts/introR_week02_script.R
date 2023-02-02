# Week02 script - learing about tidyverse
# created by: Jonathan Huang
# created on: 2023-02-02


# install.packages("here") 
# install.packages("tidyverse)

#####----------CLASS NOTES-------------########
#here package creates unbreakable filepath; rpoject is self contained place; "here" point to relative location
#"here" use the higheest level folder in Rproject, so loading file needs filepath from that highest level

#read.csv loads cvs in as factor, #read_csv loads csv in as a character - issues noted later
#dbl = double = numeric data type 


#####----------load libraries----------########
library(here)
library(tidyverse) #tidyvers already has ggplot

weight <- read_csv(here("week_02","data","weightdata.csv"))

####------------Data Analysis---------######
#inspect data - should do whenever reading in new data
head(weight) #view top 6 lines of dataframe
tail(weight) #view bottom 6 lines of dataframe
view(weight) #opens a separate window to view dataframe
glimpse(weight) #gives information about the rows - data types


