library("shiny")


sector_chart_page <- tabPanel(
  "Work Sectors",
  titlePanel("COVID-19 and American Work Sectors"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "work_sectors",
        label = "Work Sectors",
        multiple = TRUE,
        choices = c(
          "Mining", "Utilities", "Construction", "Manufacturing",
          "Wholesale Trade", "Retail Trade", "Transportation", "Information",
          "Finance", "Real Estate", "Professional Services", "Management",
          "Administrative Services", "Educational Services", "Health Care",
          "Entertainment", "Food Services", "Other Services"
        )
      )
    ),
    
    mainPanel(
      plotlyOutput("sector_bar_chart"),
      br(),
      textOutput("sector_text")
    )
  )
)

conclusion_page <- tabPanel(
  "Summary"
)

my_ui <- navbarPage(
  "COVID-19's effect on American businesses",
  sector_chart_page,
  conclusion_page
)