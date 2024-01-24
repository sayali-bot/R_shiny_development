library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)
ui <- dashboardPage(
  #### Header
  dashboardHeader(
    title = "Covid-19 country Comparison",
    titleWidth = 350
  ),
  dashboardSidebar(
    width=350,
    br(),
    h4("Select Your Inputs Here",style="padding-left:20px")
    
  ),
  dashboardBody(
    tabsetPanel(
      type = "tabs",
      id = "tab_selected",
      tabPanel(
        title = "Country View"
      )
    )
  )
)
server <- function(input,output){
  
}
shinyApp(ui,server)