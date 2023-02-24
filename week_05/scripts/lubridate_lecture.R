# lubridate - date and time lecture
#created by Jonathan Huang
#created 2023-02-23


#load libraries
library(tidyverse)
library(here)
library(lubridate)

#create functions

#load dataset


#Analyze data

#### date and time now - time stamp in your code
now()

now(tzone = "GMT")

#give only date
today()

#ask true/false question - use for asking logical question - filtering to have few 
am(now())
leap_year(now())


#### LUBERDATE to work - need to be character
# date can be in any format and R can figure out

ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24,2021")
dmy("24/02/2021")


#date and time specifications
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20", tz = "EST")

#Extracting specific date or times 
datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:21:10",
               "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes)

#now in date time vector, can extract info on time
#month ask question what month it is 
month(datetimes)
month(datetimes, label = TRUE, abbr = FALSE) #gives actual text of febuary vs just 2s

wday(datetimes, label = TRUE) # gives which day of the week it is
year(datetimes)
hour(datetimes)
minute(datetimes)
second(datetimes)



#adding date and time
#plural function allows for calculations of time (hour vs hours)
datetimes+hours(4) #adds 4 hours to the orgiinal times 
datetimes+days(2) #adds 2 days to the orgiinal times


round_date(datetimes, "minute") #round to nearest minute

round_date(datetimes, "5 mins") #round to nearest 5 minute


#lab 

  

