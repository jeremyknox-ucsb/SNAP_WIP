# Visualization of 

library(tidyverse)
library(lubridate)
library(ggplot2)

path <- '/home/shares/soilcarbon/Twitter' # LOCATION OF MASTER FILES

twitter_merged <- read.csv(file.path(path, 'Merged_v2/twitter_merged_v2.csv'), stringsAsFactors = FALSE) 
#twitter_merged_noRT <- read.csv(file.path(path, 'Merged_v2/twitter_merged_noRT_v2.csv'), stringsAsFactors = FALSE) 

# DF of days when there are tweets 
RT_unique <- twitter_merged %>% 
  mutate(created_at = ymd_hms(created_at)) %>% 
  mutate(created_at = round_date(created_at, unit = "day")) %>% 
  distinct(created_at, .keep_all = TRUE) %>% 
  select(created_at) %>% 
  mutate(created_at = ymd(created_at))
# plot of missing days (no tweets)
RT_unique_viz <- ggplot(RT_unique, aes(x = created_at)) +
  geom_bar(stat = 'count') +
  scale_x_date(date_breaks = "1 month", date_labels = "%y %b") +
  theme_classic()

# DF of count of tweets per day 
RT_count <- twitter_merged %>% 
  mutate(created_at = ymd_hms(created_at)) %>% 
  mutate(created_at = round_date(created_at, unit = "day")) %>% 
  select(created_at) %>% 
  mutate(created_at = ymd(created_at))
# plot of distibution (histogram) of number of tweets per day 
int <- interval(min(RT_count$created_at), max(RT_count$created_at))
RT_count_viz <- ggplot(RT_count, aes(x = created_at)) +
  geom_histogram(bins = time_length(int, "day")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%y %b") +
  theme_classic()

# DF of count of tweets per day 
RT_count_rm <- twitter_merged %>% 
  mutate(created_at = ymd_hms(created_at)) %>% 
  mutate(created_at = round_date(created_at, unit = "day")) %>%   
  mutate(created_at = ymd(created_at)) %>% 
  filter(created_at != ymd("2018-01-10") &
           created_at != ymd("2017-08-22") &
           created_at != ymd("2019-07-06") &
           created_at != ymd("2019-07-07")) %>% 
  select(created_at)

# plot of distibution (histogram) of number of tweets per day, outliers removed (n > 2,500)
RT_count_viz_rm <- ggplot(RT_count_rm, aes(x = created_at)) +
  geom_histogram(bins = time_length(int, "day")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%y %b") +
  theme_classic()

df = as.data.frame(table(ymd(round_date(ymd_hms(twitter_merged$created_at), unit = "day"))))

df[df$Freq >= 2500,]

pope_francis_RTs = twitter_merged %>% 
  filter(ymd(floor_date(ymd_hms(created_at), unit = "day")) == "2018-01-10")

narendra_modi_RTs = twitter_merged %>% 
  filter(ymd(floor_date(ymd_hms(created_at), unit = "day")) == "2017-08-22")

twittascope_RTs = twitter_merged %>% 
  filter(ymd(floor_date(ymd_hms(created_at), unit = "day")) == "2019-07-06"|
           ymd(floor_date(ymd_hms(created_at), unit = "day")) == "2019-07-07")
