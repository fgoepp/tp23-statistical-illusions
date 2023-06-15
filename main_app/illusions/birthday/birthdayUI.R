birthdayUI <- function(id) {
  ns <- NS(id)

  fluidPage(
    # for coloring probabilty_text and guess_text
    tags$head(
      tags$style(HTML(".real-probability {color: red;}.your-guess {color: blue;}"))
    ),

    # Page 1: Introduction
    conditionalPanel(
      condition = "!input.page2_button",
      div(
        id = "page1",
        style = "position: absolute; top: 25%; left: 50%; transform: translate(-50%, -50%); text-align: left;",
        h3("What do you think is the probability that two random selected people of 70 in a room have the same day of birth in a year?"),
        div(
          numericInput(ns("guess_input"), "take your guess in percent", value = 0, min = 0, max = 100),
          HTML("%"),
          actionButton("page2_button", "Take Guess", )
        )
      )
    ),

    # Page 2
    conditionalPanel(
      condition = "input.page2_button",
      div(
        id = "page2",
        sidebarLayout(
          sidebarPanel(
            sliderInput(ns("n"), "Number of people:", min = 1, max = 200, value = 70),
            sliderInput(ns("c"), "Number of categories:", min = 1, max = 365, value = 365),
            selectInput(
              ns("category_selector"),
              label = "Example category: ",
              choices = c("birthday in a year", "favourite planet of our solarsystem", "favorite element of the periodic table"),
              selected = "birthday in a year"
            ),
            br(),
            downloadButton(ns("download_plot"), "Download Plot"),
          ),
          mainPanel(
            tagList(
              plotOutput(ns("probability_plot")),
              tags$span(textOutput(ns("probability_text")), class = "real-probability"),
              tags$span(textOutput(ns("guess_text")), class = "your-guess"),
              br(),
              HTML("<h4>History</h4>"),
              textOutput(ns("text_description"))
            )
          )
        )
      )
    )
  )
}
