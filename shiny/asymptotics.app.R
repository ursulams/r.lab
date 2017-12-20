# shiny app demonstrating the weak law of large numbers and the central limit theorem
# author: ursula kaczmarek (github: ursulakaczmarek)

library(shiny)
library(shinythemes)
library(ggplot2)
library(ggthemes)

ui <- shinyUI(
  fluidPage(theme = shinytheme("united"),
            headerPanel("asymptotics & the behavior of large sample sizes"),
            fluidRow(
              column(4,
                     wellPanel(HTML("<h4><span style=color:#1e656d>law of large numbers</span></h4>"),
                              p("when we toss a fair coin, we expect it to land on
                                 heads (p = 1) half the time and on tails the other half (1-p = 0)."), 
                              p("according to the law of large numbers, the cumulative 
                                 average of the tosses converges to 0.5, the probability of landing on 
                                 either heads or tails, as the number of 
                                 tosses approaches infinity.")
                               ), 
                     wellPanel(HTML("<h4><span style=color:#1e656d>central limit theorem</span></h4>"),
                              p("let one sample equal fifty coin tosses. in some samples 
                                the tosses will result in many heads (sample mean > 0.5), 
                                in others many tails (sample mean < 0.5)."),
                              p("the central 
                                limit theorem tells us that as the number of samples 
                                (n) increases, the distribution of those properly 
                                normalized sample means becomes a standard normal distribution."),
                               
                              HTML("<p>to normalize the sample means, we subtract
                                 0.5 (the population mean) from each sample mean 
                                 and divide the difference by the standard deviation 
                                 over the square root of the sample size: <sup>
                                 x&#772; - &#956;</sup>&frasl;<sub>(&#963/&Sqrt;n)</sub></p>"
                                 )
                      )
                     ),
                column(8,
                       tabsetPanel(
                         tabPanel("law of large numbers", 
                                  tags$style("html, body {width:100%;height:100%}"),
                                  sliderInput("flip.n", "choose a number of coin tosses", 1, 250, 1),
                                  plotOutput("coin.plot", height = "350px")), 
                         tabPanel("central limit theorem", 
                                  tags$style("html, body {width:100%;height:100%}"),
                                  sliderInput("sample.n", "select a number of samples", 10, 500, 10),
                                  plotOutput("sum.plot", height = "400px"))
                                 )
                      )
                )
  )
)

server <- shinyServer(function(input, output){

output$coin.plot <- renderPlot({
      fn <- input$flip.n
      means <- cumsum(sample(0 : 1, fn , replace = TRUE)) / (1 : fn)
      g <- ggplot(data.frame(x = 1 : fn, y = means), aes(x = x, y = y)) +
      geom_hline(size = 0.3 , yintercept = 0.5, alpha = 0.3) + 
      geom_line(size = 0.4, color = "#1e656d", alpha = 0.6) + 
      geom_point(color = "#f62a00", size = 2) +
      scale_x_continuous(name = "number of flips", breaks = seq(0, fn + 1, ceiling(fn/10))) + 
      ylim(0, 1)
      g + ylab("cumulative mean") +
      theme_pander() 
  })

output$sum.plot <- renderPlot({
    sn <- input$sample.n
    cfunc <- function(x, n) 2 * sqrt(n) * (mean(x) - 0.5) 
    df <- data.frame(x = c(apply(matrix(sample(0:1, sn*50, replace = TRUE), sn), 1, cfunc, 50)))
    g <- ggplot(df, aes(x = x, alpha = 0.5)) + 
    geom_histogram(binwidth = 0.3, color = "#1e656d", fill = "#1e656d", aes(y = ..density..)) + 
    stat_function(fun = dnorm, size = 2, color = "#f62a00") 
    g + theme_pander(lp = "none")
  })
  
})

shinyApp(ui = ui, server = server)
