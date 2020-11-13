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

#Build a box plot to compare variance across the sectors
boxplot(sectors$ESTIMATE_PERCENTAGE~NAICS_SECTOR,
        data=sectors,
        main="Percentage Revenue Changes in Each Sector
        Week of October 04, 2020",
        xlab="Sector",
        ylab="Percent",
        col="orange",       
        border="brown")
