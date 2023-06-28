birthdayServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # updates category slider when a category is selected
    observeEvent(input$category_selector, {
      if (input$category_selector == "birthday in a year") {
        updateSliderInput(session, "c", value = 365, max = 400)
      } else if (input$category_selector == "favourite planet of our solarsystem") {
        updateSliderInput(session, "c", value = 8, max = 400)
      } else if (input$category_selector == "favorite element of the periodic table") {
        updateSliderInput(session, "c", value = 118, max = 400)
      }
    })

    calculateProbability <- function(n, c) {
      probabilities <- sapply(1:n, function(i) {
        p <- (1 - prod(1 - (0:(i - 1)) / c)) * 100
        p
      })
      probabilities
    }

    output$probability_plot <- renderPlot({
      n <- 1:input$n
      c <- input$c
      probabilities <- calculateProbability(input$n, c)
      data <- data.frame(n = n, p = probabilities)
      plot <- barplot(data$p,
        names.arg = data$n, main = "Probability Distribution", xlab = "Number of people", ylab = "Probability in %",
        ylim = c(0, 100), border = "black"
      )
      # Add x-axis line
      abline(h = 0, col = "black", lwd = 2)
      # Real probability
      abline(h = (1 - prod(1 - (1:(input$n - 1)) / input$c)) * 100, col = "red", lwd = 2)

      # check whether guess is valid input
      if (!is.null(input$guess_input)) {
        guess <- as.numeric(input$guess_input)
        if (!is.na(guess) && guess >= 0 && guess <= 100) {
          abline(h = guess, col = "blue", lwd = 2)
        } else {
          output$guess_text <- renderText({
            "Invalid guess input. Please enter a number between 0 and 100."
          })
        }
      }
      # legend
      legend("topleft", legend = c("Real Probability", "Your Guess"), col = c("red", "blue"), lwd = 1)
      plot
    })

    # real probability
    output$probability_text <- renderText({
      paste0("Real probability: ", sprintf("%.4f", (1 - prod(1 - (1:(input$n - 1)) / input$c)) * 100), "%")
    })
    output$guess_text <- renderText({
      paste0("Your Guess: ", sprintf("%s", input$guess_input), "%")
    })

    # Explanation / Text / History etc
    output$text_description <- renderText({
      "history mistory etc"
    })

    output$download_plot <- downloadHandler(
      filename = function() {
        "plot.jpg"
      },
      content = function(file) {
        jpeg(file)
        n <- 1:input$n
        c <- input$c
        probabilities <- calculateProbability(input$n, c)
        data <- data.frame(n = n, p = probabilities)
        barplot(data$p,
          names.arg = data$n, main = "Probability Distribution", xlab = "Person", ylab = "Probability",
          ylim = c(0, 100), border = "black"
        )
        dev.off()
      }
    )
  })
}
