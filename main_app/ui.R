library("styler")
library(shinydashboard)

# call the scripts
source("illusions/birthday/birthdayUI.R")

style_file("ui.R")
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
      ),
      menuItem("MetaPage", tabName = "meta_tab", icon = icon("info-circle")),

      # Settings
      menuItem(
        icon = icon("gear"),
        tabName = "settings_tab",
        "Settings"
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
          p("text/plot here pls ")
        )
      ),

      # Monte Carlo Fallacy tab item
      tabItem(
        tabName = "mc_fallacy_tab",
        tabPanel(
          "Monte Carlo Fallacy",
          h4("Monte Carlo Fallacy"),
          p("text/plot here pls ")
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
          p("text/plot here pls ")
        )
      ),
      tabItem(
        tabName = "lindley_tab",
        tabPanel(
          "Lindley's Paradox",
          h4("Lindleys Paradox"),
          p("text/plot here pls ")
        )
      ),

      # Meta tab item
      tabItem(
        tabName = "meta_tab",
        tabPanel(
          "Meta Page",
          h4("Meta Page"),
          p("text here pls ")
        )
      ),

      # Settings tab item
      tabItem(
        tabName = "settings_tab",
        fluidRow(
          box(
            title = "Settings",
            selectInput(
              "color_selector",
              label = "Choose a color",
              choices = c("red", "yellow", "blue", "green", "navy", "orange", "purple", "maroon", "black"),
              selected = "black"
            )
          )
        )
      )
    )
  )
)
