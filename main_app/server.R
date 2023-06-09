library(styler)

# styles the R files in the directory and in subdirectories
style_dir()

# call the scripts
source("illusions/birthday/birthdayServer.R")
source("illusions/lindley/lindleyServer.R")
source("illusions/sleepingbeauty/sbServer.R")

server <- function(input, output) {
  birthdayServer("birthday")
  lindleyServer("lindley")
  sbServer("sleepingbeauty")
}
