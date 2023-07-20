lindleyUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  # sidebar Input
  sideBarInput <- tagList(
    p("Assuming the actual data is binomial distributed. Create your underlying data by selecting the relevant parameters"),
    # select actual data
    sliderInput(ns("n"), "n (= |samples|):", min = 1, max = 1000, value = 1000),
    sliderInput(ns("p"), "p (= likelihood of hit):", min = 1, max = 99, value = 50),

    # select significance level
    sliderInput(ns("significance_level"), "significance level in %:", min = 0, max = 100, value = 5),

    # select H_0 distribution
    p("The distribution of H₀ is assumed to be binomial. Please select the estimation for the probability"),
    sliderInput(ns("H0_p"), "H₀ ratio:", min = 1, max = 99, value = 47),

    # select H_1 distribution
    p("this is relevant for Bayes, because here H₀ and H₁ are compared"),
    selectInput(ns("H1_dist"), "H₁ distribution:",
      choices = c("H₀ Gauß & H₁ Uniform", "Uninformative prior (both Uniform)"),
      selected = "H₀ Gauß & H₁ Uniform"
    )
  )

  # mainPanel Output
  mainPanelOutput <- tagList(
    h4("The plotted data and the Distributions:"),
    plotOutput(ns("plot")),
    uiOutput(ns("frequentist_decision")),
    uiOutput(ns("bayesian_decision")),
    HTML("<h4>History</h4>"),
    textOutput(ns("text_description"))
  )

  # load layout
  layout(sideBarInput, mainPanelOutput)
}
