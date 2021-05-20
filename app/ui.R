shinyUI(fluidPage(
    titlePanel('Measurement of Inequality'),
    sidebarLayout(
        sidebarPanel(
            radioButtons('InDist', 'Sample Distribution', c('Uniform', 'Normal', 'Log-Normal', 'Pareto')),
            sliderInput('InSamp', 'Sample Size', 10, 1000, 100, 10),
            actionButton('InUpdate', 'Update'),
            br(), br(),
            htmlOutput('giniVal'),
            htmlOutput('theilVal'),
            htmlOutput('hooverVal'),
            htmlOutput('herfVal'),
            htmlOutput('coulterVal'),
            htmlOutput('atkinsonVal'),
            htmlOutput('daltonVal'),
            htmlOutput('cvVal')
        ),
        mainPanel(
            plotOutput("distPlot"),
            plotOutput('lorenzPlot'),
            plotOutput('atkinsonPlot')
        )
    )
))
