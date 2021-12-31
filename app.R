# Setup -------------------------------------------------------------------

library(shiny)
library(readr)
library(dplyr)
library(tidyr)
library(glue)
library(purrr)

# Import data -------------------------------------------------------------

ga4_data <- read_csv(
  "data/ga4_data.csv", 
  col_types = list(event_date = col_date("%Y%m%d"))
)

make_summary_tile <- function(header, text_output, css_id){
  column(2,
         div(header),
         textOutput(text_output),
         id = css_id
  )
}

tiles <- tribble(
  ~header         , ~text_output,
  "Users"         , "users",
  "Page Views"    , "page_view",
  "Session Starts", "session_start",
  "Purchases"     , "purchase"
)

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "app-styling.css")
    ),
  sidebarLayout(
    sidebarPanel(
      dateInput("date",
                "Select a date for summary:",
                value = max(ga4_data$event_date),
                max = max(ga4_data$event_date),
                min = min(ga4_data$event_date)
      )
    ),
    mainPanel(
      fluidRow(
        h2("Summary report"),
        pmap(tiles, ~make_summary_tile(
          header = ..1, text_output = ..2, css_id = "summary-tile"))
      ),
      br(),
      fluidRow(
        textOutput("date")    
      )
    ) 
  )
)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  data <- reactive({
    filter(ga4_data, .data[["event_date"]] == input$date)
  })
  
  c('users', 'page_view', 'session_start', 'purchase') %>% 
    walk(~{output[[.x]] <- renderText(format(data()[[.x]], big.mark = ','))})
  
  output$date <- renderText(glue("Estimates represent data from {data()$event_date}"))
}

shinyApp(ui, server)