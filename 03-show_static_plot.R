# Libraries ----
library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)


# Initialize Data ----
dat <- readRDS(file = "D:/R_shiny/02-Build_the_Frame/app-data/subregion_agg.rds")



# UI ----
ui <- dashboardPage(
  
  #### Header ----
  dashboardHeader(
    title = "COVID-19 Country Comparison",
    titleWidth = 350
  ),
  #### Sidebar ----
  dashboardSidebar(
    
    width = 350,
    br(),
    h4("Select Your Inputs Here", style = "padding-left:20px")
    
  ),
  #### Body ----
  dashboardBody(
    tabsetPanel(
      type = "tabs",
      id = "tab_selected",
      tabPanel(
        title = "Country View",
        plotOutput("plot_data_country")
      )
    )
  )
)

server <- function(input, output) {
  output$plot_data_country <- renderPlot({
  ggplot(data = clean_dat, aes(y= new_confirmed,x=date,color= country_name)) +
    geom_line(size=1.5) + 
    labs(color="Country Name")
  })
}

shinyApp(ui, server)