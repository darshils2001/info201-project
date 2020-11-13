# Load Packages
library("readxl")
library("tidyverse")

# Load Dataset
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

# Convert Percentage to Numerical Value
sectors$ESTIMATE_PERCENTAGE <- as.numeric(
  gsub("[\\%,]", "", sectors$ESTIMATE_PERCENTAGE)
)

# Convert SE to Numerical Value
sectors$SE <- as.numeric(
  gsub("[\\%,]", "", sectors$SE)
)

summary_info <- list()

# Num of Sectors in Dataset
summary_info$num_sectors <- unique(sectors$NAICS_SECTOR)

# Highest estimated percentage of businesses within a sector being affected by
# COVID-19 in a week
summary_info$highest_percentage <- max(sectors$ESTIMATE_PERCENTAGE)

# Smallest estimated percentage of businesses within a sector being affected by
# COVID-19 in a week
summary_info$smallest_percentage <- min(sectors$ESTIMATE_PERCENTAGE)

# Highest standard error for a report of businesses in a sector, within a week
summary_info$highest_standard_error <- max(sectors$SE)

# Number of weekly reports for the Information Sector
summary_info$num_information_sector <- nrow(sectors %>%
  filter(NAICS_SECTOR == "Information"))
