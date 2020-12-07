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

#Load DoL Unemployment dataset
unemployment <- read_csv("datasets/DoL_Unemployment.csv") %>% 
  rename(Date = X1) %>% 
  mutate(Date = as.Date(Date, format = "%m/%d/%Y"))

#Load COVID-19 Cases dataset
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")



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
  
  
  # Render unemployment scatterplot
  output$unemployment_plot <- renderPlot({
    ggplot(data = unemployment,
           aes_string(x = "Date", y = "N.S.A", group = 1)) +
      geom_line() +
      geom_point()
  })
}
