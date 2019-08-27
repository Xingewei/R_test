#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predict miles per garlon based on selected horse power and transmission type"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1("Please select the following 2 choices, the result will be showed in far right 2 tabs.") ,
            h2("Transmission Type:") ,
            checkboxInput("auto","Manu transmission",value=T),
            sliderInput("HP",  "Horse Power:",  min = 50, max = 450,  value = 200),
            submitButton("Submit")
       ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type='tabs',
                        tabPanel("Data", br(),   DT::dataTableOutput('data')), 
                        tabPanel("Plot", br(),   plotOutput('plot')),
                        tabPanel("Final model and plot", br(),   plotOutput('plot1')),
                        tabPanel("Predict Miles Per Garlon", br(),textOutput('pmpg'))
                        )
        )
    )
))
