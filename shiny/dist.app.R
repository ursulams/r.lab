## shiny app demonstrating common statistical distributions

library(shiny)
library(shinythemes)
library(ggplot2)
library(ggthemes)
library(sn)

ui <- shinyUI(fluidPage(theme = shinytheme("united"),
                  headerPanel("explore common statistical distributions"),
                  fluidRow(
                    column(4, 
                           wellPanel(
                             radioButtons("dist", "select a distribution type:", 
                                          list("normal" = "norm",
                                               "nonnormal (negative skewed)" = "nonnorm",
                                               "uniform" = "unif", 
                                               "exponential" = "exp",  
                                               "log-normal" = "lnorm")), 
                             sliderInput("n", "sample size:", 10, 1000, 500), 
                             uiOutput("dist1"), 
                             uiOutput("dist2")
                             )
                           ),
                    column(8, 
                           tabsetPanel(
                             tabPanel("plot", plotOutput("plot", height = "400px")), 
                             tabPanel("summary", verbatimTextOutput("summary"),
                                      br(),
                                      plotOutput("sum.plot", height = "350px"))
                           )
                    )
                  )
                  ))

rexp2 <- function(n = 500, rate2 = 1){rexp(n = n, rate = rate2)}
rbeta2 <- function(n = 500, shape1 = 5, shape2 = 2){rbeta(n = n, shape1 = shape1, shape2 = shape2)}

server <- shinyServer(function(input, output){
  dat <- reactive({
    dist <- switch(input$dist, 
                   norm = rnorm, nonnorm = rbeta2, unif = runif, exp = rexp2, lnorm = rlnorm)
    
    def.args <- switch(input$dist, 
                       norm = c(input$mean, input$sd), 
                       unif = c(input$ min, input$max), exp = c(input$rate2), 
                       lnorm = c(input$meanlog, input$sdlog))
    
    f <- formals(dist)
    f <- f[names(f)!= "n"] 
    len <- min(length(f), 3-1)
    f <- f[1:len]
    argList <- list(n = input$n)
    for(i in 1:len) argList[[names(f)[i]]] <- def.args[i]
    return(list(do.call(dist, argList), names(f)))
  })
  
  output$dist1 <- renderUI({
    input$dist
    isolate({
      lab <- switch(input$dist, 
                    norm = "mean:", unif = "minimum:", 
                    exp = "mean arrival rate:", lnorm = "mean(log):")
      ini <- switch(input$dist, 
                    norm = 0, unif = 0, exp = 1, lnorm = 0)
      numericInput(dat()[[2]][1], lab, ini, min = 0, max = 5)
    })
  })
  
  output$dist2 <- renderUI({
    input$dist
    isolate({
      lab <- switch(input$dist, 
                    norm = "standard deviation:", unif = "maximum:",
                    lnorm = "standard devlation(log):")
      ini <- switch(input$dist, 
                    norm = 1, lnorm = 1, unif = 5)
      if(any(input$dist == c("norm", "lnorm", "unif"))) numericInput(dat()[[2]][2], lab, ini,
                                                                     min = 0, max = 5)
    })
  })
  
  output$plot <- renderPlot({
    if (input$dist == "nonnorm") {
    df <- data.frame(x = dat()[[1]])
    ggplot(df, aes(x)) +
      geom_density(color = "navy", fill = "#99c1cc", alpha = 0.7) +
      xlim(0, 1.5) +
      theme_pander() 
    } 
    else if (input$dist != "nonnorm") {
    df <- data.frame(x = dat()[[1]])
    ggplot(df, aes(x)) +
      geom_density(color = "navy", fill = "#99c1cc", alpha = 0.7) +
      xlim(-5, 5) +
      theme_pander() 
    }  
  })
  
  output$summary <- renderPrint({
    summary(dat()[[1]])
  })
  
  output$sum.plot <- renderPlot({
    df.y <- data.frame(y = dat()[[1]])
    ggplot(df.y, aes(x = factor(0), y, color = y)) +
      geom_boxplot(outlier.colour = "#f2a400", outlier.size = 3, fill = "#99c1cc", col = "navy") +
      scale_x_discrete("", breaks = NULL) +
      labs(title = "5 points of the distribution",
           x = "", y = "observed values")+
      theme_pander()
  })
  
})

shinyApp(ui = ui, server = server)
