# server.R

require(shiny)
require(ggplot2)
require(ggthemes)

set.seed(31416)
LifeExp <- read.csv("data/LifeExp.csv")

# server.R

shinyServer(
    function(input, output) {
        
         dataset <- reactive({
           a <- LifeExp[LifeExp$age == input$age &
                          LifeExp$year >= input$range[1] &
                          LifeExp$year <= input$range[2],]
           n <- nrow(a) 
           m <- nrow(a[a$year > 2000,])
           fit <- lm(exp ~ year + sex, data = a[1:(n-m),])
           
           i <- 1
           while(i <= m){
             a$exp[n-m+i] <- fit$coefficients[1] + fit$coefficients[2] * 
                   a$year[n-m+i] + fit$coefficients[3] * ((n-m+i) %% 2)
             i <- i + 1
           }
           
            return(a)
         })
        
        output$plot <- renderPlot({
            
            g <- ggplot(dataset(), aes(x = factor(year), y = exp + age, fill = year)) + 
                geom_bar(stat="identity", position = "dodge") + facet_wrap( ~ sex) +
                labs(x = "Year of Calculated Life Expectancy", y = "Expected Life Span") +
                ylim(0,100) + theme_economist() + scale_color_economist() + 
                theme(legend.position="none")
            
            print(g)
        })
        
    })