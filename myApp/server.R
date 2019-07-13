library(shiny)
library(ggplot2)
library(dplyr)

function(input, output) {
    
    dataset <- reactive({
        df <- diamonds[sample(nrow(diamonds), input$sampleSize),]
        df <- filter(df, cut %in% input$filter_cut)
        df <- filter(df, color == input$filter_color)
        if (input$filter_clarity != 'None')
            df <- filter(df, clarity == input$filter_clarity)
        return (df)
    })


    output$plot <- renderPlot({
        
        p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
        
        if (input$color != 'None')
            p <- p + aes_string(color=input$color)
        
        facets <- paste('. ~', input$facet_col)
        if (facets != '. ~ .')
            p <- p + facet_grid(facets)
        
        if (input$smooth)
            p <- p + geom_smooth()
        
        print(p)
        
    }, height=700)
    
}