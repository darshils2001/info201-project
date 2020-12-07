#Load packages
library("tidyverse")

#Load dataset
unemployment <- read_csv("datasets/DoL_Unemployment.csv")

#Load COVID-19 Cases dataset
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")

#Take Non Seasonal Adjusted (NSA) Initial Unemployment claims and date since
#January 4th, 2020 and rename
non_seasonal_adjusted <- unemployment %>%
  rename(Date = X1) %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y")) %>% 
  select(Date, N.S.A)

#Clean national dataset
cases_per_day <- national %>% 
  select(date, cases) %>% 
  mutate(date = as.Date(date, format = "%Y-%m-%d")) %>% 
  mutate(new_cases = cases - lag(cases, default = 0))

#Build scatterplot of unemployment claims per week
unemployment_plot <- ggplot(data = non_seasonal_adjusted,
                            aes(x = Date, y = N.S.A, group = 1)) +
  geom_line() +
  geom_point() +
  labs(title = "Initial Unemployment Claims Per Week",
       x = "Date",
       y = "NSA Unemployment Claims")

unemployment_plot

#Test plot for covid cases
covid_cases <- ggplot() + 
  geom_line(data = cases_per_day, aes(x = date, y = new_cases), color = "Red")



covid_cases
