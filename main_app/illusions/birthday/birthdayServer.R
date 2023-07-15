source("illusions/birthday/utils.R")
birthdayServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # reactive values
    n_reac <- reactive({
      input$n
    })
    c_reac <- reactive({
      input$c
    })

    isGuessState <- function() {
      return(n_reac() == 70 && c_reac() == 365)
    }

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

    output$probability_plot <- renderPlot({
      n <- 1:input$n
      probabilities_bday1 <- calculateProbabilityBday(input$n, input$c, "second_prob")
      probabilities_bday2 <- calculateProbabilityBday(input$n, input$c, "first_prob")

      data <- data.frame(n = n, p1 = probabilities_bday1, p2 = probabilities_bday2)

      # guesses data
      if (isGuessState()) {
        first_guess_data <- data.frame(
          x = rep(barplot(data$p1)[input$n], 2),
          y = as.numeric(input$first_guess_input)
        )

        second_guess_data <- data.frame(
          x = rep(barplot(data$p1)[input$n - 30], 2),
          y = as.numeric(input$second_guess_input)
        )

        # answers data
        first_answer_data <- data.frame(
          x = rep(barplot(data$p1)[input$n], 2),
          y = (1 - ((input$c - 1) / input$c)^(input$n)) * 100
        )
        second_answer_data <- data.frame(
          x = rep(barplot(data$p1)[input$n - 30], 2),
          y = (1 - prod(1 - (1:((input$n - 30) - 1)) / input$c)) * 100
        )
      }

      plot <- barplot(data$p1,
        names.arg = data$n,
        main = "Probability Distribution",
        col = "lightgrey",
        xlab = "Number of people",
        ylab = "Probability in %",
        ylim = c(0, 100), border = "black"
      )
      barplot(data$p2,
        names.arg = data$n, add = TRUE, col = "darkgrey"
      )

      # Add x-axis line
      abline(h = 0, col = "black", lwd = 2)



      if (isGuessState()) {
        # Point for the answers
        points(first_answer_data$x, first_answer_data$y, lwd = 3, col = "darkgreen", pch = 19)
        points(second_answer_data$x, second_answer_data$y, lwd = 3, col = "darkblue", pch = 19)

        # Check the validity of the first guess input
        first_guess <- as.numeric(input$first_guess_input)
        if (!is.null(input$first_guess_input) && !is.na(first_guess) && first_guess >= 0 && first_guess <= 100) {
          # Point for the first guess if it's valid
          output$text_first_guess <- renderText({
            if (isGuessState()) {
              paste0(
                "your first guess: ",
                sprintf("%s%%", input$first_guess_input),
                " (guess would be correct for: ", calculateNBday((input$first_guess_input / 100), input$c, "first_prob"), " people)"
              )
            }
          })
          points(first_guess_data$x, first_guess_data$y, lwd = 3, col = "darkgreen", pch = 4)
        } else {
          output$text_first_guess <- renderText({
            if (isGuessState()) {
              "Invalid guess input. Please enter a number between 0 and 100."
            }
          })
        }

        # Check the validity of the second guess input
        second_guess <- as.numeric(input$second_guess_input)
        if (!is.null(input$second_guess_input) && !is.na(second_guess) && second_guess >= 0 && second_guess <= 100) {
          # Point for the second guess if it's valid
          output$text_second_guess <- renderText({
            if (isGuessState()) {
              paste0(
                "your second guess: ",
                sprintf("%s%%", input$second_guess_input),
                " (guess would be correct for: ", calculateNBday((input$second_guess_input / 100), input$c, "second_prob"), " people)"
              )
            }
          })
          points(second_guess_data$x, second_guess_data$y, lwd = 3, col = "darkblue", pch = 4)
        } else {
          output$text_second_guess <- renderText({
            if (isGuessState()) {
              "Invalid guess input. Please enter a number between 0 and 100."
            }
          })
        }
      }
      if (isGuessState()) {
        legend_beginning <- getLegendBeginning()
      } else {
        legend_playing <- getLegendPlaying()
      }
      plot
    })

    output$text_n_and_c_first <- renderText({
      if (!isGuessState()) {
        paste0(" n = ", input$n, "\nand c = ", input$c)
      }
    })
    output$text_n_and_c_second <- renderText({
      if (!isGuessState()) {
        paste0(" n = ", input$n, "\nand c = ", input$c)
      }
    })
    output$text_first_distribution <- renderText({
      if (!isGuessState()) {
        paste0(
          "The probability that one of n people (= number of people)
           present shares the same c ( = number of category ex: day of birth in a year) as you?"
        )
      }
    })
    output$text_second_distribution <- renderText({
      if (!isGuessState()) {
        paste0(
          "The probability that two
          or more people of n (= number of people) share the same c ( = number of category ex: day of birth in a year)?"
        )
      }
    })
    output$text_first_question <- renderText({
      if (isGuessState()) {
        paste0(
          "What do you think is the probability that one of n (here n = 70)
            people present shares the same day of birth as you in a year?"
        )
      }
    })

    output$text_second_question <- renderText({
      if (isGuessState()) {
        paste0(
          "What do you think is the probability that two
          or more people of n (here n = 40) share the same day of birth in a year?"
        )
      }
    })

    output$text_first_answer <- renderText({
      probability <- calculateProbabilityBday(input$n, input$c, "first_prob")[input$n]
      paste0("probability = ", sprintf("%.4f", probability), "%")
    })

    output$text_second_answer <- renderText({
      if (isGuessState()) {
        probability <- calculateProbabilityBday(input$n, input$c, "second_prob")[40]
        paste0("probability = ", sprintf("%.4f", probability), "%")
      }
    })
    output$text_second_prob <- renderText({
      if (!isGuessState()) {
        probability <- calculateProbabilityBday(input$n, input$c, "second_prob")[input$n]
        paste0("probability = ", sprintf("%.4f", probability), "%")
      }
    })
    output$text_instruction_sliders <- renderText({
      if (isGuessState()) {
        paste0("Try different values for 'n' and 'c', move the sliders on the left hand side")
      }
    })
    output$text_instruction_goback <- renderText({
      if (!isGuessState()) {
        paste0("To see the distributions of the problems or and your guesses, choose n = 70 and c = 365")
      }
    })

    # Explanation / Text / History etc
    output$text_description <- renderText({
      "history mistory etc"
    })
  })
}
