sbServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    userGuess <- reactiveVal(NULL)

    observeEvent(input$lockButton, {
      userGuess(input$userGuess)
    })

    output$userGuessText <- renderText({
      if (!is.null(userGuess())) {
        paste("Your guess:", userGuess())
      }
    })

    output$coinTossResult <- renderText({
      # Perform a fair coin toss and determine the result
      coinToss <- sample(c("Heads", "Tails"), 1)
      paste("Coin toss result:", coinToss)
    })

    output$guessComparison <- renderText({
      if (!is.null(userGuess())) {
        coinToss <- sample(c("Heads", "Tails"), 1)
        if (userGuess() == coinToss) {
          "You guessed right!"
        } else {
          "You guessed wrong!"
        }
      }
    })
  })
}
