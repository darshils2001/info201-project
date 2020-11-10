# Load Packages
library("readxl")
library("ggplot2")
library("tidyverse")

# Load Dataset
sectors <- read_excel("/Users/Darshil/Documents/INFO201/info201-project/datasets/National_Sector_Dataset.xls")

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

# Filter to 5 randomly selected sectors
random_sectors <- sectors %>%
  filter(NAICS_SECTOR == "Health Care" | NAICS_SECTOR == "Arts" |
    NAICS_SECTOR == "Management" | NAICS_SECTOR == "Utilities" |
    NAICS_SECTOR == "Other Services")

# Find average % in each sector
random_sectors$ESTIMATE_PERCENTAGE <- as.numeric(
  gsub("[\\%,]", "", random_sectors$ESTIMATE_PERCENTAGE)
)

average_random_sectors <- random_sectors %>%
  group_by(NAICS_SECTOR) %>%
  summarize(
    AVERAGE_PERCENT = mean(ESTIMATE_PERCENTAGE)
  )

# Create Bar Chart
ggplot(data = average_random_sectors) +
  geom_col(
    mapping = aes(x = NAICS_SECTOR, y = AVERAGE_PERCENT),
    fill = "#FF6666"
  ) +
  labs(
    title = "Work Sector versus Percent of Businesses Affected by
             COVID-19",
    x = "Work Sector",
    y = "Percentage of Businesses Affected"
  )
