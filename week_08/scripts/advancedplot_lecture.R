# Lecture notes : advanced plotting
# created by: Jonathan Huang
# Edited 03_28_2023

#library
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)
library(ggpubr)


####Patchwork
# Make 2 plots 
p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()
p1


p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)
p2

# Combine them
p1+p2
p2+p1

p1+p2 +
  plot_layout(guides = "collect")+ # combine the lengend
  plot_annotation(tag_levels = "A") #add annotation

p1/p2 #top/bottom plots
#Label for the guides need to be indentical to combine


####ggrepel
# easy and clear labels for plots
view(mtcars)

ggplot(mtcars, aes(x = wt,
                   y = mpg,
                   label = rownames(mtcars)))+ # take rownames to make labels, if columns then jsut have label = "mtcars"
  geom_text_repel()+ #how to get text on the graph so names are not directly not on top of each other
  geom_label_repel()+ #same as text but with a box around
  # annotate() #this also add a textbox in ggplot, can specify location
  geom_point(color = "red")


####gganimate
# make animations from ggplots

#make a static plot
penguins %>% 
  ggplot(aes(x=body_mass_g,
             y= bill_depth_mm,
             color = species))+
  geom_point()+
#animate
  transition_states( 
    year, #what are you animating by?
    transition_length = 2, # time of animation by section
    state_length = 1 #length of pause between
  )+
  ease_aes("bounce-in-out")+ #types of animation
  ggtitle("Year:{closest_state}") #adding animated title
  anim_save(here("week_08","output","animation_lecture.gif"))
  
  
  ####magick
  #read in ong
  penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
  penguin
  
  #save plot as png
  penguins %>%
    ggplot(aes(x = body_mass_g, 
               y = bill_depth_mm, 
               color = species)) +
    geom_point()
  ggsave(here("week_08","output", "penplot.png"),
         width = 20, height = 10)
  #add picture onto plot
  penplot<-image_read(here("week_08","output","penplot.png"))
  out <- image_composite(penplot, #fist on the back
                         penguin, #overlayed on top
                         offset = "+70+30") #coordinate for location
  out

  
  