# Coding in R
# Final Project

# Loading necessary paclages to R
install.packages("dplyr")
library(dplyr)

install.packages("tidyverse")
library(tidyverse)

# Loading the Covid 19 global data 
covid_19_data <- read.csv("WHO-COVID-19-global-data.csv")

# Checking for NA values in the entire dataframe
na_summary <- sapply(covid_19_data, function(col) sum(is.na(col)))

# Display the summary of NA values
print(na_summary) # No NA values were found to disrupt data 

# Case Counts
# Selecting the important columns for Covid 19 case count 
covid_19_data_cases <- covid_19_data %>%
  select(Date_reported, Country_code, Country, New_cases, Cumulative_cases)

# Keeping latest data regarding cumulative cases from each Country for the year 2022 (December.31.2022)
covid_19_data_latest_cases <- covid_19_data %>%
  select(Date_reported, Country_code, Country, Cumulative_cases)

covid_19_data_latest_cases <- covid_19_data_latest_cases %>%
  filter(Date_reported == "2022-12-31")

# Death Counts
# Selecting the important columns for Covid 19 death count 
covid_19_data_deaths <- covid_19_data %>%
  select(Date_reported, Country_code, Country, New_deaths, Cumulative_deaths)

# Keeping latest data regarding cumulative deaths from each Country for the year 2022 (December.31.2022)
covid_19_data_latest_deaths <- covid_19_data %>%
  select(Date_reported, Country_code, Country, Cumulative_deaths)

covid_19_data_latest_deaths <- covid_19_data_latest_deaths %>%
  filter(Date_reported == "2022-12-31")

# Loading the necessary packages for API search
install.packages("wbstats")
library(wbstats)

# Viewing the data set generated from the wbstats package regarding Country information
  # We can view the average income per Country by looking at the "country" column and the "income_level" column.
View(wb_countries())

# Viewing the GDP data for each Country 
df_gdp <- wb_data("NY.GDP.MKTP.CD")

filtered_df_gdp <- df_gdp %>%
  filter(date %in% c(2020, 2021, 2022))

# Viewing the unemployment levels per Country
  # Looking at "Educational attainment, at least completed short-cycle tertiary, population 25+, total (%) (cumulative)" criteria within the dataset
df_unemployment <- wb_data("SL.UEM.TOTL.ZS")
View(df_unemployment)

filtered_df_unemployment <- df_unemployment %>%
  filter(date %in% c(2022))

# Viewing the population data for each Country 
df_population <- wb_data("SP.POP.TOTL")

filtered_df_population <- df_population %>%
  filter(date %in% c(2022))

# Calculations 
# Calculating Prevalence (Confirmed cases by Population)
  # Looking at the "covid_19_data_latest_cases" data frame and "filtered_df_population"data frame

# Case Fatality Rate (Deaths per Infected Population)
# Selecting the important columns for Covid 19 Population Count 
covid_19_data_cases_fatality <- covid_19_data %>%
  select(Date_reported, Country_code, Country, Cumulative_cases, Cumulative_deaths)

covid_19_data_cases_fatality <- covid_19_data_cases_fatality %>%
  filter(Date_reported == "2022-12-31")

covid_19_data_cases_fatality <- covid_19_data_cases_fatality %>%
  mutate(Case_Fatality_Rate = Cumulative_deaths / Cumulative_cases)

View(covid_19_data_cases_fatality)

# Mortality Rate (Deaths per Total Population)
# Looking at the "covid_19_data_latest_deaths" data frame and "filtered_df_population"data frame

### Case fatality by Unemployment Rate

```{r}

unemployment_22 <- df_unemployment %>% 
  filter(date == 2022)
View(unemployment_22)

unemployment_22 <- unemployment_22 %>%
  rename(Country = country)

merge_unemployment_cfr <- merge(unemployment_22, covid_19_data_cases_fatality, by = "Country", all.x = TRUE)

View(merge_unemployment_cfr)

library(ggplot2)

ggplot(merge_unemployment_cfr, aes(x= SL.UEM.TOTL.ZS, y = log(Case_Fatality_Rate))) +
  geom_point() +
  labs(title = "Case Fatality Rate according to Unemployment Rate",
       x = "Unemployment Rate",
       Y = "Case Fatality Rate") + 
  scale_x_continuous(limits = c(min(merge_unemployment_cfr$SL.UEM.TOTL.ZS), max(merge_unemployment_cfr$SL.UEM.TOTL.ZS)))

```
