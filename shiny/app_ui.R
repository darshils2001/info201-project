library("shiny")
library("lintr")
library("styler")

## Intro Tab ##
intro_page <- tabPanel(
  "Overview and Questions",
  includeCSS("shiny/Style.css"),
  htmlOutput("intro_text"),
  br(),
  img(
    src = "https://assets.weforum.org/article/image/nByQgCfys3NUy7XTobKRIkcTWvkAe0rDWr5X1tNGEIA.JPG",
    width = 990, height = 660
  )
)

## Unemployment Plot tab ##

# Get column names of unemployment dataset (DoL)
col_names <- colnames(unemployment)
covid_nat_names <- colnames(national)

# Convert column names to readable titles for both graphs
readable_names <- c(
  "Non Seasonally Adjusted Filings" = col_names[2],
  "Seasonal Factors" = col_names[3],
  "Seasonally Adjusted Filings" = col_names[4],
  "Seasonally Adjusted 4-week Filings" = col_names[5],
  "Covered Employment" = col_names[6]
)

covid_names <- c(
  "Cases" = covid_nat_names[4],
  "Deaths" = covid_nat_names[5]
)

# Drop down menu to filter by certain unemployment metric
claim_type_input <- selectInput(
  inputId = "claim_input",
  label = "Select type of unemployment claim",
  choices = readable_names
)

# Overlay covid 19 cases with unemployment metric
covid_input <- selectInput(
  inputId = "covid_input",
  label = "Display US Covid Cases or Deaths",
  choices = covid_names
)

unemployment_plot_page <- tabPanel(
  "Weekly Unemployment Claims",
  sidebarLayout(
    sidebarPanel(
      claim_type_input,
      covid_input
    ),
    mainPanel(
      plotlyOutput("unemployment_plot"),
      textOutput("unemployment_text"),
      br(),
      plotlyOutput("covid_plot"),
      textOutput("covid_text")
    )
  )
)

## Sector Chart Tab ##
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

## Boxplot Tab ##
sector_distribution_page <- tabPanel(
  "Sector Distribution",
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "sector_choice",
        label = "Work Sectors",
        multiple = TRUE,
        choices = c(
          "Mining", "Utilities", "Construction", "Manufacturing",
          "Wholesale Trade", "Retail Trade", "Transportation", "Information",
          "Finance", "Real Estate", "Professional Services", "Management",
          "Administrative Services", "Educational Services", "Health Care",
          "Entertainment", "Food Services", "Other Services"
        ),
        selected = "Management"
      )
    ),

    # Display output - the visualization in the main panel, 2nd column
    mainPanel(
      plotlyOutput("sector_boxplot"),
      br(),
      htmlOutput("boxplot_text")
    )
  )
)

## Conclusion tab ##
conclusion_page <- tabPanel(
  "Summary",
  mainPanel(
    htmlOutput("conclusion_text")
  )
)

## Define UI##
my_ui <- navbarPage(
  "COVID-19's Effect on American Businesses",
  inverse = TRUE,
  intro_page,
  unemployment_plot_page,
  sector_chart_page,
  sector_distribution_page,
  conclusion_page
)
