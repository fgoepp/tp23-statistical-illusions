library("shinydashboardPlus")
library(ggplot2)
library(shiny)
library(shinydashboard)
library(datasets)

# sources
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
