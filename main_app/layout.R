library("styler")
style_file("layout.R")
layout <- function(sidebar_input, mainpanel_output) {
  # create a sideBar layout
  sidebarLayout(
    sidebarPanel(
      # add the input
      sidebar_input
    ),
    mainPanel(
      # add the output
      mainpanel_output
    )
  )
}
