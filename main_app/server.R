server <- function(input, output) {
  # Calculate probability using formula
  output$probability <- renderText({
    N <- input$n
    c <- input$c
    i <- 1:(N-1)
    p <- 1 - prod(1 - i / c)
    paste0(sprintf("%.4f", p * 100), "%")
  })
  output$chicken <- renderPlot({
    boxplot(weight ~ Diet, data = ChickWeight, xlab = "Diet", ylab = "Weight")
  })
  output$text_description <- renderText({
    "Testen Sie ihre Implementierung, indem Sie vor der eigentlichen Berechnung As-
      Sie, wenn Sie diese Darstellung gemäß IEEE 754 in eine Dezimalzahl übersetzen, ab der wie vielten Dezimalstelle sich die berechnete"
    # You can customize the text above or generate it dynamically based on input values
  })
  outputOptions(output, "chicken", suspendWhenHidden = FALSE)
  output$download_plot <- downloadHandler(
    filename = function() {
      "plot.jpg"
    },
    content = function(file) {
      jpeg(file)
      print(boxplot(weight ~ Diet, data = ChickWeight, xlab = "Diet", ylab = "Weight"))
      dev.off()
    }
  )
}