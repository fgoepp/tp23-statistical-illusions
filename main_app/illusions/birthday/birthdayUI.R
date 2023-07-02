birthdayUI <- function(id) {
  ns <- NS(id)

  fluidPage(
    # for coloring probabilty_text and guess_text
    tags$head(
      tags$style(HTML(".instruction {color: red;}.first-answer {color: darkgreen;}.second-answer {color: darkblue;}.your-first-guess {color: darkgreen;}.your-second-guess {color: darkblue;}"))
    ),

    # Page 1: Introduction
    conditionalPanel(
      condition = "!input.bday_page2_button",
      div(
        id = "page1",
        style = "position: absolute; top: 50%; left: 53%;
                 transform: translate(-50%, -50%); text-align: left;",
        h3("Imagine you are at a Party"),
        tags$img(
          style = "height:288px; width:512px; scrolling=yes",
          src = "party.jpg"
        ),
        h3("What do you think is the probability that one of the 70
           people present shares the same day of birth as you in a year?"),
        div(
          numericInput(ns("first_guess_input"),
            "take your guess in percent",
            value = 0, min = 0, max = 100
          ),
          HTML("%"),
        ),
        h3("Time flies by 30 people have left, 40 still remain "),
        br(),
        h3("What do you think is the probability that two or more
           people of 40 share the same day of birth in a year?"),
        div(
          numericInput(ns("second_guess_input"),
            "take your guess in percent",
            value = 0, min = 0, max = 100
          ),
          HTML("%"),
          actionButton("bday_page2_button", "Take Guess", )
        )
      )
    ),

    # Page 2
    conditionalPanel(
      condition = "input.bday_page2_button",
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
            br()
          ),
          mainPanel(
            tagList(
              plotOutput(ns("probability_plot")),
              tags$h4("The dark-grey (lower) distribution", style = "font-weight: bold;"),
              textOutput(ns("first_question_text")),
              textOutput(ns("first_distribution")),
              textOutput(ns("n_and_c_first")),
              tags$span(textOutput(ns("first_answer_text")), class = "first-answer"),
              tags$span(textOutput(ns("first_guess_text")), class = "your-first-guess"),
              tags$h4("The light-grey (upper) distribution", style = "font-weight: bold;"),
              textOutput(ns("second_question_text")),
              textOutput(ns("second_distribution")),
              textOutput(ns("n_and_c_second")),
              tags$span(textOutput(ns("second_answer_text")), class = "second-answer"),
              tags$span(textOutput(ns("second_guess_text")), class = "your-second-guess"),
              tags$span(textOutput(ns("text_instruction_sliders")), class = "instruction"),
              tags$span(textOutput(ns("text_instruction_goback")), class = "instruction"),
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
