#dplyr - data transformation
#created by: Jonathan Huang 
#date: 2023-02-14


#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)

#load functions

#load data
glimpse(penguins)
view(penguins)
head(penguins)

unique(penguins$species)

#analysis

#filter function - extract row that meet criteria
filter(.data = penguins,  #statement -sets argument
       sex =="female") #find where data has only female - the logical expressions

# filter year 2008 
filter(penguins, year == "2008")

filter(.data = penguins, sex == "female", body_mass_g > 5000)
#OR
filter(.data = penguins, sex == "female" & body_mass_g > 5000)


#exercise
#collected either 2008 or 2009
filter(.data = penguins, year == "2008" | year == "2009")
filter(.data = penguins, year %in% c(2008,2009))

#find not on Island Dream
filter(.data = penguins, island != "Dream")
filter(.data = penguins, island %in% c("Biscoe", "Torgersen"))

#select only adelie and gentoo penguins
filter(.data = penguins, species == "Adelie" | species == "Gentoo")
filter(.data = penguins, species %in% c("Adelie", "Gentoo"))
filter(.data = penguins, species != "Chinstrap")

       


####------MUTATE-----##### 
#to move the mutate column either rearrange() or select
#mutate adds a dataframe

data2 <- mutate(.data = penguins, 
                body_mass_kg = body_mass_g/1000) #add column for body mass in kg


#add multiple column
data3 <- mutate(.data = penguins, 
                body_mass_kg = body_mass_g/1000,
                bill_length_depth = bill_length_mm/bill_depth_mm)


####------ifelse-----#####
#case_when asks multiple question
data2 <- mutate(.data = penguins, 
                after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) # if meets criteria, put in this column,if not then in tis column


#exercise
thinkpairshare <- mutate(.data = penguins, 
                         flip = flipper_length_mm + body_mass_g,           #combine flipper length & body mass
                         heavy = ifelse(body_mass_g>4000, "large","slim")) #categroize as bigboi or slimboi
                         

####------Select-----#####
#filter subsets rows,
#select filter columns want to keep
# can rename column name as well

penguins %>% # use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(Species = species, island, sex, log_mass) #select few column and change specie name



####------Summarize-----#####
#take data and summarizing to new value, creates new data frame

penguins %>% 
  group_by(island) %>% #give mean by different islands
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE)) #mean value of flipper


####------remove NA-----#####

drop_na() #drop na in a particular category\
na.omit() #baseR

####------pipe into ggplot-----#####


penguins %>% 
  drop_na(sex) %>% 
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()







