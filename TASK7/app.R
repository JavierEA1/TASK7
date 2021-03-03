#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)

library(Stat2Data)
data(AccordPrice)
Data=AccordPrice
dataPanel <- tabPanel("Data",
                     selectInput(
                         inputId = "Select",
                         label = "Select the Age",
                         choices = Data %>% select(Age) %>% unique %>% arrange
                     ),
                     tableOutput("data")
)
# Define UI for application that draws a histogram
ui <- fluidPage(navbarPage("Shiny app",
                           tabPanel("Histogram",
    fluidPage(                              
    # Application title
    titlePanel("AccordPrice  Data"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 20)
        
            
            ),
        
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
                        )
                    )
                )
            )
        ,
    dataPanel 
))
# Define server logic required to draw a histogram
server <- function(input, output) {
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- Data$Age
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    output$data<-renderTable(Data %>% filter(Age == input$Select))
 
    
}

# Run the application 
shinyApp(ui = ui, server = server)
