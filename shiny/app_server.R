# Load Packages
library("readxl")
library("ggplot2")
library("tidyverse")
library("shiny")
library("dplyr")
library("plotly")

# Load Datasets
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

my_server <- function(input, output) {
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
        fill = "#FF6666"
      ) +
      labs(
        title = "Work Sector versus Percent of Businesses Affected by COVID-19",
        x = "Work Sector",
        y = "Average Weekly Percent of Businesses Affected"
      )  
    p <- ggplotly(p)
    p
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
}