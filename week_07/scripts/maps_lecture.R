# Maps - lecture
# Created by Jonathan Huang
# Created on 2023-03-07


#load library
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)

#upload data
popdata <- read_csv(here("week_07","data","CApopdata.csv"))
stars<-read_csv(here("week_07","data","stars.csv"))


#MAPS package 
#map_data() function with "location" of where we want to extract
#lowercase in country name
#order in the data & script gives outline of how to outline
# group = if does not make map, issue maybe here
  # tells where to lift the pen when outlining map

world <- map_data("world")
glimpse(world)

usa <- map_data("usa")
glimpse(usa)

italy <- map_data("italy")
glimpse(italy)

state <- map_data("state")
glimpse(state)

counties <- map_data("county")

#map of the world
ggplot()+
  geom_polygon(data = world, aes(x = long, 
                                 y = lat, 
                                 group = group,
                                 fill = region), #add color by region (country here)
               color = "black")+ #make outline of countries to black
  guides(fill = FALSE)+ #remove legend, not necessary here to prevent 100 color legends
theme_minimal()+    #make theme minimal
theme(panel.background = element_rect(fill = "lightblue"))+ #change ocean to blue
  coord_map(projection = "mercator", #set projection to what you want "mercator is the basic"
            xlim = c(-180,180)) #set x limits, zoom in and out of sections

#make map of just california - think pair share
CA_data <- state %>% 
  filter(region == "california")

ggplot()+
  geom_polygon(CA_data, mapping = aes(x = long, 
                            y = lat,
                            group = group),
               fill = "blue")+
  theme_void() #remove everything but the dataset (including lat/long)

#color = outline, 
#fill = the inside 



#adding layers of data 
#use county level data
head(popdata)
#join popdata with counties

capop_data <- popdata %>% 
  select("subregion" = County, Population) %>%  # could use rename also
  inner_join(counties) %>%  # keeping only counties in the popdata
filter(region == "california")

#map
ggplot()+
  geom_polygon(capop_data, mapping = aes(x = long, 
                                      y = lat,
                                      group = group,
                                      fill = Population))+
  coord_map()+
  theme_void()+
  scale_fill_gradient(trans = "log10") #log transforms data to look at the skewed data

#Layering more data ontop of said map
head(stars) #lets plot onto map


ggplot()+
  geom_polygon(capop_data, mapping = aes(x = long, 
                                         y = lat,
                                         group = group,
                                         fill = Population),
               color = "black")+ #add line - county boarders
  scale_fill_gradient(trans = "log10")+
  geom_point(stars, # add points of where seastars are
             mapping = aes(x = long,
                           y = lat, 
                           size = star_no))+ #make size base on number sene
  labs(size = "Star #")+ # change legend name
  coord_map()+
  theme_void()
  
ggsave(here("week_07","output", "calpopstar.pdf"),
       width = 7, height = 5)

               