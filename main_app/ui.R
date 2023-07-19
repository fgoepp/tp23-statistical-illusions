library(shinydashboard)

# call the scripts
source("illusions/birthday/birthdayUI.R")
source("illusions/lindley/lindleyUI.R")
source("illusions/sleepingbeauty/sbUI.R")
source("illusions/gambler/gamblerUI.R")
source("mainPage/mpageUI.R")

ui <- dashboardPage(
  skin = "black",

  # Header
  dashboardHeader(
    title = "?"
  ),

  # Sidebar
  dashboardSidebar(

    # Sidebar menu
    sidebarMenu(

      # Sidebar menu items
      menuItem("MainPage", tabName = "main_tab", icon = icon("home")),

      # Illusions submenu
      menuItem(
        "Illusions",
        icon = icon("eye"),
        menuSubItem(
          "Monte Carlo Fallacy",
          tabName = "mc_fallacy_tab",
          icon = icon("dice")
        ),
        menuSubItem(
          "Birthday Problem",
          tabName = "birthday_tab",
          icon = icon("birthday-cake")
        ),
        menuSubItem(
          "Sleeping Beauty Problem",
          tabName = "sleeping_tab",
          icon = icon("bed")
        ),
        menuSubItem(
          "Lindleys Paradox",
          tabName = "lindley_tab",
          icon = icon("chart-area")
        ),
        expand = TRUE # Make the submenu expandable
      )
    )
  ),

  # Body
  dashboardBody(

    # Tab items
    tabItems(

      # Main tab item
      tabItem(
        tabName = "main_tab",
        tabPanel(
          "Main Page",
          h4("Main Page"),
          mpageUI("mainPage")
        )
      ),

      # Monte Carlo Fallacy tab item
      tabItem(
        tabName = "mc_fallacy_tab",
        tabPanel(
          "Monte Carlo Fallacy",
          h4("Monte Carlo Fallacy"),
          gamblerUI("gambler")
        )
      ),

      # Birthday Problem tab item
      tabItem(
        tabName = "birthday_tab",
        tabPanel(
          "Birthday Problem",
          h4("Birthday Problem"),
          birthdayUI("birthday")
        )
      ),

      # Sleeping Beauty Problem tab item
      tabItem(
        tabName = "sleeping_tab",
        tabPanel(
          "Sleeping Beauty Problem",
          h4("Sleeping Beauty Problem"),
          sbUI("sleepingbeauty")
        )
      ),
      tabItem(
        tabName = "lindley_tab",
        tabPanel(
          "Lindley's Paradox",
          h4("Lindleys Paradox"),
          lindleyUI("lindley")
        )
      )
    )
  )
)
