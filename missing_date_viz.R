

library(tidyverse)
library(lubridate)
library(ggplot2)

path <- '/home/shares/soilcarbon/Twitter' # LOCATION OF MASTER FILES

twitter_merged <- read.csv(file.path(path, 'Merged_v2/twitter_merged_v2.csv'), stringsAsFactors = FALSE) 
#twitter_merged_noRT <- read.csv(file.path(path, 'Merged_v2/twitter_merged_noRT_v2.csv'), stringsAsFactors = FALSE) 

RT_df <- twitter_merged %>% 
  mutate(created_at = ymd_hms(created_at)) %>% 
  mutate(created_at = round_date(created_at, unit = "day")) %>% 
  distinct(created_at, .keep_all = TRUE) %>% 
  select(created_at) %>% 
  mutate(created_at = ymd(created_at))

RT_dates_viz <- ggplot(RT_df, aes(x = created_at)) +
  geom_bar(stat = 'count') +
  scale_x_date(date_breaks = "1 month", date_labels = "%y %b") +
  theme_classic()
