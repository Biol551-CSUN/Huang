# Week_03script - ggplot visualization
# 
# Created by Jonathan Huang
# 
# Created 2023_02_07


#gg = grammer of graphics
#dataset, mapping ( what we are mapping), aes = aesthetics
#ggplot layers visuals, first line = first layer
#geom_XXX = geometry of how we want points to be visualized


#####----------load libraries----------########
library(palmerpenguins)
library(tidyverse)
#####----------list of functions----------########

#####------------load data---------########
#data set from palmerpenguins = penguins
glimpse(penguins)
view(penguins)

#####------------Data Analysis---------########

#graph bill length vs width by species
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,    #specify x of data
                     y = bill_length_mm,   #specify y of data, note the "+" to add a layer
                     color = species,       #specify differentiaito of color by speciea
                     shape = island,       #shapes of data point differentiated by island
                     size = body_mass_g,   # change the size of points by scale of body mass
                     alpha = flipper_length_mm)) +   #change transparancy based on flipper length
  geom_point() +  #geometry as points, anything that goes into function = SETTING
                  #Anything going into this geom_() function NOT based on data, need a constant
  labs(title = "Bill depth and length",  #title label in exact words in ""
       subtitle = "Dimensions of Adelie, Chinstrap, and Gentoo Penguins", #Add subtitle 
       x = "Bill Depth (mm)",  #edit x axis label
       y = "Bill Length (mm)", #edit y axis label
       color = "Species",   #edit legend title
       shape = "Island",    #edit shape title
       caption = "Source: Palmer Station LTER/palmerpenguin package") + #add caption 
  scale_colour_viridis_d() #change color scale to verdis palate and a discrete palate (for discrete factors)

# NOTE:Asethetics deals with data in data frame
#mapping is determine size, shape, alpha of point based on values in a data
# setting = determine size, shape, alpha of point NOT based on data (i.e. a set constant - 0.2)
  #goes into geom_XXX() 

#------Faceting
#visualize by turning into subplots that displays diff subsets of data

ggplot(penguins,
      aes( x = bill_depth_mm,
       y = bill_length_mm)) +
  geom_point() +
facet_grid(species ~ sex) #row as function of column, always a square


ggplot(penguins,
       aes( x = bill_depth_mm,
            y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~species, ncol = 2) #wrap in column, axis identical across all plots and have only 2 column


#combine facet w/ color
ggplot(penguins,
       aes( x = bill_depth_mm,
            y = bill_length_mm,
            color = species)) +
  geom_point() +
  scale_colour_viridis_d()+
  facet_grid(species~sex) +
  guides(color = FALSE)      #remove color legned since no longer needed after faceting

#for inspiration on ggplot types: https://r-graph-gallery.com/
