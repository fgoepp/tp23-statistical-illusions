# Describes what will happen during the experiment
timetable_Description <- p(
  p("Great that you made it! Let's walk through the details of the study.",
    style = "color: black; font-size: 17px; text-align: center; margin-bottom: 30px;"
  ),
  p("Here's how it works:",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 12px;"
  ),
  p("During the experiment, you will go through either one or two cycles of sleeping and waking up.",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 12px;"
  ),
  p("when you first go to sleep a toss of a fair coin will determine if you wake up once (heads) or twice (tails).",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 12px;"
  ),
  p("Each time you wake up, you will be asked to make a guess about the outcome of a coin flip.",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 12px;"
  ),
  p("After providing your guess, you will receive medication that induces temporary amnesia.",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 12px;"
  ),
  p("This medication will make you forget that you woke up and the answer you provided.",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 12px;"
  ),
  p("Your goal is to maximize your accuracy in predicting the coin flip outcome.",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 25px;"
  ),
  p("Here you can see the timetable of the awakenings in both scenarios.",
    style = "font-size: 20px; font-family: Helvetica; margin-bottom: 25px;"
  )
)

# shows the timetable of the following study with the different scenarios
study_Timetable <- fluidRow(
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
)

# the argument against the 1/2 perspective stated by Adam Elga
adam_Elga_text <- p(
  p(tags$span(style = "font-size: larger;", "If you believe that the probability in the Sleeping Beauty problem that heads came up is 1/2,")),
  p(tags$span(style = "font-size: larger;", "I understand your perspective. However, based on my understanding of the problem")),
  p(tags$span(style = "font-size: larger;", "I would argue differently.")),
  p(tags$span(style = "font-size: larger;", "I assign a probability of 1/3 to the event that heads came up.")),
  p(tags$span(style = "font-size: larger;", "This view takes into account the two different experiences that Sleeping Beauty")),
  p(tags$span(style = "font-size: larger;", "undergoes during the experiment: one when she wakes up on Monday and another")),
  p(tags$span(style = "font-size: larger;", "when she wakes up on Tuesday and a third when she sleeps through the next day. Each experience should be given equal weight when determining probabilities.")),
  p(tags$span(style = "font-size: larger;", "While it may seem intuitive to assign a 1/2 probability,")),
  p(tags$span(style = "font-size: larger;", "considering that heads and tails are equally likely outcomes in a fair coin toss,")),
  p(tags$span(style = "font-size: larger;", "the introduction of multiple observations and experiences changes the dynamics")),
  p(tags$span(style = "font-size: larger;", "of the problem.")),
  p(tags$span(style = "font-size: larger;", "additional factors into the probability assessment.")),
  p(tags$span(style = "font-size: larger;", "If you think you're still right, lock in your choice,")),
  p(tags$span(style = "font-size: larger;", "but you can still change your opinion.")),
  p(tags$span(style = "font-size: larger;", "Adam Elga."))
)

# The argument against the 1/3 perspective stated from an advocate of David Lewis's viewpoint
david_Lewis_text <- p(
  p(tags$span(style = "font-size: larger;", "From my perspective, as an advocate of David Lewis's viewpoint on the Sleeping Beauty problem, ")),
  p(tags$span(style = "font-size: larger;", "I believe that the widely accepted 1/3 approach is flawed.")),
  p(tags$span(style = "font-size: larger;", "Let me explain why. In this intriguing thought experiment, ")),
  p(tags$span(style = "font-size: larger;", "I find myself in the role of Sleeping Beauty. ")),
  p(tags$span(style = "font-size: larger;", "I am put to sleep, and a fair coin is flipped. ")),
  p(tags$span(style = "font-size: larger;", "My memory of the event is wiped clean, and I am unaware of the outcome. ")),
  p(tags$span(style = "font-size: larger;", "I am then awakened either once (Heads) or twice (Tails) without any knowledge of the specific outcome of the coin flip.")),
  p(tags$span(style = "font-size: larger;", "Now, when considering the probability of the coin landing on heads, ")),
  p(tags$span(style = "font-size: larger;", "many argue that there are three equally likely scenarios.")),
  p(tags$span(style = "font-size: larger;", "Consequently, they suggest that I should assign a 1/3 probability to the coin landing on heads and answer \"Heads\" with that same probability. ")),
  p(tags$span(style = "font-size: larger;", "However, I respectfully disagree with this line of reasoning. ")),
  p(tags$span(style = "font-size: larger;", "From my personal standpoint, I must take into account the inherent uncertainty that arises due to my limited self-location knowledge. ")),
  p(tags$span(style = "font-size: larger;", "I am aware that I have been awakened at least once, but I lack direct observational evidence about the exact number of awakenings. ")),
  p(tags$span(style = "font-size: larger;", "Also  only new relevant evidence, centred or uncentred, produces a
change in credence; and the evidence of the different scenarios is not
relevant to HEADS versus TAILS. ")),
  p(tags$span(style = "font-size: larger;", "This leads to my assumption, that the probability that the coin came up heads")),
  p(tags$span(style = "font-size: larger;", "has to be 1/2 because it's a fair coin that was flipped and the probbility of this possible outcome has to be 1/2"))
)
