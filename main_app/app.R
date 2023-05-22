
library("styler")
library("shinydashboardPlus")
library(ggplot2)
library(shiny)
library(shinydashboard)
library(datasets)

#styler
style_file("app.R")

#sources
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)

