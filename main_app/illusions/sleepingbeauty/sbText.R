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
  div(
    style = "background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);",
    p("If you believe that the probability of the Sleeping Beauty problem that heads came up is 1/2,"),
    p("I understand your perspective. However, based on my understanding of the problem"),
    p("I would argue differently."),
    p("I assign a probability of 1/3 to the event that heads come up."),
    p("This view considers the two experiences that Sleeping Beauty"),
    p("undergoes during the experiment: one when she wakes up on Monday, another"),
    p("when she wakes up on Tuesday, and a third when she sleeps through the next day. Each experience gives equal weight when determining probabilities."),
    p("While it may seem intuitive to assign a 1/2 probability,"),
    p("Considering that heads and tails are equally likely outcomes in a fair coin toss,"),
    p("The introduction of multiple observations and experiences changes the dynamics"),
    p("of the problem."),
    p("Additional factors into the probability assessment."),
    p("If you think you're right, lock in your choice,"),
    p("but you can still change your opinion."),
    p("Adam Elga.")
  )
)

# The argument against the 1/3 perspective stated from an advocate of David Lewis's viewpoint
david_Lewis_text <- p(
  div(
    style = "background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);",
    p("From my perspective, as an advocate of David Lewis's viewpoint on the Sleeping Beauty problem,"),
    p("The 1/3 approach is flawed."),
    p("Let me explain why. In this thought experiment,"),
    p("I find myself in the role of Sleeping Beauty."),
    p("I am put to sleep, and a fair coin is tossed."),
    p("My memory of the event is wiped clean, and I am unaware of the outcome."),
    p("I am then awakened once (Heads) or twice (Tails) without any knowledge of the specific outcome of the coin flip."),
    p("Now, when considering the probability of the coin landing on heads,"),
    p("many argue that there are three equally likely scenarios."),
    p("Consequently, they suggest I assign a 1/3 probability to the coin landing on heads and answer 'Heads' with that same probability."),
    p("However, I respectfully disagree with this line of reasoning."),
    p("From my standpoint, I must consider the inherent uncertainty arising from my limited self-location knowledge."),
    p("I know I have been awakened at least once, but I lack direct observational evidence about the exact number of awakenings."),
    p("Also, only new relevant evidence, centered or uncentred, produces a change in belief, and the proof of the different scenarios is irrelevant to Heads versus Tails."),
    p("This leads to my assumption that the probability that the coin came up heads"),
    p("has to be 1/2 because it's a fair coin that was flipped, and the likelihood of this possible outcome has to be 1/2.")
  )
)
