sbUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  fluidPage(

    # Page 1: Email describing the experiment
    ###########################################################################
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
    ###########################################################################
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
    ###########################################################################
    conditionalPanel(
      condition = "input.page2_button && !input.page3_button",
      div(
        class = "page-container",
        style = "background-color: #FFFAFA; padding: 30px; border-radius: 10px; box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);",
        h2("Welcome, Sleeping Beauty", style = "text-align: center; font-family: Helvetica; color: black; font-size: 28px; margin-bottom: 20px;"),
        p("Great that you made it! Let's walk through the details of the study.",
          style = "color: black; font-size: 20px; text-align: center; margin-bottom: 30px;"
        ),
        p(
          "Here's how it works:",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "During the experiment, you will go through multiple cycles of sleeping and waking up.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "Each time you wake up, you will be asked to make a guess about the outcome of a coin flip.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "After providing your guess, you will receive medication that induces temporary amnesia.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "This medication will make you forget that you woke up and the answer you provided.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p(
          "Your goal is to maximize your accuracy in predicting the coin flip outcome.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        h3("Timetable:"),
        fluidRow(
          column(4,
            align = "center", style = "font-size: 20px; font-family: Helvetica;",
            h4("Outcome of the Coin Flip"),
            div(
              style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
              p("Head", style = "margin: 0;"), p("Tail", style = "margin: 0;")
            )
          ),
          column(4,
            align = "center", style = "font-size: 20px; font-family: Helvetica;",
            h4("Monday"),
            div(
              style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
              p("Awake", style = "margin: 0;"), p("Awake", style = "margin: 0;")
            )
          ),
          column(4,
            align = "center", style = "font-size: 20px; font-family: Helvetica;",
            h4("Tuesday"),
            div(
              style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
              p("Asleep", style = "margin: 0;"), p("Awake", style = "margin: 0;")
            )
          )
        ),
        p(
          "Click the button below when you're ready to go to sleep.",
          style = "font-size: 16px; font-family: Helvetica; margin-top: 30px; text-align: center;"
        ),
        actionButton("page3_button", "Put me to sleep",
          class = "btn-primary btn-lg",
          style = "font-family: Helvetica; background-color: #C0C0C0; border-color: #808080; display: block; margin: 0 auto;"
        ) # Button to proceed to Page 3
      )
    ),
    # Page 3: Coin flip
    ###########################################################################
    conditionalPanel(
      condition = "input.page3_button && !input.page4_button",
      div(
        style = "text-align: center; background-color: #000000; height: 100vh; display: flex; flex-direction: column; justify-content: center; align-items: center; position: relative;",
        h2(
          "While you're asleep, a fair coin is tossed.",
          style = "color: #FFFFFF; font-family: 'Helvetica', sans-serif; font-size: 24px; margin-bottom: 20px;"
        ),
        tags$div(
          style = "position: relative;",
          tags$iframe(
            src = "https://giphy.com/embed/10bv4HhibS9nZC",
            width = "780",
            height = "563",
            frameBorder = "0",
            class = "giphy-embed",
            allowFullScreen = TRUE
          ),
          div(
            style = "position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);",
            tags$audio(
              id = "coinSound",
              src = "alarmclock.wav",
              preload = "auto"
            ),
            actionButton(
              "page4_button",
              "WAKE UP",
              class = "btn-primary btn-lg",
              style = "font-family: 'Helvetica', sans-serif; background-color: #FFFFFF; border-color: #FFFFFF; padding: 10px 20px; font-size: 16px; text-transform: uppercase; letter-spacing: 2px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);",
              onclick = "document.getElementById('coinSound').play();"
            ) # Button to proceed to Page 4
          )
        ),
        tags$p(
          tags$a(
            href = "https://giphy.com/gifs/hannibal-mads-mikkelsen-coin-toss-10bv4HhibS9nZC",
            "via GIPHY",
            style = "color: #FFFFFF; font-family: 'Helvetica', sans-serif; font-size: 16px; text-decoration: none;"
          )
        )
      )
    ),
    # Page 4: You've been woken up, make a guess
    ###########################################################################
    conditionalPanel(
      condition = "input.page4_button && !input.page5_button",
      sidebarLayout(
        sidebarPanel(
          textInput("userGuess", "Enter your guess (Heads or Tails)"),
          actionButton("lockButton", "Lock in"),
          br(),
        ),
        mainPanel(
          h3("Results"),
          conditionalPanel(
            condition = "input.lockButton > 0",
            verbatimTextOutput(ns("coinTossResult")),
            verbatimTextOutput(ns("guessComparison")),
            verbatimTextOutput(ns("userGuessText"))
          )
        )
      ),
      div(
        style = "display: flex; justify-content: center; align-items: center; height: 100%;",
        actionButton(
          "page5_button",
          "temporal amnesia",
          class = "btn-primary btn-lg",
          style = "font-family: 'Helvetica', sans-serif; background-color: #FFFFFF;
          border-color: #FFFFFF; padding: 10px 20px; font-size: 16px; text-transform:
          uppercase; letter-spacing: 2px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);",
          onclick = "document.getElementById('alarmSound').play();"
        ) # Button to proceed to Page 5
      ),
      tags$audio(
        id = "alarmSound",
        src = "downloads/mixkit-vintage-warning-alarm-990.wav", # Replace with the path to your alarm clock sound file
        preload = "auto"
      )
    ),


    # Page 5: Thanks for participation
    ###########################################################################
    conditionalPanel(
      condition = "input.page5_button && !input.page6_button",
      h2("Thank you for participating in the experiment.
         It is now Wednesday, and the experiment has ended. However,
         we encourage you to answer the following question
         if you would like to learn more about the experiment:"),
      actionButton("page6_button", "learn more",
        class = "btn-primary btn-lg",
        style = "font-family: 'Helvetica', sans-serif; background-color: #FFFFFF;
          border-color: #FFFFFF; padding: 10px 20px; font-size: 16px; text-transform:
          uppercase; letter-spacing: 2px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);",
        onclick = "document.getElementById('alarmSound').play();"
      ) # button to page 6
    ),


    # Page 6: choose the probability
    ###########################################################################
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
          column(
            width = 11,
            # Page 7: You chose 1/2
            ###########################################################################
            conditionalPanel(
              condition = "input.answer == 'The probability that the coin came up heads is 1/3'",
              h2("Are you sure about that?"),
              p(tags$span(
                style = "font-size: larger;",
                "From my perspective, as an advocate of David Lewis's viewpoint on the Sleeping Beauty problem, "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I believe that the widely accepted 1/3 approach is flawed."
              )),
              p(tags$span(
                style = "font-size: larger;",
                "Let me explain why. In this intriguing thought experiment, "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I find myself in the role of Sleeping Beauty. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I am put to sleep, and a fair coin is flipped. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "My memory of the event is wiped clean, and I am unaware of the outcome. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I am then awakened either once (Heads) or twice (Tails) without any knowledge of the specific outcome of the coin flip. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "Now, when considering the probability of the coin landing on heads, "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "many argue that there are three equally likely scenarios: Heads-Heads, Heads-Tails, and Tails-Heads. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "Consequently, they suggest that I should assign a 1/3 probability to the coin landing on heads and answer \"Heads\" with that same probability. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "However, I respectfully disagree with this line of reasoning. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "From my personal standpoint, I must take into account the inherent uncertainty that arises due to my limited self-location knowledge. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I am aware that I have been awakened at least once, but I lack direct observational evidence about the exact number of awakenings. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "If the coin indeed landed on heads, "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I would only experience a single awakening. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "On the other hand, if it landed on tails, "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "I would experience two awakenings. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "This means that there are two possible scenarios where I find myself awakened twice: Heads-Tails and Tails-Heads. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "In contrast, there is only one scenario where I experience a single awakening: Heads-Heads. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "Considering this, I find it appropriate to assign a higher probability to the coin landing on heads. "
              )),
              p(tags$span(
                style = "font-size: larger;",
                "To be precise, I believe that there is a 2/3 chance that the coin landed on heads."
              )),
              radioButtons(
                "page2_option",
                "Make your final Choice:",
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
              # Page 9
              ###########################################################################
              conditionalPanel(
                condition = "input.lock_in_page6 > 0",
                h2("Page 9"),
                p("You have locked in your answer from Page 6. This is page 8."),
                actionButton("go_to_page1", "Go back to Page 1",
                  class = "btn-secondary btn-lg btn-block"
                ) # Button to go back to Page 1
              )
            ),
            # Page 8: Adam Elga tells you why you're wrong
            ###########################################################################
            conditionalPanel(
              condition = "input.answer == 'The probability thtat the coin came up heads is 1/2'",
              h2("Are you sure about that?"),
              p(tags$span(style = "font-size: larger;", "If you believe that the probability in the Sleeping Beauty problem that heads came up is 1/2,")),
              p(tags$span(style = "font-size: larger;", "I understand your perspective. However, based on my understanding of the problem")),
              p(tags$span(style = "font-size: larger;", "and the position I advocate, known as the thirder position, I would argue differently.")),
              p(tags$span(style = "font-size: larger;", "In the thirder position,")),
              p(tags$span(style = "font-size: larger;", "I assign a probability of 1/3 to the event that heads came up.")),
              p(tags$span(style = "font-size: larger;", "This view takes into account the two different experiences that Sleeping Beauty")),
              p(tags$span(style = "font-size: larger;", "undergoes during the experiment: one when she wakes up on Monday and another")),
              p(tags$span(style = "font-size: larger;", "when she wakes up on Tuesday. Each experience should be given equal weight when determining probabilities.")),
              p(tags$span(style = "font-size: larger;", "While it may seem intuitive to assign a 1/2 probability,")),
              p(tags$span(style = "font-size: larger;", "considering that heads and tails are equally likely outcomes in a fair coin toss,")),
              p(tags$span(style = "font-size: larger;", "the introduction of multiple observations and experiences changes the dynamics")),
              p(tags$span(style = "font-size: larger;", "of the problem. The thirder position seeks to incorporate these")),
              p(tags$span(style = "font-size: larger;", "additional factors into the probability assessment.")),
              p(tags$span(style = "font-size: larger;", "If you think you're still right, lock in your choice,")),
              p(tags$span(style = "font-size: larger;", "but you can still change your opinion.")),
              p(tags$span(style = "font-size: larger;", "Adam Elga.")),
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
              ), # Button to lock in the answer from Page 8
              conditionalPanel(
                condition = "input.lock_in_page6 > 0",
                h2("Page 9"),
                p("You have locked in your answer from Page 8. This is page 9."),
                actionButton("go_to_page1", "Go back to Page 1",
                  class = "btn-secondary btn-lg btn-block"
                ) # Button to go back to Page 1
              )
            )
          )
        )
      )
    ),

    # Page 9: the final conclusion
    ###########################################################################
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
