# Libraries ----
library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)



# Initialize Data ----
dat <- readRDS(file = "D:/R_shiny/02-Build_the_Frame/app-data/subregion_agg.rds")

clean_dat <- dat %>%
  select( !subregion1_name ) %>%
  filter( country_name == "Canada" & date >= "2020-01-01" & date <= "2020-12-31") %>%
  group_by(country_name,date) %>%
  summarise_all(sum) %>%
  select( country_name, date, "new_confirmed") %>%
  arrange(date)
#View(clean_dat)
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
    h4("Select Your Inputs Here", style = "padding-left:20px"),
    #metric input
    selectInput(
      inputId = "metric",
      label = strong("Select metric",style="font family:'aerial';font-size:12px"),
      choices = colnames(dat)[4:ncol(dat)],
      selected = "new_confirmed"
    ),
    selectInput(
      inputId = "Country",
      multiple = TRUE,
      label = strong("Select Countries to compare",style="font-family:'aerial';font-size: 14px"),
      choices = sort(unique(dat$country_name)),
      selected = c("United States of America","France","Canada")
    ),
    #date range country input
    dateRangeInput(
      inputId = "date_range_country",
      label= "Select Date Range: ",
      start = "2020-01-01",
      end= "2020-12-31"
    )
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
    ggplot( data = clean_dat, aes(y = new_confirmed, x = date, color = "Canada") ) +
      geom_line(size = 1.5) +
      labs(color="Country Name") 
  })
  
}

shinyApp(ui, server)