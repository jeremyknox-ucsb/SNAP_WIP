# testing duplicates

library(tidyverse)
library(lubridate)


path <- '/home/knox/github/soc-twitter/Merged_v2/'
old_twitter_merged <- read.csv(file.path(path, 'twitter_merged_v2.csv'), stringsAsFactors = FALSE) 

old_df <- old_twitter_merged %>% 
  mutate(created_at = ymd_hms(created_at)) %>% 
  filter(created_at >= '2019-08-19 00:00:00' & created_at  <= '2019-08-20 05:50:25')

path <- '/home/shares/soilcarbon/Twitter/Merged_v2'
twitter_merged <- read.csv(file.path(path, 'twitter_merged_v2.csv'), stringsAsFactors = FALSE)

new_df <- twitter_merged %>% 
  mutate(created_at = ymd_hms(created_at)) %>% 
  filter(created_at >= '2019-08-19 00:00:00' & created_at  <= '2019-08-20 05:50:25')
