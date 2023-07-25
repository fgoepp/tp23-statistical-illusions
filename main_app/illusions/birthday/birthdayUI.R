birthdayUI <- function(id) {
  ns <- NS(id)

  fluidPage(
    # for coloring probability_text and guess_text
    tags$head(
      tags$style(HTML(".sec-prob {color: darkblue}.instruction {color: red;}.first-answer {color: darkgreen;}.second-answer {color: darkblue;}.your-first-guess {color: darkgreen;}.your-second-guess {color: darkblue;}"))
    ),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML"),


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
              choices = c("birthday in a year", "star sign", "favourite planet of our solarsystem", "favorite element of the periodic table"),
              selected = "birthday in a year"
            ),
            br()
          ),
          mainPanel(
            tagList(
              plotOutput(ns("probability_plot")),
              tags$h4("The dark-grey (lower) distribution", style = "font-weight: bold;"),
              textOutput(ns("text_first_question")),
              textOutput(ns("text_first_distribution")),
              textOutput(ns("text_n_and_c_first")),
              tags$span(textOutput(ns("text_first_answer")), class = "first-answer"),
              tags$span(textOutput(ns("text_first_guess")), class = "your-first-guess"),
              tags$h4("The light-grey (upper) distribution", style = "font-weight: bold;"),
              textOutput(ns("text_second_question")),
              textOutput(ns("text_second_distribution")),
              textOutput(ns("text_n_and_c_second")),
              tags$span(textOutput(ns("text_second_answer")), class = "second-answer"),
              tags$span(textOutput(ns("text_second_guess")), class = "your-second-guess"),
              tags$span(textOutput(ns("text_second_prob")), class = "sec-prob"),
              tags$span(textOutput(ns("text_instruction_sliders")), class = "instruction"),
              tags$span(textOutput(ns("text_instruction_goback")), class = "instruction"),
              br(),
              HTML("<h4>History</h4>"),
              a(href = "https://github.com/fgoepp/tp23-statistical-illusions", "Our Github"),
              a(
                href = "https://github.com/fgoepp/tp23-statistical-illusions",
                style = "color: blue; text-decoration: underline;",
                "https://github.com/fgoepp/tp23-statistical-illusions"
              ),
              div(
                HTML("This is the summation symbol: $$\\sum_{i=1}^{n} i$$"),
                HTML("This is the product symbol: $$\\prod_{i=1}^{n} x_i$$"),
                HTML("Here is something under the square root: $$\\sqrt{4x^{7}}$$"),
                HTML("Here is an integral with a sine function: $$\\int_{a}^{b} \\sin(x) \\, dx$$")
              )
            )
          )
        )
      )
    )
  )
}
