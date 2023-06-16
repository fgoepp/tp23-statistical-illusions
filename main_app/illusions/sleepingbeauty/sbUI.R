sbUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  fluidPage(

    # Page 1: Email describing the experiment
    tags$head(
      tags$link(
        rel = "stylesheet",
        href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
      ),
      tags$style(
        HTML("
      .email-container {
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background-color: black;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .email-content {
        position: relative;
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        max-width: 740px;
        width: 100%;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      }
      .email-header {
        text-align: center;
        margin-bottom: 10px;
      }

    ")
      ),
      tags$script(HTML("
    Shiny.addCustomMessageHandler('changePage', function(page) {
      $('.nav-link[data-value=' + page + ']').click();
    });
  "))
    ),


    # Page 1: Introduction
    conditionalPanel(
      condition = "!input.page2_button",
      div(
        class = "email-container",
        div(
          class = "email-content",
          div(
            class = "email-header",
            h1(
              style = "font-family: 'Times New Roman'; color: black;",
              tags$i(class = "fas fa-envelope"),
              "New Mail in your Inbox"
            )
          ),
          tags$img(
            style = "height:600px; width:700px; background-color: beige;",
            src = "participation_email.png"
          ),
          div(
            style = "display: flex; justify-content: center; margin-top: 10px;",
            actionButton("page2_button", "Participate",
              class = "email-button btn-primary btn-lg",
              style = "font-family: Helvetica; background-color: white; border-color: #4e79a7; color: black;"
            )
          )
        )
      )
    ),

    # Page 2: Study procedure
    conditionalPanel(
      condition = "input.page2_button && !input.page3_button",
      div(
        class = "page-container",
        style = "background-color: #f8f8f8; padding: 30px; border-radius: 10px; box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);",
        h2("Welcome, Sleeping Beauty", style = "text-align: center; font-family: Helvetica; color: #4e79a7; font-size: 28px; margin-bottom: 20px;"),
        p("Great that you made it! We are now going to talk through the details of the study.",
          style = "color: #4e79a7; font-size: 20px; text-align: center; margin-bottom: 30px;"
        ),
        p(
          "Here's how it works:",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "Each time you are awakened, you will be asked to make a guess about the outcome of the coin flip.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "After each guess you make, you will receive a medication that induces temporary amnesia,",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "Causing you to forget that you woke up and the answer you provided to the question.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "Your goal is to maximize your accuracy in predicting the coin flip.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "On Day 1, if a fair coin lands on heads, you will be awakened once.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "On Day 2, if the coin lands on tails, you will be awakened twice.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "Sounds intriguing, doesn't it?",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 30px;"
        ),
        p(
          "Click the button below if you're tired",
          style = "font-size: 16px; font-family: Helvetica; margin-top: 30px;"
        ),
        actionButton("page3_button", "Put me to sleep",
          class = "btn-primary btn-lg",
          style = "font-family: Helvetica;background-color: white;
                     border-color: #4e79a7;"
        ) # Button to proceed to Page 3
      )
    ),

    # Page 3: Coin flip

    conditionalPanel(
      condition = "input.page3_button && !input.page4_button",
      div(
        style = "text-align: center; background-color: black;", # Added background-color style
        h2(
          "While you're asleep, a fair coin is tossed.",
          style = "color: white;" # Added color style
        ),
        tags$div(
          tags$iframe( # added a gif showing the coin flip
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
      div(
        style = "display: flex; justify-content: center; align-items:
        center; height: 100%;",
        actionButton("page4_button", "WAKE UP",
          class = "btn-primary btn-lg",
          style = "font-family: Helvetica;background-color: white;
                     border-color: white;",
        ) # Button to proceed to Page 4
      )
    ),

    # Page 4: You've been woken up, make a guess

    conditionalPanel(
      condition = "input.page4_button && !input.page5_button",
      sidebarLayout(
        sidebarPanel(
          textInput("userGuess", "Enter your guess (Heads or Tails)"),
          actionButton("lockButton", "Lock in"),
          br(),
          verbatimTextOutput("userGuessText")
        ),
        mainPanel(
          h3("Results"),
          conditionalPanel(
            condition = "input.lockButton > 0",
            verbatimTextOutput("coinTossResult"),
            verbatimTextOutput("guessComparison")
          )
        )
      ),
      actionButton("page5_button", "temporal amnesia",
        class = "btn-primary btn-lg",
        style = "font-family: Helvetica;background-color: white;
                     border-color: white;",
      )
    ),

    # Page 5: Thanks for participate
    conditionalPanel(
      condition = "input.page5_button && !input.page6_button",
      h2("Thank you for participating in the experiment.
         It is now Wednesday, and the experiment has ended. However,
         we encourage you to answer the following question
         if you would like to learn more about the experiment:"),
      actionButton("page6_button", "learn more",
        class = "btn-primary btn-lg"
      ) # button to page 6
    ),


    # Page 6
    conditionalPanel(
      condition = "input.page6_button && !input.page7_button",
      sidebarLayout(
        sidebarPanel(
          radioButtons(
            "answer",
            "Choose an answer:",
            choices = c(
              "The probability that the coin came up heads is 1/3",
              "The probability thtat the coin came up heads is 1/2"
            ),
            selected = character(0)
          )
        ),
        mainPanel(
          fluidRow(
            column(
              width = 6,
              offset = 3,
              conditionalPanel(
                condition = "input.answer == 'The probability that the coin came up heads is 1/3'",
                h2("Page 6"),
                radioButtons(
                  "page2_option",
                  "Choose an option:",
                  choices = c(
                    "The probability that the coin came up heads is 1/3",
                    "The probability thtat the coin came up heads is 1/2"
                  ),
                  selected = character(0)
                ),
                br(),
                actionButton("lock_in_page6", "Lock In",
                  class = "btn-primary btn-lg btn-block"
                ), # Button to lock in the answer from Page 6
                conditionalPanel(
                  condition = "input.lock_in_page6 > 0",
                  h2("Page 8"),
                  p("You have locked in your answer from Page 6. This is page 8."),
                  actionButton("go_to_page1", "Go back to Page 1",
                    class = "btn-secondary btn-lg btn-block"
                  ) # Button to go back to Page 1
                )
              ),
              conditionalPanel(
                condition = "input.answer == 'The probability thtat the coin came up heads is 1/2'",
                h2("Page 8"),
                radioButtons(
                  "page3_option",
                  "Choose an option:",
                  choices = c(
                    "The probability that the coin came up heads is 1/3",
                    "The probability thtat the coin came up heads is 1/2"
                  ),
                  selected = character(0)
                ),
                br(),
                actionButton("lock_in_page6", "Lock In",
                  class = "btn-primary btn-lg btn-block"
                ), # Button to lock in the answer from Page 5
                conditionalPanel(
                  condition = "input.lock_in_page6 > 0",
                  h2("Page 8"),
                  p("You have locked in your answer from Page 7. This is page 8."),
                  actionButton("go_to_page1", "Go back to Page 1",
                    class = "btn-secondary btn-lg btn-block"
                  ) # Button to go back to Page 1
                )
              )
            )
          )
        )
      )
    ),

    # Page 6
    conditionalPanel(
      condition = "input.currentPage == 'page8'",
      div(
        style = "position: absolute; top: 50%; left: 50%;
        transform: translate(-50%, -50%); text-align: center;",
        h2("Page 8"),
        p("This is page 8."),
        actionButton("go_to_page1", "Go back to Page 1",
          class = "btn-secondary btn-lg btn-block"
        ) # Button to go back to Page 1
      )
    )
  )
}
