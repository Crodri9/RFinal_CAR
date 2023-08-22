# Coding in R
# Final Project

# Loading necessary paclages to R
install.packages("dplyr")
library(dplyr)

# Loading the Covid 19 global data 
covid_19_data <- read.csv("WHO-COVID-19-global-data.csv")
View(covid_19_data)

# Checking for NA values in the entire dataframe
na_summary <- sapply(covid_19_data, function(col) sum(is.na(col)))

# Display the summary of NA values
print(na_summary) # No NA values were found to disrupt data 

# Case Counts
# Selecting the important columns for Covid 19 case count 
covid_19_data_cases <- covid_19_data %>%
  select(Date_reported, Country_code, Country, New_cases, Cumulative_cases)
View(covid_19_data_cases)

# Keeping latest data regarding cumulative cases from each Country for the year 2022 (December.31.2022)
covid_19_data_latest_cases <- covid_19_data %>%
  select(Date_reported, Country_code, Country, Cumulative_cases)

covid_19_data_latest_cases <- covid_19_data_latest_cases %>%
  filter(Date_reported == "2022-12-31")
View(covid_19_data_latest_cases)

# Death Counts
# Selecting the important columns for Covid 19 death count 
covid_19_data_deaths <- covid_19_data %>%
  select(Date_reported, Country_code, Country, New_deaths, Cumulative_deaths)
View(covid_19_data_deaths)

# Keeping latest data regarding cumulative deaths from each Country for the year 2022 (December.31.2022)
covid_19_data_latest_deaths <- covid_19_data %>%
  select(Date_reported, Country_code, Country, Cumulative_deaths)

covid_19_data_latest_deaths <- covid_19_data_latest_deaths %>%
  filter(Date_reported == "2022-12-31")
View(covid_19_data_latest_deaths)

# Loading the necessary packages for API search
install.packages("wbstats")
library(wbstats)

# Viewing the data set generated from the wbstats package regarding Country information
View(wb_countries())

# Viewing the GDP data for each Country 
df_gdp <- wb_data("NY.GDP.MKTP.CD")

filtered_df_gdp <- df_gdp %>%
  filter(date %in% c(2020, 2021, 2022))
View(filtered_df_gdp)

# Viewing the population data for each Country 
df_population <- wb_data("SP.POP.TOTL")
View(df_population)

filtered_df_population <- df_population %>%
  filter(date %in% c(2022))
View(filtered_df_population)

