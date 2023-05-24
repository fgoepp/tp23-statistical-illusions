library("styler")
style_file("server.R")

# call the scripts
source("illusions/birthday/birthdayServer.R")

server <- function(input, output) {
  birthdayServer("birthday")
}
