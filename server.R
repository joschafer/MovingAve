# server.R
# Plot of raw time series data with moving average over it.

library(shiny)
library(zoo, warn.conflicts = FALSE)

mav <- function(x,n=5){filter(x,rep(1/n,n), sides=2)}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  output$distPlot <- renderPlot({
      # Read in file 
      inFile <- input$file1

      if (is.null(inFile))
          return(NULL)
    
    seriesData <- read.csv(inFile$datapath)
    moving <- mav(seriesData, n=input$samples)
    
    # draw the time series plot with the moving average overlay
    myPlot <- ts.plot(seriesData, moving, gpars = list(col = c("black", "red")))
    
  })
})

