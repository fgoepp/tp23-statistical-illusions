lindleyUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  # sidebar Input
  sideBarInput <- tagList(
    sliderInput(ns("n"), "Number of people:", min = 1, max = 200, value = 10),
    sliderInput(ns("c"), "Number of categories:", min = 1, max = 365, value = 365),
    downloadButton(ns("download_plot"), "Download Plot")
  )

  # mainPanel Output
  mainPanelOutput <- tagList(
    h4("Plot:"),
    plotOutput(ns("chicken")),
    br(),
    HTML("<h4>History</h4>"),
    textOutput(ns("text_description"))
  )

  # load layout
  layout(sideBarInput, mainPanelOutput)
}
