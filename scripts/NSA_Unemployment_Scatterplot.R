#Load packages
library("tidyverse")

#Load dataset
unemployment <- read_csv(file = "DoL_Unemployment.csv")

#Take Non Seasonal Adjusted (NSA) Initial Unemployment claims and date since
#January 4th, 2020 and rename
non_seasonal_adjusted <- unemployment %>%
  rename(Date = X1) %>%
  summarise(Date, N.S.A)

#Build a scatterplot, but without connecting line
unemployment_plot <- ggplot(data = Non_Seasonal_Adjusted) +
  geom_point(mapping = aes(x = Date, y = N.S.A)) +
  labs(title = "Initial Unemployment Claims Per Week",
       x = "Date",
       y = "NSA Unemployment Claims")