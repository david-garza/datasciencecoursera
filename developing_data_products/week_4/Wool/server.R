# Date: 02/28/2021
# Author: David Garza
# Purpose: Complete week 4 Developing Data Products project for the Data Science
# coursera class. This project uses the warpbreaks data set.

library(shiny)

# Define server logic required to create the boxplots and linear regression models
# based on which factors the user selects.
shinyServer(function(input, output) {

    output$boxPlot <- renderPlot({
        if((input$wool)&(input$tension))
            boxplot(breaks~tension+wool,data=warpbreaks,
                    main="Number of Warp Breaks vs Level of Tension and Wool Type",
                    names=c("Low A","Low B", "Medium A","Medium B", "High A","High B"),
                    xlab = "Tension : Wool Type",
                    ylab = "Number of Breaks",
                    col="purple")
        else if(input$wool)
            boxplot(breaks~wool,data=warpbreaks,
                    main="Number of Warp Breaks vs Wool Type",
                    xlab="Wool Type",
                    ylab = "Number of Breaks",
                    col="lightblue")
        else if(input$tension)
            boxplot(breaks~tension,data=warpbreaks,
                    main="Number of Warp Breaks vs Level of Tension",
                    xlab = "Level of Tension",
                    ylab = "Number of Breaks",
                    names=c("Low", "Medium", "High"),
                    col="red")
    })
    
    model1<-lm(breaks~wool+tension,data=warpbreaks)
    summary1<-summary(model1)
    
    model2<-lm(breaks~wool,data=warpbreaks)
    summary2<-summary(model2)
    
    model3<-lm(breaks~tension,data=warpbreaks)
    summary3<-summary(model3)
    
    output$summary <-renderTable({
        if((input$wool)&(input$tension))
            summary1$coefficients
        else if(input$wool)
            summary2$coefficients
        else if(input$tension)
            summary3$coefficients
    }, rownames = TRUE)

})
