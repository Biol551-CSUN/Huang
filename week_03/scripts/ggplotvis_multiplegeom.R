# Plotting penguin data
# Created by Jonathan Huang on 20230209
# Updated 20230209

#Load libraries
library(tidyverse)
library(palmerpenguins)
library(here)
library(praise)
library(devtools)
# devtools::install_github("an-bui/calecopal") - California color pallate
#devtools::install_github("dill/beyonce") - Beyonce color pallate
library(calecopal)
library(beyonce)

#load data
glimpse(penguins)



#data analysis
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm)) +
  geom_point()+
  geom_smooth(method = "lm")+  #fits line for best fit method, linear model in this case
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)")

#not a good fit for linear could group by sepecies 
#notice the points is under the line, geomsmooth is layered after poing
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               group = species,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  #fits line for best fit method, linear model in this case
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)")+
  scale_colour_viridis_d()

#Praise youserlf
praise()


#SCALE - adding a layer to the plot - has 3 components
# scale_
# aesethic your changing (x,y,shape, color)_ 
# name of scale (continuous, discrete, manual)

ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  #fits line for best fit method, linear model in this case
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)") +
  scale_colour_viridis_d()+
  scale_x_continuous(limits = c(0,20)) + #c = concantinate, bring together
  scale_y_continuous(limits = c(0,50))

#chagne the limits with breaks
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  #fits line for best fit method, linear model in this case
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)") +
  scale_colour_viridis_d()+
  scale_x_continuous(breaks = c(14,17,21), #c = concantinate, bring together
                     labels = c("a","b","c")) + #chagne x labels to discrete factors
  scale_y_continuous(limits = c(0,50))
#?scale_x_continuous to see what you can change

#manual color
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  #fits line for best fit method, linear model in this case
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)") +
  # scale_colour_manual(values = c("orange","purple", "green")) #Manual color, ordered by alphabetical by default
  scale_color_manual(values = beyonce_palette(2)) #adding custom color palette


##### -------- Coordinates - default is cartesian - normal x,y - 2D functions
#coord_trans - change scale of axis (like )
#coord_polar - Polar coordinates 
#coord_flip - flip x and y axis

ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  #fits line for best fit method, linear model in this case
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)")+
  coord_flip()+ #cisually flipping the cordinates, so in aes() still same x and y of orininal data
  coord_fixed() #changed aspect ratio for 1:1
  
#coord_trans
ggplot(diamonds, aes(carat,price))+
  geom_point()

ggplot(diamonds, aes(carat,price))+
  geom_point()+
  coord_trans(x = "log10", y = "log10") #tranfom axis to what you want to look like

#coord_polar
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)")+
  coord_polar("x") # change x to polar coordinate system

#####-------THEMES----------
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)")+
  # theme_classic() #addint a classic theme
  theme_bw() #add bw theme

#library(ggtheme) to get pre customized theme

#customize theme elements - ?theme for all of them 
plot1 <- ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y = bill_length_mm,
                               color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+  
  labs(x = "Bill depth (mm)",
       y =" Bill length (mm)")+
  # theme(axis.title = element_text(size = 30))  #customize axis title size of both
  theme(axis.title.x = element_text(size = 30,  #add only x title size
                                    color = "red"), #add color red
        panel.background = element_rect(color  = "green", 
                                        fill = "linen"),#add background color, color = "color" to get outline to change instead of filled
        axis.ticks = element_line(color = "red", size = 2) 
        )

ggsave(here("Week_03/output/penguin.png"),
       width = 7, height = 5) #change in inches






