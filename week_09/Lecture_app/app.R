library(shiny)
library(tidyverse)

#build a reactive data frame so a complete data can be used to react when one user option is changed
# data technically becomes a function so it needs to be data() - with paranthesis

ui <- fluidPage( #NOTE Input should come before output
  sliderInput(  #make a slider
    inputId = "num", # ID name for the input
    label = "Choose a number", # Label above the input
    value = 25, min = 1, max = 100 # values for the slider
  ), #every input and put in ui needs a comma
  textInput(inputId = "title", #new inputId to change text of histogram
            label = "write a title",
            value = "Histogram of Random Normal Values"),  #starting title
  plotOutput("hist"), # ouetputId "hist" can be replaced with anything but need ot know there is something there
  verbatimTextOutput("stats") #create a space for stats - order matter for which shows up first
)
#to write function - 
# 1. need to call output via output$ "inoputID" object
# 2. render the object with ({})
server <- function(input, output) {
  data<-reactive({
    tibble(x = rnorm(input$num)) #make dataset own object that is reactive everytime num is changed
  })
    
  output$hist <- renderPlot({     #ggplot r code placed here to make plot 
    
    # {} allows us to put all our R code in one nice chunck
    # First, a static histogram
    # this first line become deprecated when adding a reactive
    # data<-tibble(x = rnorm(input$num)) # change the data to make plot based on inputID from above
    ggplot(data(), aes(x = x))+ # make a histogram
      geom_histogram() +
      labs(title = input$title) #add a new title based on value in textinput above
  }) #no comma, since compete functions
  output$stats <- renderPrint({
    #summary to input$sum become deprecated when using reactive object
    # summary(rnorm(input$num)) #calculate summary stats based on output - but using input$num uses a different set of random number
    summary(data())
  })
} 
shinyApp(ui = ui, server = server)

#to make a slider input - an input will have "type"input
# every input needs a inputid - need to be same everytime
#label = title going over the slider
# value = starting value when open website
# min/ max value

