sbUI <- function(id) {
  ns <- NS(id)
  source("layout.R")
  # file where the texts displayed in the app are stored
  source("illusions/sleepingbeauty/sbText.R")

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
        timetable_Description,
        h3("Timetable:",
          style = "font-family: Helvetica; font-size: 24px; margin-bottom: 10px;"
        ),
        study_Timetable,
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
          david_Lewis_text,
          radioButtons(
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
            tags$div(
              style = "display: flex; justify-content: center; align-items: center; height: 80vh;",
              tags$iframe(
                style = "width: 100%; height:100%;",
                src = "sb_text.pdf"
              )
            )
          )
        ),
        # Page 8: You chose that the probability is 1/2
        ###########################################################################
        conditionalPanel(
          condition = "input.answer == 'The probability that the coin came up heads is 1/2'",
          h2("Are you sure about that?"),
          adam_Elga_text,
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
            tags$div(
              style = "display: flex; justify-content: center; align-items: center; height: 80vh;",
              tags$iframe(
                style = "width: 100%; height:100%;",
                src = "sb_text.pdf"
              )
            )
          )
        )
      )
    )
  )
}
