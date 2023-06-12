birthdayUI <- function(id) {
  ns <- NS(id)
  source("layout.R")
  # sidebar Input
  sideBarInput <- tagList(
    sliderInput(ns("n"), "Number of people:", min = 1, max = 200, value = 70),
    sliderInput(ns("c"), "Number of categories:", min = 1, max = 365, value = 365),
    selectInput(
      ns("category_selector"),
      label = "Example category: ",
      choices = c("birthday in a year", "favourite planet of our solarsystem", "favorite element of the periodic table"),
      selected = "birthday in a year"
    ),
    downloadButton(ns("download_plot"), "Download Plot")
  )

  # mainPanel Output
  mainPanelOutput <- tagList(
    h4("Plot:"),
    plotOutput(ns("probability_plot")),
    textOutput(ns("probability_text")),
    br(),
    HTML("<h4>History</h4>"),
    textOutput(ns("text_description"))
  )

  # load layout
  layout(sideBarInput, mainPanelOutput)
}
