#Install packages
install.packages("ggplot2")

#Load packages
library("tidyverse")
library("ggplot2")
library("dplyr")
library("tidyr")

#Load dataset
sectors <- read.csv("https://raw.githubusercontent.com/darshils2001/info201-project/main/datasets/National_Sector_Dataset.csv")

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

#Convert EST PERCENTAGE from character to numeric type 
sectors$ESTIMATE_PERCENTAGE <- as.numeric(
  gsub("[\\%,]", "", sectors$ESTIMATE_PERCENTAGE)
)

#Caculate average percentage changes across all sectors
avg <- mean(sectors$ESTIMATE_PERCENTAGE)

#Calculate average percentages in each sector
avg_sectors <- sectors %>%
  group_by(NAICS_SECTOR) %>%
  summarize(AVERAGE_CHANGES_IN_PERCENTAGE = mean(ESTIMATE_PERCENTAGE))

#Build a combination of a line and bar chart to compare each sector with the
#average of all sector
avg_plot <- ggplot(data = avg_sectors) +
  geom_col(
    mapping = aes(x = NAICS_SECTOR, 
                   y = avg_sectors$AVERAGE_CHANGES_IN_PERCENTAGE)
    ) +
  labs(title = "Average Revenue Changes in Each Sector 
       for the Week of October 04 2020",
       x = "Sector",
       y = "Average Percent of Businesses Affected") +
  geom_hline(yintercept = avg, linetype="dashed", color = "red")
