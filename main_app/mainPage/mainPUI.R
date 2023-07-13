mainPUI <- function(id) {
  ns <- NS(id)
  source("layout.R")
  library(shiny)

  fluidPage(
    sidebarLayout(
      sidebarPanel(
        # Introduction section
        h2("Welcome to the Statistical Illusions App!"),
        p("Explore paradoxes, fallacies and problems in probability and decision theory and statistics."),
        p("Discover how intuitions about randomness and probability can sometimes mislead us."),
        p("Let's dive in and challenge your perception of probability!")
      ),
      mainPanel(
        tabsetPanel(
          tabPanel(
            "Overview",
            # Overview section
            h2("Overview: Unveiling Statistical Illusions"),
            p("This app presents a collection of statistical illusions and paradoxes."),
            tags$ol(
              tags$li(
                h4("Gambler's Fallacy"),
                p("Experience the captivating illusion that previous outcomes influence future probabilities.")
              ),
              tags$li(
                h4("Birthday Problem"),
                p("Uncover the unexpected probability of shared birthdays in a group and challenge your intuitions.")
              ),
              tags$li(
                h4("Lindley's Paradox"),
                p("Delve into the enigmatic phenomenon where evidence can favor two opposing hypotheses simultaneously.")
              ),
              tags$li(
                h4("Sleeping Beauty Problem"),
                p("Engage in the controversial question of updating probabilities after acquiring new information during an experiment.")
              )
            )
          ),
          tabPanel(
            "About Us",
            # About Us section
            h2("About Us"),
            p("We are a team of data enthusiasts dedicated to exploring statistics and probability."),
            p("This app was implemented in R using shinyApps"),
            p("For more information about this app and to access the source code, please visit our", a("GitHub repository", href = "https://github.com/fgoepp/tp23-statistical-illusions"), ".")
          )
        )
      )
    )
  )
}
