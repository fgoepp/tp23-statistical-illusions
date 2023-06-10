sbUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  fluidPage(
    tags$head(
      tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css")
    ),

    # Page 1: Introduction
    conditionalPanel(
      condition = "!input.page2_button",
      div(
        style = "position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;",
        h1(
          style = "font-family: 'Arial', sans-serif;",
          tags$i(class = "fas fa-envelope"), # Font Awesome envelope icon
          "New Mail in your Inbox"
        ),
        tags$img(
          style = "height:600px; width:100%; scrolling=yes",
          src = "participation_email.png"
        ),
        actionButton("page2_button", "Participate")
      )
    ),

    # Page 2
    conditionalPanel(
      condition = "input.page2_button && !input.page3_button",
      div(
        style = "text-align: center;",
        h2("Page 2"),
        actionButton("page3_button", "Next")
      )
    ),

    # Page 3
    conditionalPanel(
      condition = "input.page3_button && !input.page4_button",
      div(
        style = "text-align: center;",
        h2("While you're asleep, a fair coin is flipped."),
        tags$div(
          tags$iframe(
            src = "https://giphy.com/embed/10bv4HhibS9nZC",
            width = "960",
            height = "526",
            frameBorder = "0",
            class = "giphy-embed",
            allowFullScreen = TRUE
          )
        ),
        tags$p(tags$a(href = "https://giphy.com/gifs/hannibal-mads-mikkelsen-coin-toss-10bv4HhibS9nZC", "via GIPHY"))
      ),
      actionButton("page4_button", "WAKE UP")
    ),




    # Page 4
    conditionalPanel(
      condition = "input.page4_button && !input.page5_button",
      sidebarLayout(
        sidebarPanel(
          radioButtons(
            "answer",
            "Choose an answer:",
            choices = c("Answer 1", "Answer 2"),
            selected = character(0)
          )
        ),
        mainPanel(
          fluidRow(
            column(
              width = 6,
              offset = 3,
              conditionalPanel(
                condition = "input.answer == 'Answer 1'",
                h2("Page 4"),
                radioButtons(
                  "page2_option",
                  "Choose an option:",
                  choices = c("Option 1", "Option 2"),
                  selected = character(0)
                ),
                br(),
                actionButton("lock_in_page4", "Lock In", class = "btn-primary btn-lg"),
                conditionalPanel(
                  condition = "input.lock_in_page4 > 0",
                  h2("Page 6"),
                  p("You have locked in your answer from Page 4. This is page 6.")
                )
              ),
              conditionalPanel(
                condition = "input.answer == 'Answer 2'",
                h2("Page 5"),
                radioButtons(
                  "page3_option",
                  "Choose an option:",
                  choices = c("Option A", "Option B"),
                  selected = character(0)
                ),
                br(),
                actionButton("lock_in_page5", "Lock In", class = "btn-primary btn-lg"),
                conditionalPanel(
                  condition = "input.lock_in_page5 > 0",
                  h2("Page 6"),
                  p("You have locked in your answer from Page 5. This is page 6.")
                )
              )
            )
          )
        )
      )
    )
  )
}
