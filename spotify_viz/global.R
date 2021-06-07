library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(shinydashboard)
library(tidyverse)

US_artists_df <- read.csv(file = "./US_artists_above_90.csv", stringsAsFactors = FALSE, row.names = 1)
CA_artists_df <- read.csv(file = "./CA.csv", stringsAsFactors = FALSE, row.names = 1)
CH_artists_df <- read.csv(file = "./CH.csv", stringsAsFactors = FALSE, row.names = 1)
CL_artists_df <- read.csv(file = "./CL.csv", stringsAsFactors = FALSE, row.names = 1)
BI_artists_df <- read.csv(file = "./BI.csv", stringsAsFactors = FALSE, row.names = 1)

# files cleaned in python

# merge markets into one df

temp_path = ".\temp_markets"

for (data in list.files(temp_path)){
  # create first df if no data exists yet
  # make new column for market codes
  if(!exists("all_markets")){
    # get market name
    tmp_code = tools::file_path_sans_ext(data)
    
    all_markets<-read.csv(data, header=TRUE) %>% 
      mutate(market_codes = c(tmp_code))
  }
  
  # if data exists, then append it together
  if(exists("all_markets")){
    # get market name
    new_code = tools::file_path_sans_ext(data)
    new_data <- read.csv(data, header=TRUE) 
    
    # left join and add the new market code to the market code vector
    old_codes = all_markets$market_codes[1]
    temp_left = left_join(all_markets, new_data) %>% 
      mutate(market_codes = c(old_codes, new_code))
    
    # right join and add the new code to the market_codes vector
    temp_right = right_join(all_markets, new_data) %>%
      mutate(market_codes = new_code)
    
    # combine both of these tables vertically
    all_markets <- unique(rbind(temp_left, temp_right))
    
    rm(temp_left)
    rm(temp_right)
  }
}