# ui.R

require(shiny)
require(ggplot2)
require(ggthemes)


shinyUI(fluidPage(
    titlePanel("Life Expectancy Throughout the Last Century 
               and Future"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Create a chart of what your expected lifespan 
                     might be at various times over the last century, 
                     and see how that might change in the future, based upon 
                     your current age."),
            
            selectInput("age", 
                        label = "Select your age:",
                        choices = 0:95, selected = 30),
            
            helpText("See how the prediction might change if you exclude earlier years' 
                     mortality tables in the prediction."),
            
            sliderInput("range", 
                        label = "Range of years:",
                        min = 1900, max = 2040, value = c(1900, 2040), step = 20,
                        format="###0")
        ),
        
        mainPanel(plotOutput("plot"))
    )
))