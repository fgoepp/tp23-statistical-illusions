library("styler")

# styles the R files in the directory and in subdirectories
style_dir()

# call the scripts
source("illusions/birthday/birthdayServer.R")

server <- function(input, output) {
  birthdayServer("birthday")
}
