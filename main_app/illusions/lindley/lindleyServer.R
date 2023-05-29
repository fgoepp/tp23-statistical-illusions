source("illusions/lindley/utils.R")
lindleyServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # scale percentages
    H0_p <- reactive({
      input$H0_p / 100
    })
    significance_level <- reactive({
      input$significance_level / 100
    })
    p <- reactive({
      input$p / 100
    })

    # Create the binomial distributed data
    # Attention: This data needs to be shared between multiple
    # outputs so it needs to be created only once
    data <- reactive({
      create_data(input$n, p())
    })

    # Print what each approach does with H0
    output$accept_or_reject <- renderText({
      paste(
        get_frequentist_decision(data(), H0_p(), significance_level()),
        "\n", get_unif_bayes_decision(data(), H0_p())
      )
    })

    # Plot the data and the distributions
    output$plot <- renderPlot({
      plot_distributions_uniform(input$n, p(), data(), H0_p())
    })

    # Explain text
    output$text_description <- renderText({
      paste("dei mudda")
    })
  })
}
