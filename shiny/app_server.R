#### Load Packages ###
library("readxl")
library("ggplot2")
library("tidyverse")
library("shiny")
library("dplyr")
library("plotly")

### Load Datasets ###

## Load Sector Dataset ##
sectors <- read_excel("datasets/National_Sector_Dataset.xls")

# Convert Sector Numbers to Names
sectors$NAICS_SECTOR <- gsub(11, "Agriculture", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(21, "Mining", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(22, "Utilities", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(23, "Construction", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(31, "Manufacturing", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(42, "Wholesale Trade", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(44, "Retail Trade", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(48, "Transportation", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(51, "Information", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(52, "Finance", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(53, "Real Estate", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(54, "Professional Services", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(55, "Management", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(56, "Waste Management", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(61, "Educational Services", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(62, "Health Care", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(71, "Arts", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(72, "Food Services", sectors$NAICS_SECTOR)
sectors$NAICS_SECTOR <- gsub(81, "Other Services", sectors$NAICS_SECTOR)

sectors <- sectors %>% 
  rename(Sector = NAICS_SECTOR)

## Load DoL Unemployment dataset and COVID-19 Cases dataset ##
unemployment <- read_csv("datasets/DoL_Unemployment.csv") %>% 
  rename(Date = X1, S.A.Four = "S.A. 4-Week") %>% 
  mutate(Date = as.Date(Date, format = "%m/%d/%Y"))

national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv") %>% 
  filter(date <= "2020-10-10") %>% 
  mutate(new_cases = cases - lag(cases, default = 0),
         new_deaths = deaths - lag(deaths, default = 0)) 

### Define server ###
my_server <- function(input, output) {
  ## Sector Bar Chart ##
  output$sector_bar_chart <- renderPlotly({
    selected_sectors <- sectors %>% 
      filter(Sector %in% input$work_sectors)
    
    # Find average % in each sector
    selected_sectors$ESTIMATE_PERCENTAGE <- as.numeric(
      gsub("[\\%,]", "", selected_sectors$ESTIMATE_PERCENTAGE)
    )
    
    average_sectors <- selected_sectors %>%
      group_by(Sector) %>%
      summarize(
        Percent = mean(ESTIMATE_PERCENTAGE)
      )
    
    p <- ggplot(data = average_sectors) +
      geom_col(
        mapping = aes(x = Sector, y = Percent),
        fill = "#CB4335"
      ) +
      labs(
        title = "Work Sector versus Percent of Businesses Affected by COVID-19",
        x = "Work Sector",
        y = "Average Weekly Percent of Businesses Affected"
      )  
    p <- ggplotly(p)
    p
  })
  
  ## Sector Box Plot ##
   output$sector_boxplot <- renderPlotly({
     selected_sectors <- sectors %>% 
       filter(Sector %in% input$work_sectors)
     
     # Find average % in each sector
     selected_sectors$ESTIMATE_PERCENTAGE <- as.numeric(
       gsub("[\\%,]", "", selected_sectors$ESTIMATE_PERCENTAGE)
     )
     
     average_sectors <- selected_sectors %>%
       group_by(Sector)
       
     
     p <- ggplot(data = average_sectors) +
       geom_boxplot(
         mapping = aes(x = Sector, y = ESTIMATE_PERCENTAGE),
         fill = "#CB4335"
       ) 
     p <- ggplotly(p)
     p
   })
  
  ## Intro text and image ##
  output$intro_text <- renderUI({
    paragraph_one <- "Every individual is experiencing the effects of the 
    Coronavirus pandemic in some way, shape, or form, just as we all bear 
    responsibility for slowing its spread. Nine months of lockdown, well over a 
    quarter of a million Americans dead, and millions more infected have lead to
    one of the largest mass casualty events in our history. A brutal virus that
    relegates individuals to their homes is the enemy of the small business, 
    with tens of thousands closing in the wake of our economic downturn. This
    webpage will look at how the Coronavirus Pandemic has affected unemployment 
    and revenue, and how that effect has been felt across the myriad job sectors 
    in the United States. We will be looking at which employment sectors have 
    been hit the hardest by the virus, and when the worst months regarding 
    revenue losses and jobless claims were"
    
    paragraph_two <- "Looking at datasets detailing unemployment claims from the
    Department of Labor as well as how unemployment and revenue changes have 
    affected 19 separate employment sectors from the US Census Bureau this 
    webpage will help provide information on the relationship between job 
    sectors and the effect COVID-19 has had on them, the variance within each 
    job sector (as well as across each sector as a result of COVID-19 in 
    specific months), and the relationship of Non Seasonally Adjusted (NSA) 
    unemployment claims per week filed in the United States since the beginning 
    of the pandemic."
    
    HTML(paste(paragraph_one, paragraph_two, sep = "<br/><br/>"))
  })
  
  output$sector_text <- renderText({
    sector_message <- "We provided this graph to examine which work sectors
    were hit the hardest by the COVID-19 pandemic. You can choose however many
    work sectors you want to look at from the provided list and note the 
    differences among them."
    
    sector_message
  })
  

  output$conclusion_text <- renderUI({
    intro_message <- "From the information provided in our webpage, it is
    clear that the COVID-19 pandemic has had a significant effect on businesses
    in America." 
    
    first_takeway <- "We examined the impact on individual job sectors and found
    that the Management sector was most affected by COVID-19 on an average 
    weekly percent."
    
    second_takeway <- "We also saw that the Utilities sector had the highest 
    variance in data from the US Census Bureau dataset."
      
    third_takeway <- "Finally, we were able to determine that the unemployement
    claims per week in America in 2020 peaked in March and has been slowly 
    dropping since then."
    
    outro_message <- "In the Overview page we talked about how we wanted to see
    which employement sectors had been hit hardest by the virus and what months
    were the worst in terms of lost revenue and jobs. From our analysis, we can
    see that the Management sector was hit the hardest, and March 2020 was the
    worst month for unemployement and lost revenue."
      
    HTML(paste(intro_message, first_takeway, second_takeway, third_takeway,
               outro_message, sep = "<br/><br/>"))
  })
  
  ## Render unemployment scatterplot ##
  output$unemployment_plot <- renderPlotly({
    unemployment_plot <- ggplot(data = unemployment,
      aes_string(x = "Date", y = input$claim_input, group = 1)) +
      geom_line(color = "#CB4335") +
      geom_point(color = "#CB4335") +
      labs(title = "US Unemployment Claims Per Week",
        x = "Date",
        y = names(readable_names[which(readable_names == input$claim_input)]))
             
    unemployment_plot <- ggplotly(unemployment_plot)
  })
  
  ## Render COVID plot ##
  output$covid_plot <- renderPlotly({
    covid_plot <- ggplot(data = national,
      aes_string(x = "date", y = input$covid_input, group = 1)) +
      geom_line(color = "#CB4335") +
      labs(title = "US Coronavirus Figures",
           x = "Date",
           y = names(covid_names[which(covid_names == input$covid_input)]))
    
    covid_plot <- ggplotly(covid_plot)
  })
  
  ## Render paragraph explaining unemployment graph purpose ##
  output$unemployment_text <- renderText({
    nsa_comp <- "The Non-seasonal factors - or essentially the \"raw\" 
    unemployment data shows how the beginning of the pandemic (correlative to 
    the first \"spike\" in US cases) was particularly brutal for US unemployment
    filings, peaking at 6.2 million on April 4th. When the raw data is adjusted
    by seasonal factors (to give us the Seasonally Adjusted Filings), the peak
    shifts to the week of May 28th, immediately prior the April 4th peak of the
    NSA filings."
    
    nsa_comp
  })
  
  ## Paragraph explaining covid graph purpose ##
  output$covid_text <- renderText({
    covid_comp <- "A testimate to a collosal failure of leadership, the US 
    coronavirus case numbers reflect the disregard for human life and a lack of 
    mitigation efforts by our federal government. The reason for the 
    near-immediate decline in unemployment filings was due to congressional 
    stimulus and deficit spending. But the pros of Keynesian Economics is for a
    different presentation."
    
    covid_comp
  })
}
