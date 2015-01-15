# server.R
# Plot of raw time series data with moving average over it.

library(shiny)
library(zoo, warn.conflicts = FALSE)

MAXROWS <- 10000
mav <- function(x,n=5){filter(x,rep(1/n,n), sides=2)}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Generate a time series plot and return plot to UI.
    # Call is reactive so it updates on input change.
    #

    output$distPlot <- renderPlot({
      
        # Read in file
        # File should be 1 column of TS data values or 2 columns with the sequence 
        #   in column 1 and the TS data value in column 2.  Data is limited to 10000
        #   rows.
        inFile <- input$file1
        if (is.null(inFile))
            return(NULL)
        seriesData <- read.csv(inFile$datapath, nrows=MAXROWS)
        
        # Process 1 col and 2 col files appropriately
        if (ncol(seriesData) == 1) {
            # Calculate moving average
            moving <- mav(seriesData, n=input$samples)
            # draw the time series plot with the moving average overlay
            myPlot <- ts.plot(seriesData, moving, gpars = list(col = c("black", "red")))
        } else if (ncol(seriesData) == 2) {
            # Calculate moving average
            moving <- mav(seriesData[2], n=input$samples)
            # draw the time series plot with the moving average overlay
            myPlot <- ts.plot(seriesData[2], moving, gpars = list(col = c("black", "red")))
        } else {
            return(NULL)
        }
    
    })
})

