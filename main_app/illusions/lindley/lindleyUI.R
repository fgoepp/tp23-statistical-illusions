lindleyUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  # sidebar Input
  sideBarInput <- tagList(
    p("Assuming the actual data is binomial distributed. Please select the relevant paramenters"),
    # select actual data
    sliderInput(ns("n"), "n:", min = 1, max = 1000, value = 500),
    sliderInput(ns("p"), "p:", min = 0, max = 100, value = 50),

    # select significance level
    sliderInput(ns("significance_level"), "significance level in %:", min = 0, max = 100, value = 5),

    # select H_0 distribution
    p("The distribution of H0 is assumed to be binomial. Please select the probability"),
    sliderInput(ns("H0_p"), "H0 ratio:", min = 0, max = 100, value = 50),

    # select H_1 distribution
    p("this is relevant for Bayes, because here H0 and H1 are compared"),
    selectInput("H1_dist", "H1 distribution:",
      choices = c("Uniform", "Option 2", "Option 3"),
      selected = "Uniform"
    )
  )

  # mainPanel Output
  mainPanelOutput <- tagList(
    textOutput(ns("accept_or_reject")),
    h4("The plotted data and the Distributions:"),
    plotOutput(ns("plot")),
    HTML("<h4>History</h4>"),
    textOutput(ns("text_description"))
  )

  # load layout
  layout(sideBarInput, mainPanelOutput)
}
