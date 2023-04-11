# shiny lecture notes
# Jonathan Huang 
# 2023_04_06

library(shiny)
library(tidyverse)

ui <- fluidPage() #user interface uses fluid page function, anything for useers to see, need to be here

server <- function() #the function of the app, code to render image to pass to ui
  
shinyapp(ui = ui, server = server)

#when saving app, need to save foler of what you want to call you app
#MUST save script as "app.r"
# everything related to the app MUST be in that folder

#ways to get app
# manual
# OR
# template with "file -> new -> new with shiny

# input = user interacts with
#output = user recieves



