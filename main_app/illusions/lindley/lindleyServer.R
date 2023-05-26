source("illusions/lindley/utils.R")
library(BayesFactor)
lindleyServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Create the binomial distributed data
    # Attention: This data needs to be shared between multiple
    # outputs so it needs to be created only once
    data <- reactive({
      create_data(input$n, input$p)
    })

    # Print what each approach does with H0
    output$accept_or_reject <- renderText({
      #here 2 times paste
      
      paste("Bayesian: ", '<span style="color: red;">', get_unif_bayes_decision(data, input$H0_p), "</span>", sep = "")
      paste("Frequentist: ", '<span style="color: green;">',
        get_frequentist_decision(data, input$H0_p, input$significance_level), "</span>",
        sep = ""
      )
    })

    # Plot the data and the distributions
    output$plot <- renderPlot({
      boxplot(weight ~ Diet, data = ChickWeight, xlab = "Diet", ylab = "Weight")
    })

    # Explain text
    output$text_description <- renderText({
      paste("dei mudda")
    })
  })
}
