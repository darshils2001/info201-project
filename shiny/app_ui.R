library("shiny")

intro_page <- tabPanel(
  "Overview and Questions",
  htmlOutput("intro_text")
  
  # Some additional *flare* will go here
)

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

# Shiny widgets for unemployment plot page

# Get column names of unemployment dataset (DoL)
col_names <- colnames(unemployment)

# Convert column names to readable titles
readable_names <- c(
  "Date" = col_names[1],
  "Non Seasonally Adjusted Filings" = col_names[2],
  "Seasonal Factors" = col_names[3],
  "Seasonally Adjusted Filings" = col_names[4],
  "Seasonally Adjusted 4-week Filings" = col_names[5],
  "Covered Employment" = col_names[6]
)

# Drop down menu to filter by certain unemployment metric
claim_type_input <- selectInput(
  inputId = "claim_input",
  label = "Select type of unemployment claim",
  choices = readable_names
)

# Overlay covid 19 cases with unemployment metric
covid_input <- checkboxInput(
  inputId = "covid_input",
  label = "Overlay COVID Cases",
  value = FALSE
)


unemployment_plot_page <- tabPanel(
  "Weekly Unemployment Claims",
  sidebarLayout(
    sidebarPanel(
      claim_type_input,
      covid_input
    ),
    mainPanel(
      plotlyOutput("unemployment_plot")
    )
  )
)

conclusion_page <- tabPanel(
  "Summary",
  mainPanel(
    htmlOutput("conclusion_text")
  )
)

my_ui <- navbarPage(
  "COVID-19's effect on American businesses",
  intro_page,
  sector_chart_page,
  unemployment_plot_page,
  conclusion_page
)

