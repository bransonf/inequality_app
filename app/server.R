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
    
    output$needFunctionPlot <- renderPlot({
        with(
            Plorenz(y=dist(), plot=TRUE), 
            plot(cnx, cny, type = 'l', xlab = 'Weight', ylab = 'Resource',
                 main = 'Cumulative Need Function',
                 sub = 'Resorces Needed to Achieve Given Level of Equity'
            )
        )
        segments(0,0,1,1,lty=3)
        with(
            Plorenz(y=dist(), plot=TRUE), 
            lines(cnx, cnn, col = 'red')
        )
        text(x=0,y=0.6, labels = 'Lorenz', adj = 0)
        text(x=0,y=0.5, labels = 'Cumulative Need Function', col = 'red', adj = 0)
    })
    
    output$prioritarianPlot <- renderPlot({
        lor = Plorenz(y=dist(), plot=FALSE)
        with(
            Plorenz(y=dist(), plot=TRUE),
            plot(cnx, cny, type = 'l', xlab = 'Weight', ylab = 'Resource',
                 main = 'Prioritarian Allocation Function',
                 # sub = ''
            )
        )
        segments(0,0,1,1,lty=3)
        with(
            Pallocate(lor, sum(dist()) * .1, plot=TRUE),
            lines(cnx, cny, col = 'purple')
        )
        with(
            Pallocate(lor, sum(dist()) * .3, plot=TRUE),
            lines(cnx, cny, col = 'blue')
        )
        with(
            Pallocate(lor, sum(dist()) * .5, plot=TRUE),
            lines(cnx, cny, col = 'darkolivegreen')
        )
        with(
            Pallocate(lor, sum(dist()) * 2, plot=TRUE),
            lines(cnx, cny, col = 'goldenrod3')
        )
        text(x=0,y=0.8, labels = '200% of Current', adj = 0, col = 'goldenrod3')
        text(x=0,y=0.7, labels = '50% of Current', adj = 0, col = 'darkolivegreen')
        text(x=0,y=0.6, labels = '30% of Current', adj = 0, col = 'blue')
        text(x=0,y=0.5, labels = '10% of Current', adj = 0, col = 'purple')
        text(x=0,y=0.4, labels = 'Lorenz', adj = 0)
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
