sbServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$userGuessText <- renderText({
      if (input$userGuess > 0) {
        paste("Your guess:", input$userGuess)
      }
    })

    output$coinTossResult <- renderText({
      coinToss <- sample(c("Heads", "Tails"), 1)
      paste("Coin toss result:", coinToss)
    })

    output$guessComparison <- renderText({
      coinToss <- sample(c("Heads", "Tails"), 1)
      if (input$lockButton > 0) {
        if (input$userGuess == coinToss) {
          "You guessed right!"
        } else {
          "You guessed wrong!"
        }
      }
    })
  })
}
