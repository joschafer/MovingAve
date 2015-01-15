# ui.R

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Moving Average"),
  ## TODO Add documentation
  p("The Moving Average application takes a file with time series data inside and provides both a simple display of the data and a display of a moving average for the data. The file can be a 1 column or 2 column CSV file with the time series data in the last column.  It is ecpected to be in order.  The other limitaion is that the data load is limited to 10,000 samples.  In addition to displaying the data, the moving everage window can be adjusted from 2 to 40 bins with a default size of 5 bins."),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(fileInput('file1', 'Choose CSV File',
                accept=c('text/csv',
                    'text/comma-separated-values,text/plain', '.csv')),
      sliderInput("samples",
                  "Samples in Moving Average:",
                  min = 2,
                  max = 40,
                  value = 5)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

