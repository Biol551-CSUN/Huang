# iteritivie lecture

#load libraries 
library(tidyverse)
library(here)





#two major part
#indexing sequence
for(some index e.g. "i" in sequence){
  command to repeat
}

#simple for loop
print(
  paste("THe year is",2000)) #put together

years <- c(2015:2021)

for (i in years) { #"i" can be anything you want - years is the sequence
  print(paste("the year is", i)) #action to use 
}

#save vector with all the years
#need to preallocate space wehre it wants to be saved
#need vector/df that is empty

year_data <- data.frame(matrix(ncol = 2, 
                               nrow= length(years))) #make number of column same as sequence of years
#add column
colnames(year_data) <- c("year","year_name")

#data frame need to be same as size of matix you expect to be

#adding a for loop - base R always row, column
for (i in 1:length(years)) { #using length so dont need to specify how many, cna just change sequence
  year_data$year_name [i] <- paste("the year is", years[i]) # go to ith row of year name <- take from row of years corresponding to itteration i 
  year_data$year[i] <- years[i]
}


## using data

testdata<-read_csv(here("week_12", "data", "cond_data","011521_CT316_1pcal.csv"))
glimpse(testdata)

#make path so pull file from a folder
condpath <- here("week_12","data","cond_data") 

#directory to the files, what the files were 
files <- dir(path = condpath, pattern = ".csv")
files

#calculate average in each file (assuming each file is a location) using for loop

#empty dataframe
cond_data <- data.frame(matrix(nrow = length(files),
                               ncol = 3))
#give data frame file names
colnames(cond_data) <- c("filename","mean_temp","mean_sal")

#write basic code 
#read in raw data
raw_data <- read_csv(paste0(condpath, "/", #/ as the separator
                            files[3])) #select first file to add to directory path
raw_data

#calculate mean of whole file
mean_temp <- mean(raw_data$Temperature,na.rm = TRUE)
mean_sal <- mean(raw_data$Salinity,na.rm = TRUE)

#make into for loop

for (i in 1:length(files)) {
  #read in raw data
  raw_data <- read_csv(paste0(condpath, "/",files[i])) #read in the i"th" file name
  #glimpse(raw_data) can work, but will show with every iteration 
  
  cond_data$filename[i] <- files[i] #filename is assigned to the ith file name 
  cond_data$mean_temp[i] <- mean(raw_data$Temperature,na.rm = TRUE) # the i is read in line 78
  cond_data$mean_sal[i] <- mean(raw_data$Salinity, na.rm = TRUE)
}

cond_data



###### purrr######## 
# for loops in tidyverse
# faster compuattionally, but no easy to debug, can look at specific i
#FOR PURR DONT NEED TO PRE_ALLOCATE SPACE   - DONT NEED TO MAKE MATRIX

# 1. Use canned fucntion 
#create a vector
1:10 #vector going from 1 to 10
# for each time 1:10 make vector of 15 random variables based on normal
1:10 %>% 
  map(rnorm, n = 15) %>% #create a list of 15 normal distribute 10x
  map_dbl(mean) #calculate the mean of vector type "double"

# Use own mande up function within the mapping
1:10 %>% 
  map(function(x) rnorm(15,x)) %>%  #use own function to map over
map_dbl(mean)

#formula to change arguments within the fucntion
1:10 %>% 
  map(~rnorm(15, .x )) %>% #cahnge a argument within the function
  map_dbl(mean)


#bring in files using purrrr
condpath <- here("week_12","data","cond_data") 
files <- dir(path = condpath,
             pattern = ".csv",
             full.names = TRUE) #full names TRUE tells the entire file path

#create a mapped data frame - bring in every file and stack ontop, then group by final name then muate
data <- files %>% #iterating over files
  set_names() %>% # set the id for everything in "files"
  map_df(read_csv, .id = "filename") %>%  #group by filename, read for all data
  group_by(filename) %>% 
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity, na.rm = TRUE))
