shinyServer(function(input, output) {

    dist <- reactiveVal(runif(100))
    
    observeEvent(input$InUpdate, {
        distType <- switch (input$InDist,
            'Uniform' = runif,
            'Normal' = rnorm2,
            'Log-Normal' = rlnorm,
            'Pareto' = rpareto
        )
        dist(distType(input$InSamp))
    })
    
    # Plots
    output$distPlot <- renderPlot({
        hist(dist(), main = 'Histogram of Distribution', xlab = '')
    })
    
    output$lorenzPlot <- renderPlot({
        REAT::lorenz(sort(dist()))
    })
    
    output$atkinsonPlot <- renderPlot({
        atk <- 1:100 * 0.05
        plot(
            atk, sapply(atk, function(e) REAT::atkinson(dist(), e)), type = 'l',
            xlab = 'Epsilon  \U2794 (Increasing Aversion to Inequality)', ylab = 'Atkinson\'s Index',
            main = 'Atkinson\'s Index as Function of Epsilon'
        )
    })
    
    # Text Values
    output$giniVal <- renderText({
        make_text_out('Gini', REAT::gini(dist()))
    })
    output$theilVal <- renderText({
        make_text_out('Theil', REAT::theil(dist()))
    })
    output$hooverVal <- renderText({
        make_text_out('Hoover', REAT::hoover(dist()))
    })
    output$herfVal <- renderText({
        make_text_out('Herfindahl-Hirschman', REAT::herf(dist()))
    })
    output$coulterVal <- renderText({
        make_text_out('Coulter', REAT::coulter(dist()))
    })
    output$atkinsonVal <- renderText({
        make_text_out('Atkinson (e = 0.5)', REAT::atkinson(dist()))
    })
    output$daltonVal <- renderText({
        make_text_out('Dalton', REAT::dalton(dist()))
    })
    output$cvVal <- renderText({
        make_text_out('Coefficient of Variation', REAT::cv(dist()))
    })
})
