
#Load packages
library("tidyverse")

#Load dataset
unemployment <- read_csv("datasets/DoL_Unemployment.csv")

#Load COVID-19 Cases dataset
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")

#Take Non Seasonal Adjusted (NSA) Initial Unemployment claims and date since
#January 4th, 2020 and rename Date column
non_seasonal_adjusted <- unemployment %>%
  rename(Date = X1) %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y")) %>% 
  select(Date, N.S.A)

#Build scatterplot of unemployment claims per week
unemployment_plot <- ggplot(data = non_seasonal_adjusted,
                            aes(x = Date, y = N.S.A, group = 1)) +
  geom_line() +
  geom_point() +
  labs(title = "Initial Unemployment Claims Per Week",
       x = "Date",
       y = "NSA Unemployment Claims")