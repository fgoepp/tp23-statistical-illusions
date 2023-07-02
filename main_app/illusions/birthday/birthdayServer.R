birthdayServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    n_reac <- reactive({
      input$n
    })
    c_reac <- reactive({
      input$c
    })

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

    calculateProbabilityBday2 <- function(n, c) {
      probabilities <- sapply(1:n, function(i) {
        p <- (1 - ((c - 1) / c)^i) * 100
        p
      })
      probabilities
    }

    calculateProbabilityBday1 <- function(n, c) {
      probabilities <- sapply(1:n, function(i) {
        p <- (1 - prod(1 - (0:(i - 1)) / c)) * 100
        p
      })
      probabilities
    }

    output$probability_plot <- renderPlot({
      n <- 1:input$n
      c <- input$c
      probabilities_bday1 <- calculateProbabilityBday1(input$n, c)
      probabilities_bday2 <- calculateProbabilityBday2(input$n, c)


      data <- data.frame(n = n, p1 = probabilities_bday1, p2 = probabilities_bday2)
      # guesses data
      if (n_reac() == 70 && c_reac() == 365) {
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



      if (input$n == 70 && input$c == 365) {
        # Point for the answers
        points(first_answer_data$x, first_answer_data$y, lwd = 3, col = "darkgreen", pch = 19)
        points(second_answer_data$x, second_answer_data$y, lwd = 3, col = "darkblue", pch = 19)

        # Check the validity of the first guess input
        first_guess <- as.numeric(input$first_guess_input)
        if (!is.null(input$first_guess_input) && !is.na(first_guess) && first_guess >= 0 && first_guess <= 100) {
          # Point for the first guess if it's valid
          points(first_guess_data$x, first_guess_data$y, lwd = 3, col = "darkgreen", pch = 4)
        } else {
          output$first_guess_text <- renderText({
            "Invalid guess input. Please enter a number between 0 and 100."
          })
        }

        # Check the validity of the second guess input
        second_guess <- as.numeric(input$second_guess_input)
        if (!is.null(input$second_guess_input) && !is.na(second_guess) && second_guess >= 0 && second_guess <= 100) {
          # Point for the second guess if it's valid
          points(second_guess_data$x, second_guess_data$y, lwd = 3, col = "darkblue", pch = 4)
        } else {
          output$second_guess_text <- renderText({
            "Invalid guess input. Please enter a number between 0 and 100."
          })
        }
      }
      if (n_reac() == 70 && c_reac() == 365) {
        # legend for the beginning.
        legend("topleft",
          inset = 0.01,
          pch = c(15, 15, 19, 4, 19, 4),
          col = c("darkgrey", "lightgrey", "darkgreen", "darkgreen", "darkblue", "darkblue"),
          legend = c(
            "distribution first problem", "distribution second problem",
            "probability question one", "first guess", "probability question two", "second guess"
          ),
          text.col = c("black", "black", "darkgreen", "darkgreen", "darkblue", "darkblue")
        )
      } else {
        # legend for playing around
        legend("topleft",
          inset = 0.01,
          pch = c(15, 15),
          col = c("darkgrey", "lightgrey"),
          legend = c(
            "distribution first problem", "distribution second problem"
          ),
          text.col = c("black", "black")
        )
      }
      plot
    })

    output$n_and_c_first <- renderText({
      if (n_reac() != 70 || c_reac() != 365) {
        paste0(" n = ", input$n, "\nand c = ", input$c)
      }
    })
    output$n_and_c_second <- renderText({
      if (n_reac() != 70 || c_reac() != 365) {
        paste0(" n = ", input$n, "\nand c = ", input$c)
      }
    })

    output$first_distribution <- renderText({
      if (n_reac() != 70 || c_reac() != 365) {
        paste0(
          "The probability that one of n people (= number of people)
           present shares the same c ( = number of category ex: day of birth in a year) as you?"
        )
      }
    })
    output$second_distribution <- renderText({
      if (n_reac() != 70 || c_reac() != 365) {
        paste0(
          "The probability that two
          or more people of n (= number of people) share the same c ( = number of category ex: day of birth in a year)?"
        )
      }
    })


    output$first_question_text <- renderText({
      if (n_reac() == 70 && c_reac() == 365) {
        paste0(
          "What do you think is the probability that one of n (here n = 70)
            people present shares the same day of birth as you in a year?"
        )
      }
    })

    output$second_question_text <- renderText({
      if (n_reac() == 70 && c_reac() == 365) {
        paste0(
          "What do you think is the probability that two
          or more people of n (here n = 40) share the same day of birth in a year?"
        )
      }
    })
    output$first_guess_text <- renderText({
      if (n_reac() == 70 && c_reac() == 365) {
        paste0(
          "your first guess: ",
          sprintf("%s", input$first_guess_input), "%"
        )
      }
    })
    output$first_answer_text <- renderText({
      paste0(
        "probability = ",
        sprintf("%.4f", (1 - ((input$c - 1) / input$c)^(input$n)) * 100), "%"
      )
    })
    output$second_guess_text <- renderText({
      if (n_reac() == 70 && c_reac() == 365) {
        paste0(
          "your second guess: ",
          sprintf("%s", input$second_guess_input), "%"
        )
      }
    })
    output$second_answer_text <- renderText({
      paste0(
        "probability = ",
        sprintf("%.4f", (1 - prod(1 - (1:((input$n - 30) - 1)) / input$c)) * 100), "%"
      )
    })

    output$text_instruction_sliders <- renderText({
      if (n_reac() == 70 && c_reac() == 365) {
        paste0("Try different values for 'n' and 'c', move the sliders on the left hand side")
      }
    })
    output$text_instruction_goback <- renderText({
      if (n_reac() != 70 || c_reac() != 365) {
        paste0("To see the distributions of the problems or and your guesses, choose n = 70 and c = 365")
      }
    })


    # Explanation / Text / History etc
    output$text_description <- renderText({
      "history mistory etc"
    })
  })
}
