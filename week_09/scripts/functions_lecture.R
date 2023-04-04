# making a funciton lecture
# JOnathan Huang 2023_04_04

#library
library(tidyverse)


#make a random dataframe
df <- tibble::tibble(
  a = rnorm(10),  #creates a random number normal distribution with mean of 0, std of 1
  b = rnorm(10),  #can specify mean = , std =
  c = rnorm(10),
  d = rnorm(10)
)

head(df)

df <- df %>% 
  mutate(a = (a-min(a, na.rm = TRUE))/ max(a,na.rm = TRUE)-min(a,na.rm = TRUE),
         b = (b-min(b, na.rm = TRUE))/ max(b,na.rm = TRUE)-min(b,na.rm = TRUE),
         c = (c-min(c, na.rm = TRUE))/ max(c,na.rm = TRUE)-min(c,na.rm = TRUE),
         d = (d-min(d, na.rm = TRUE))/ max(d,na.rm = TRUE)-min(d,na.rm = TRUE))

#write a function
#r code needs 1) a function name,
# 2) arguemtns, what are the variables
# 3) function itself
# 
rescale01 <- function(x) {
  value <- (x-min(x,na.rm = TRUE)/ max(x, na.rm = TRUE)-min(x,na.rm = TRUE))
  return(value) #what we want to push out after 
}


#Example
# temp_c <- (temp_f -32)* 5/9

#make it a function

f_to_c <- function(temp_f) {
  temp_c <- (temp_f -32)* 5/9
  return(temp_c) #what to output
}

f_to_c(61)
f_to_c(32)


#think pair share ---write a function

c_to_k <- function(temp_c){
  temp_k <- temp_c+ 273.15
  return(temp_k)
}
c_to_k(-273.15)


#making plots into a fucntions 
#to have same points, color, format, but different data
#can add on like any other ggplot with +
library(palmerpenguins)
library(PNWColors)

pal <- pnw_palette("Lake",
                   3,
                   type = "discrete") #make a color palette

ggplot(penguins,
       aes(x = body_mass_g,
           y = bill_length_mm,
           color = island))+
  geom_point()+
  geom_smooth(method = "lm")+
  scale_color_manual("Island",
                     values = pal)+
  theme_bw()


#function
myplot <- function(data,x,y){
  #first step, copy paste plot code into here
  pal <- pnw_palette("Lake",
                     3,
                     type = "discrete") #make a color palette
  
  #switch out what can be replaced
  ggplot(data,
         aes(x = {{x}},
             y = {{y}},
             color = island))+
    geom_point()+
    geom_smooth(method = "lm")+
    scale_color_manual("Island",
                       values = pal)+
    theme_bw()
}

myplot(penguins,body_mass_g,bill_length_mm)
#should have issues/ errors, dont know that we are calling form penguins
{{x}} #curley curley - look in the data frame for x

#after adding {{}}, it should work

#can add default - add what you want the default to be unless specified not


#function - WITH DEFAULT DATA 
myplot <- function(data = penguins,x,y){ 
  #first step, copy paste plot code into here
  pal <- pnw_palette("Lake",
                     3,
                     type = "discrete") #make a color palette
  
  #switch out what can be replaced
  ggplot(data,
         aes(x = {{x}},
             y = {{y}},
             color = island))+
    geom_point()+
    geom_smooth(method = "lm")+
    scale_color_manual("Island",
                       values = pal)+
    theme_bw()
}

#adding 
myplot(penguins,body_mass_g,bill_length_mm)+
  labs(x = "body mass (g)")


####### IF_Else statements

a <- 4
b <- 5

test <- function(a,b){
  if(a>b){ #my question
  f <- 20 #if ture then give answer
} else{ 
  f <- 10 #if else give me this
}
  return(f)
}
test(a,b)

##### PLOTTING WITH IF ELSE

myplot <- function(data,x,y, lines = TRUE){ #"lines" could be any word, any parameter
  #first step, copy paste plot code into here
  pal <- pnw_palette("Lake",
                     3,
                     type = "discrete") #make a color palette
  
  if(lines == TRUE){ #"lines" could be any word, any parameter
  #switch out what can be replaced
  ggplot(data,
         aes(x = {{x}},
             y = {{y}},
             color = island))+
    geom_point()+
    geom_smooth(method = "lm")+
    scale_color_manual("Island",
                       values = pal)+
    theme_bw()
}else
  ggplot(data, #REMOVE points on the plot
         aes(x = {{x}},
             y = {{y}},
             color = island))+
    geom_smooth(method = "lm")+
    scale_color_manual("Island",
                       values = pal)+
    theme_bw()
}

myplot(penguins,body_mass_g,bill_length_mm)
myplot(penguins,body_mass_g,bill_length_mm, lines = FALSE)
