sbUI <- function(id) {
  ns <- NS(id)
  source("layout.R")

  fluidPage(

    # Page 1: Email describing the experiment
    ###########################################################################
    conditionalPanel(
      condition = "!input.sb_page2_button",
      div(
        class = "email-container",
        style = "position: absolute;
          top: 0;
          bottom: 0;
          left: 0;
          right: 0;
          background-color: black;
          display: flex;
          align-items: center;
          justify-content: center;",
        div(
          class = "email-content",
          style = "position: relative;
          background-color: white;
          padding: 20px;
          border-radius: 10px;
          max-width: 740px;
          width: 100%;
          box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);",
          div(
            class = "email-header",
            style = "text-align: center; margin-bottom: 10px;",
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
            actionButton(
              "sb_page2_button", "Participate",
              class = "email-button btn-primary btn-lg",
              style = "font-family: Helvetica; background-color: white; border-color: white; color: black;"
            )
          )
        )
      )
    ),

    # Page 2: Study procedure
    ###########################################################################
    conditionalPanel(
      condition = "input.sb_page2_button && !input.sb_page3_button",
      div(
        class = "page-container",
        style = "background-color: #FFFAFA; padding: 30px; border-radius: 10px; box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);",
        h2("Welcome, Sleeping Beauty",
          style = "text-align: center; font-family: Helvetica; color: black; font-size: 28px; margin-bottom: 20px;"
        ),
        p("Great that you made it! Let's walk through the details of the study.",
          style = "color: black; font-size: 20px; text-align: center; margin-bottom: 30px;"
        ),
        p("Here's how it works:",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p("During the experiment, you will go through multiple cycles of sleeping and waking up.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p("Each time you wake up, you will be asked to make a guess about the outcome of a coin flip.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p("After providing your guess, you will receive medication that induces temporary amnesia.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p("This medication will make you forget that you woke up and the answer you provided.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 15px;"
        ),
        p("Your goal is to maximize your accuracy in predicting the coin flip outcome.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 30px;"
        ),
        p("Underneath you can see the timetable of the awakenings in both scenarios.",
          style = "font-size: 20px; font-family: Helvetica; margin-bottom: 30px;"
        ),
        h3("Timetable:",
          style = "font-family: Helvetica; font-size: 24px; margin-bottom: 10px;"
        ),
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
        p("Click the button below when you're ready to go to sleep.",
          style = "font-size: 16px; font-family: Helvetica; margin-top: 30px; text-align: center;"
        ),
        div(
          style = "text-align: center;", # Centering the button
          actionButton("sb_page3_button", "Put me to sleep",
            class = "btn-primary btn-lg",
            style = "font-family: Helvetica; background-color: white; color: black; border: none; border-radius: 5px; padding: 10px 20px; cursor: pointer;"
          ) # Button to proceed to Page 3
        )
      )
    ),
    # Page 3: Coin flip
    ###########################################################################
    conditionalPanel(
      condition = "input.sb_page3_button && !input.sb_page4_button",
      div(
        style = "position: relative; text-align: center; background-color: #000000; height: 95vh; display: flex; flex-direction: column; justify-content: center; align-items: center;",
        tags$video(
          controls = "controls",
          style = "max-width: 100%;",
          tags$source(src = "cointoss.mp4", type = "video/mp4")
        ),
        tags$p(
          style = "position: absolute; top: 40%; left: 50%; transform: translate(-50%, -50%); color: #FFFFFF;
          font-size: 18px;",
          "While you're asleep, a fair coin is tossed."
        ),
        tags$p(
          style = "position: absolute; bottom: 100px; left: 50%; transform: translateX(-50%);",
          actionButton(
            "sb_page4_button",
            "WAKE UP",
            class = "btn-primary btn-lg",
            style = "font-family: 'Helvetica', sans-serif; background-color: #000000; border-color: #000000; padding: 15px 30px; font-size: 18px; text-transform: uppercase; letter-spacing: 2px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); color: #FFFFFF;"
            # Button to proceed to Page 4
          )
        )
      )
    ),
    ###### Page 4: You're awake and have to answer a question
    conditionalPanel(
      condition = "input.sb_page4_button && !input.sb_page5_button",
      div(
        style = "text-align: center; max-width: 500px; margin: 0 auto;",
        h3("Now that you're awake, please answer the following question.",
          "It might be Monday or Tuesday, and you might have been awake the day before,",
          "but if you were, you don't remember what you said the first time.",
          style = "font-family: Helvetica; font-size: 20px; margin-bottom: 20px; margin-right: 20px;"
        ),
        div(
          style = "margin: 0 auto; max-width: 300px; display: flex; flex-direction: column; align-items: center;", # Centering the textInput
          div(
            style = "margin-bottom: 15px;",
            HTML('<p style="font-family: Helvetica; font-size: 16px; margin: 0;">What is the probability that the coin came up heads?</p>')
          ),
          HTML('<input type="text" id="answer" placeholder="Enter your answer"
            style="width: 100%; padding: 10px; font-family: Helvetica; font-size: 16px; border: 1px solid #ccc; border-radius: 5px;">')
        ),
        p("When you click on the button below, you will experience temporal amnesia.",
          style = "font-family: Helvetica; font-size: 12px; margin-bottom: 35px;"
        ),
        actionButton("sb_page5_button", "Temporal Amnesia", # Button to proceed to page 5
          class = "email-button btn-primary btn-lg",
          style = "font-family: Helvetica; background-color: white; border-color: white; color: black;"
        )
      )
    ),

    ###### Page 5: End of the Experiment, thanks for the participation
    conditionalPanel(
      condition = "input.sb_page5_button > 0",
      h2("End of Experiment"),
      p("Thank you for your participation!"),
      p("The experiment is now over, but we would like to ask you to answer another question on the next page for the collection of statistical data."),
      p("Click on the button below if you're ready."),
      actionButton("sb_page6_button", "Next", # Button to proceed to page 6
        class = "btn-primary btn-lg",
        style = "font-family: Helvetica; background-color: white; border-color: white; color: black;"
      )
    ),

    ###### Page 6: Now that the Experiment ended, choose again
    conditionalPanel(
      condition = "input.sb_page6_button",
      h2("If you put yourself back into the situation to answer the question after being woken up, what would you reply?"),
      radioButtons(
        "answer",
        label = NULL,
        choices = c(
          "The probability that the coin came up heads is 1/3",
          "The probability that the coin came up heads is 1/2"
        ),
        selected = character(0)
      ),
      column(
        width = 11,
        # Page 7: You chose 1/3
        ###########################################################################
        conditionalPanel(
          condition = "input.answer == 'The probability that the coin came up heads is 1/3'",
          h2("Are you sure about that?"),
          p(tags$span(style = "font-size: larger;", "From my perspective, as an advocate of David Lewis's viewpoint on the Sleeping Beauty problem, ")),
          p(tags$span(style = "font-size: larger;", "I believe that the widely accepted 1/3 approach is flawed.")),
          p(tags$span(style = "font-size: larger;", "Let me explain why. In this intriguing thought experiment, ")),
          p(tags$span(style = "font-size: larger;", "I find myself in the role of Sleeping Beauty. ")),
          p(tags$span(style = "font-size: larger;", "I am put to sleep, and a fair coin is flipped. ")),
          p(tags$span(style = "font-size: larger;", "My memory of the event is wiped clean, and I am unaware of the outcome. ")),
          p(tags$span(style = "font-size: larger;", "I am then awakened either once (Heads) or twice (Tails) without any knowledge of the specific outcome of the coin flip. ")),
          p(tags$span(style = "font-size: larger;", "Now, when considering the probability of the coin landing on heads, ")),
          p(tags$span(style = "font-size: larger;", "many argue that there are three equally likely scenarios: Heads-Heads, Heads-Tails, and Tails-Heads. ")),
          p(tags$span(style = "font-size: larger;", "Consequently, they suggest that I should assign a 1/3 probability to the coin landing on heads and answer \"Heads\" with that same probability. ")),
          p(tags$span(style = "font-size: larger;", "However, I respectfully disagree with this line of reasoning. ")),
          p(tags$span(style = "font-size: larger;", "From my personal standpoint, I must take into account the inherent uncertainty that arises due to my limited self-location knowledge. ")),
          p(tags$span(style = "font-size: larger;", "I am aware that I have been awakened at least once, but I lack direct observational evidence about the exact number of awakenings. ")),
          p(tags$span(style = "font-size: larger;", "This leads to my assumption, that the probability that the coin came up heads")),
          p(tags$span(style = "font-size: larger;", "has to be 1/2 because it's a fair coin that was flipped and the probbility of this possible outcome has to be 1/2")), radioButtons(
            "page7_option",
            "Make your final choice:",
            choices = c(
              "The probability that the coin came up heads is 1/3",
              "The probability that the coin came up heads is 1/2"
            ),
            selected = character(0)
          ),
          br(),
          actionButton("sb_page7_button", "Lock In",
            class = "btn-primary btn-lg",
            style = "font-family: Helvetica; background-color: white; border-color: white; color: black;"
          ), # Button to lock in the answer from Page 7
          # Page 9: The final page where the explanation text is added if you lock in 1/3
          ###########################################################################
          conditionalPanel(
            condition = "input.sb_page7_button > 0",
            h2("Text"),
            p("Final page, locked in on the David Lewis site.")
          )
        ),
        # Page 8: You chose that the probability is 1/2
        ###########################################################################
        conditionalPanel(
          condition = "input.answer == 'The probability that the coin came up heads is 1/2'",
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
            "page6_option",
            "Make your final choice:",
            choices = c(
              "The probability that the coin came up heads is 1/3",
              "The probability that the coin came up heads is 1/2"
            ),
            selected = character(0)
          ),
          br(),
          actionButton("sb_page8_button", "Lock In",
            class = "btn-primary btn-lg",
            style = "font-family: Helvetica; background-color: white; border-color: #4e79a7; color: black;"
          ), # Button to lock in the answer from Page 6
          # Page 10: The final Page where the explanation Text is added locked in 1/2
          ###########################################################################
          conditionalPanel(
            condition = "input.sb_page8_button > 0",
            h2("Text"),
            p("Final site locked in on the Adam Elga site.")
          )
        )
      )
    )
  )
}
