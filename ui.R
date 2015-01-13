# ui.R

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Moving Average"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(fileInput('file1', 'Choose CSV File',
                accept=c('text/csv',
                    'text/comma-separated-values,text/plain', '.csv')),
      sliderInput("samples",
                  "Samples in MVA:",
                  min = 2,
                  max = 40,
                  value = 10)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

