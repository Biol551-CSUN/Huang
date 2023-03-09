# Google API lecture
# Joanthan Huang
# edited 3/9/2023



library(ggplot2)
library(ggrepel)
library(tidyverse)
library(here)
library(ggmap)
library(ggsn)


#read data
chemdataz <- read_csv(here("week_07","data","chemicaldata_maunalua.csv"))
glimpse(chemdataz)


#get base layer map
Oahu<-get_map("Oahu")
ggmap(map)

#Make a data frame of lon and lat coordinates
WP<-data.frame(lon = -157.7621, lat = 21.27427) # coordinates for Wailupe
# Get base layer
Map1<-get_map(WP)
# plot it
ggmap(Map1)

#to zooom into the map
Map1<-get_map(WP,zoom = 17)
ggmap(Map1)


#change map type
Map1<-get_map(WP,zoom = 17, maptype = "satellite")
ggmap(Map1)

ggmap(Map1)+
  geom_point(data = chemdataz,
             aes(x = Long, y = Lat, color = Salinity),
             size = 4) +
  scale_color_viridis_c()


#adding a scale bar
ggmap(Map1)+
  geom_point(data = chemdataz, 
             aes(x = Long, y = Lat, color = Salinity), 
             size = 4) + 
  scale_color_viridis_c()+
  scalebar( x.min = -157.766, x.max = -157.758,
            y.min = 21.2715, y.max = 21.2785,
            dist = 250, dist_unit = "m",
            model = "WGS84",  #This is a model of the lat/long, every gps has different model
            #so a equiptment model and not a coding thing
            transform = Fal, st.color = "white",
            box.fill = c("yellow", "white"))

#if dont know exact long/lat - will give you the lat/long
geocode("the white house")
geocode("California State University, Northridge")

wh <- get_map(geocode("the white house")) 
ggmap(wh)
