library("shiny")

## Intro Tab ##
intro_page <- tabPanel(
    "Overview and Questions",
    includeCSS("shiny/Style.css"),
    htmlOutput("intro_text"),
    br(),
    img(src ="https://assets.weforum.org/article/image/nByQgCfys3NUy7XTobKRIkcTWvkAe0rDWr5X1tNGEIA.JPG",
        width = 990, height = 660)
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
      textOutput("sector_text"),
      plotlyOutput("sector_boxplot")  ##### HERE
    )
  )
)



## Unemployement Plot tab ##
# Shiny widgets for unemployment plot page

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

## Boxplot Tab ##
sector_distribution_page <- tabPanel(
  "Sector Distribution",
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    # 1st column
    sidebarPanel(
      selectInput(
        inputId = "work_sectors",
        label = strong("Work Sectors"),
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
    
    # Display output - the visualization in the main panel, 2nd column
    mainPanel(
      h3("Sector Statistics"),
      plotlyOutput("sector_boxplot"),
      p("This boxplot was generated to further explore the variance within each
        job sector as well as across each sector as a result of COVID-19 in
        October. User can select sector(s) by typing the sector(s) 
        they want to see the statistics for."),
      p(""),
      p("From the plot, we can see how the effect varies across the board,
      especially when comparing with the median of that sector.
      Utilities had the largest variance within the sector, where many
      businesses had high percentage of being effected compared to the
      sector’s median. The entire Management job sector was affected the most
      with almost no outliers, high median percentage of change, and
      high percentage of change for each business in the sector."),
      p(""),
      p("Most of other sectors seems to recover from the pandamic,
      with the median of change falling below 13 percent.")
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
  "COVID-19's effect on American businesses", 
  intro_page,
  unemployment_plot_page,
  sector_chart_page,
  #sector_distribution_page,
  conclusion_page
  )

  



