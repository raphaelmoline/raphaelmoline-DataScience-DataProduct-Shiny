library(shiny)
library(ggplot2)

dataset <- diamonds


fluidPage(
    
    titlePanel("Diamonds Explorer"),
    
    sidebarPanel(
        
        sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                    value=min(5000, nrow(dataset)), step=500, round=0),
        
        selectInput('x', 'X', names(dataset)),
        selectInput('y', 'Y', names(dataset), names(dataset)[[7]]),
        selectInput('color', 'Color', c('None', names(dataset)),names(dataset)[[3]] ),
        
        checkboxInput('smooth', 'Smooth'),
        
        selectInput('facet_col', 'Facet Column', c(None='.', names(dataset))),
        selectInput('filter_cut', 'Filter Cut', c(levels(diamonds$cut)),
                    selected = levels(diamonds$cut), multiple = TRUE),
        selectInput('filter_color', 'Filter Color', c(levels(diamonds$color)),
                    selected = levels(diamonds$color), multiple = TRUE),
        selectInput('filter_clarity', 'Filter Clarity', c('None', levels(diamonds$clarity)))
    ),
    
    mainPanel(
        plotOutput('plot')
    )
)