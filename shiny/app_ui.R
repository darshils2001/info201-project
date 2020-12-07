library("shiny")


intro_page <- tabPanel(
  "Overview and Questions",
  p("Every individual is experiencing the effects of the Coronavirus pandemic in
some way, shape, or form, just as we all bear responsibility for slowing its 
spread. Nine months of lockdown, well over a quarter of a million Americans 
dead, and millions more infected have lead to one of the largest mass casualty 
events in our history. A brutal virus that relegates individuals to their homes 
is the enemy of the small business, with tens of thousands closing in the wake
of our economic downturn. This webpage will look at how the Coronavirus Pandemic 
has affected unemployment and revenue, and how that effect has been felt across
the myriad job sectors in the United States. We will be looking at which 
employment sectors have been hit the hardest by the virus, and when the worst 
months regarding revenue losses and jobless claims were. 

Looking at datasets detailing unemployment claims from the Department of Labor
as well as how unemployment and revenue changes have affected 19 separate 
employment sectors from the US Census Bureau this webpage will help provide 
information on the relationship between job sectors and the effect COVID-19 has 
had on them, the variance within each job sector (as well as across each sector 
as a result of COVID-19 in specific months), and the relationship of Non 
Seasonally Adjusted (NSA) unemployment claims per week filed in the United 
States since the beginning of the pandemic.")
  
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

unemployment_plot_page <- tabPanel(
  "Weekly Unemployment Claims",
  sidebarLayout(
    sidebarPanel(
      #Widgets
    ),
    mainPanel(
      plotOutput("unemployment_plot")
    )
  )
)

conclusion_page <- tabPanel(
  "Summary"
)



my_ui <- navbarPage(
  "COVID-19's effect on American businesses",
  intro_page,
  sector_chart_page,
  unemployment_plot_page,
  conclusion_page
)