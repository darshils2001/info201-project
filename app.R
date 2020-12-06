library("shiny")

source("shiny/app_server.R")
source("shiny/app_ui.R")

shinyApp(ui = my_ui, server = my_server)