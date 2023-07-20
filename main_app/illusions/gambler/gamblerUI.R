gamblerUI <- function(id) {
  ns <- NS(id)

  library(ggplot2)
  library(shinyWidgets)
  library(shinyjs)

  navbarPage("Navigation Bar",
    id = "inTabset",
    # page 1
    tabPanel("Introduction",
      value = "panel1",
      h4("Welcome fellow gambler."),
      p("This subsection of the app concerns itself with the gambler's fallacy."),
      p("The intended experience is to go through the app chronologically, since the tabPanels will appear one after another."),
      conditionalPanel(
        condition = "input.gambler_first_page_button == 0 & input.gambler_unlock_first_page == 0",
        p("If you are ready to continue, please press the button below to advance."),
        actionButton("gambler_first_page_button", "unlock Multiple Choice")
      )
    ),

    # page 2
    # icons from iconpacks.net (no credit required)
    tabPanel("Multiple Choice",
      value = "panel2",
      conditionalPanel(
        condition = ("input.gambler_first_page_button >= 1 | input.gambler_unlock_first_page >= 1"),
        verticalLayout(
          p("The former events are noted on the left hand side."),
          p("We will now throw the same fair coin another time."),
          p("How likely is the outcome 'heads'?"),
          fluidRow(
            column(1,
              align = "center", style = "font-size: 20px; font-family: Helvetica;",
              div(
                style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                p("100x", style = "padding:20px;")
              )
            ),
            column(1,
              align = "center", style = "font-size: 20px; font-family: Helvetica;",
              div(
                style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                icon(
                  name = NULL,
                  style = "
                background: url('euro_kopf.jpg');
                background-size: contain;
                background-position: center;
                background-repeat: no-repeat;
                height: 80px;
                width: 80px;
                display: block;
              "
                )
              )
            ),
            column(1,
              align = "center", style = "font-size: 20px; font-family: Helvetica;",
              div(
                style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                radioButtons(
                  "guess_flip", "",
                  c("<50%" = "3", "50%" = "1", ">50%" = "2"),
                  selected = character(0)
                )
              )
            ),
            column(9,
              align = "center", style = "font-size: 20px; font-family: Helvetica;",
              div(
                style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                conditionalPanel(
                  condition = "!input.guess_flip",
                  p("please decide"), style = "padding:20px;"
                ),

                # 50/50
                conditionalPanel(
                  condition = "input.guess_flip == '1'",
                  conditionalPanel(
                    condition = "!input.gambler_im_sure_button",
                    p("Are you sure?."), style = "padding:20px;",
                    actionButton("gambler_im_sure_button", "Yes I am")
                  ),
                  conditionalPanel(
                    condition = "input.gambler_im_sure_button",
                    p(""),
                    p("You chose the correct answer."),
                    p("The former events do not influence the chance of future events."),
                    p("Thus, the chance of the event tails/heads is 50/50."),
                    conditionalPanel(
                      condition = "!input.gambler_second_task_button",
                      actionButton("gambler_second_task_button", "Understood, next task please")
                    )
                  )
                ),

                # heads
                conditionalPanel(
                  condition = "input.guess_flip == '2'",
                  p("Reconsider:"),
                  p("The coin is fair, thus heads should not be more likely than tails after throwing 100 heads."),
                  style = "padding:20px;"
                ),

                # tails
                conditionalPanel(
                  condition = "input.guess_flip == '3'",
                  p("Reconsider:"),
                  p("It is almost impossible to throw 101 heads in succession,"),
                  p("but how unlikely is it to throw 100 heads and then 1 tails?"),
                  style = "padding:20px;"
                )
              )
            ),
          )
        ),
        conditionalPanel(
          condition = "input.gambler_second_task_button",
          # reverse position
          conditionalPanel(
            condition = "input.gambler_im_sure_button",
            verticalLayout(
              p("Again, the former events are noted on the left hand side."),
              p("We will now throw the same D6 again."),
              p("How likely is the event '6'?"),
              fluidRow(
                column(1,
                  align = "center", style = "font-size: 20px; font-family: Helvetica;",
                  div(
                    style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                    p("100x", style = "padding:20px;")
                  )
                ),
                column(1,
                  align = "center", style = "font-size: 20px; font-family: Helvetica;",
                  div(
                    style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                    icon(
                      name = NULL,
                      style = "
                background: url('D6_6.png');
                background-size: contain;
                background-position: center;
                background-repeat: no-repeat;
                height: 80px;
                width: 80px;
                display: block;
              "
                    )
                  )
                ),
                column(1,
                  align = "center", style = "font-size: 20px; font-family: Helvetica;",
                  div(
                    style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                    radioButtons(
                      "guess_dice", "",
                      c("<1/6" = "1", "1/6" = "3", ">1/6" = "2"),
                      selected = character(0)
                    )
                  )
                ),
                column(9,
                  align = "center", style = "font-size: 20px; font-family: Helvetica;",
                  div(
                    style = "border: 1px solid #ddd; border-radius: 4px; padding: 10px; background-color: #f9f9f9;",
                    conditionalPanel(
                      condition = "!input.guess_dice",
                      p("please decide"), style = "padding:20px;"
                    ),

                    # 1
                    conditionalPanel(
                      condition = "input.guess_dice == '1'",
                      p("Reconsider:"),
                      p("An event having happened often, doesn't make other events more likely."),
                      style = "padding:20px;",
                    ),

                    # 6
                    conditionalPanel(
                      condition = "input.guess_dice == '2'",
                      conditionalPanel(
                        condition = "!input.gambler_im_sure_button2",
                        p("Reconsider:"),
                        p("The fair coin taught us, that former events do not influence future events in cases of unconditional probability."),
                        style = "padding:20px;",
                        actionButton("gambler_im_sure_button2", "No, I'm sure")
                      ),
                      conditionalPanel(
                        condition = "input.gambler_im_sure_button2",
                        p(""),
                        p("You chose the correct answer."),
                        p("Since the dice isn't given as fair, it is rational and empirical to assume that the dice is strongly biased in favor of rolling a 6."),
                        p("In most use-cases it takes an impractical amount of observations to detect biases."),
                        p("Rolling 100 sixes in succession is unlikely enough to assume that the dice isn't fair though."),
                        conditionalPanel(
                          condition = "input.gambler_second_page_button == 0 & input.gambler_unlock_second_page == 0",
                          actionButton("gambler_second_page_button", "unlock Plot")
                        )
                      )
                    ),

                    # cant decide dice
                    conditionalPanel(
                      condition = "input.guess_dice == '3'",
                      conditionalPanel(
                        condition = "!input.gambler_im_sure_button3",
                        p("Are you sure?"),
                        style = "padding:20px;",
                        actionButton("gambler_im_sure_button3", "Of course I am")
                      ),
                      conditionalPanel(
                        condition = "input.gambler_im_sure_button3",
                        p(""),
                        p("You chose the wrong answer."),
                        p("The clue lies in the wording."),
                        p("There is a key difference between the scenarios."),
                      )
                    )
                  )
                ),
              )
            )
          )
        )
      ),
      # brute unlock page 1
      conditionalPanel(
        condition = ("input.gambler_first_page_button == 0 & input.gambler_unlock_first_page == 0"),
        p("This page hasn't been unlocked yet"),
        actionButton("gambler_unlock_first_page", "unlock page")
      )
    ),
    # page 2 plotpage
    tabPanel("Plot",
      value = "panel3",
      conditionalPanel(
        condition = ("input.gambler_second_page_button >= 1 | input.gambler_unlock_second_page >= 1"),
        sidebarPanel(
          selectInput(
            ns("experiment_selector"),
            label = "experiments:",
            choices = c("Sixes for a dice", "Heads for a coin"),
            selected = "Sixes for a dice"
          ),
          sliderInput(ns("likeliness_fair"), "prior p0 likelihood in %:", min = 0, max = 100, value = 50),
          actionButton(ns("reset_to_fairness"), "Set to absolute fairness"),
          sliderInput(ns("streak_length:"), "length of the streak of events:", min = 1, max = 20, value = 5),
          sliderInput(ns("second_prior_probability"), "probability of the event stated by the alternative H1", min = 0, max = 100, value = 0)
        ),
        mainPanel(
          p("The plot showcases how the likelihood of an event being fair shifts depending on several parameters."),
          p("It displays the odds for Hypothesis0 -the event is fair- and Hypothesis1 -the event isn't fair-"),
          plotOutput(ns("prior_plot")),
          textOutput(ns("rounded_to_0_txt")),
          conditionalPanel(
            condition = "input.gambler_third_page_button == 0 & input.gambler_unlock_third_page == 0",
            actionButton("gambler_third_page_button", "unlock History")
          )
        )
      ),
      # brute unlock page 2
      conditionalPanel(
        condition = ("input.gambler_second_page_button == 0 & input.gambler_unlock_second_page == 0"),
        p("This page hasn't been unlocked yet"),
        actionButton("gambler_unlock_second_page", "unlock page")
      )
    ),
    # page 3 History
    tabPanel("History",
      value = "panel4",
      conditionalPanel(
        condition = "input.gambler_third_page_button >= 1| input.gambler_unlock_third_page >= 1",
        p("Hier wird Geschichte geschrieben!")
      ),
      # brute unlock page 3
      conditionalPanel(
        condition = ("input.gambler_third_page_button == 0 & input.gambler_unlock_third_page == 0"),
        p("This page hasn't been unlocked yet"),
        actionButton("gambler_unlock_third_page", "unlock page")
      )
    )
  )
}
