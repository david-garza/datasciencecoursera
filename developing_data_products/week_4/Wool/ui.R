#
# Date: 02/28/2021
# Author: David Garza
# Purpose: Complete week 4 Developing Data Products project for the Data Science
# coursera class. This project uses the warpbreaks data set.


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Warp Breaks Analysis"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            checkboxInput("wool","Wool Type",value = TRUE),
            checkboxInput("tension","Level of Tension", value = TRUE)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("boxPlot"),
            tableOutput("summary")
        )
    )
))
