# ---Getting Set Up---


# Loading in packages
library(tidyverse) 
library(lubridate) 
library(ggplot2) 
library(hms) 
library(readxl) 


# Importing the data and assigning each to a data frame
jan_2022 <- read_excel("Manipulated Data/202201-divvy-tripdata.xlsx", sheet = 1)
feb_2022 <- read_excel("Manipulated Data/202202-divvy-tripdata.xlsx", sheet = 1)
mar_2022 <- read_excel("Manipulated Data/202203-divvy-tripdata.xlsx", sheet = 1)
apr_2022 <- read_excel("Manipulated Data/202204-divvy-tripdata.xlsx", sheet = 1)
may_2022 <- read_excel("Manipulated Data/202205-divvy-tripdata.xlsx", sheet = 1)
jun_2022 <- read_excel("Manipulated Data/202206-divvy-tripdata.xlsx", sheet = 1)
jul_2022 <- read_excel("Manipulated Data/202207-divvy-tripdata.xlsx", sheet = 1)
aug_2022 <- read_excel("Manipulated Data/202208-divvy-tripdata.xlsx", sheet = 1)
sep_2022 <- read_excel("Manipulated Data/202209-divvy-tripdata.xlsx", sheet = 1)
oct_2022 <- read_excel("Manipulated Data/202210-divvy-tripdata.xlsx", sheet = 1)
nov_2022 <- read_excel("Manipulated Data/202211-divvy-tripdata.xlsx", sheet = 1)
dec_2022 <- read_excel("Manipulated Data/202212-divvy-tripdata.xlsx", sheet = 1)


# Displaying column names
colnames(jan_2022)
colnames(feb_2022)
colnames(mar_2022)
colnames(apr_2022)
colnames(may_2022)
colnames(jun_2022)
colnames(jul_2022)
colnames(aug_2022)
colnames(sep_2022)
colnames(oct_2022)
colnames(nov_2022)
colnames(dec_2022)


# Making the 'end_station_id' columns have a consistent class across the data 
# frames
jan_2022$end_station_id <- as.character(jan_2022$end_station_id)
sep_2022$end_station_id <- as.character(sep_2022$end_station_id)


# Merging the 12 data frames
total_trips_df <- bind_rows(jan_2022, feb_2022, mar_2022, apr_2022, may_2022, 
                    jun_2022, jul_2022, aug_2022, sep_2022, oct_2022, nov_2022, 
                    dec_2022)


# Assigning a new name to the data frame to ensure the original stays unchanged
total_trips <- total_trips_df


# Removing the 12 individual data frames and the 'total_trips_df' data frame to 
# clear up space in my Environment
remove(jan_2022, feb_2022, mar_2022, apr_2022, may_2022, jun_2022, jul_2022, 
       aug_2022, sep_2022, oct_2022, nov_2022, dec_2022)
remove(total_trips_df)


# Examining the new combined data frame
colnames(total_trips)
nrow(total_trips)
dim(total_trips)
head(total_trips)
tail(total_trips)
str(total_trips)
summary(total_trips)


# ---Data Manipulation---


# Creating new columns
total_trips$date <- as.Date(total_trips$started_at)
total_trips$month <- format(as.Date(total_trips$date), "%m")
total_trips$day <- format(as.Date(total_trips$date), "%d")
total_trips$year <- format(as.Date(total_trips$date), "%Y")
total_trips$day_of_week2 <- format(as.Date(total_trips$date), "%A")

# As part of the Google Data Analytics roadmap, it had me add in the 
# day_of_week column for each file using Excel. The output is a number which 
# corresponds to a day of the week, however, I prefer the R format of using the 
# actual day. So I will be deleting the original day_of_week column and 
# renaming the day_of_week2 to day_of_week.I also removed the original 
# ride_length because in Excel I formatted the data as time only in the 
# HH:MM:SS format; however, when I uploaded it in R, it showed the difference 
# in date and time (for example: it showed 1899-12-31 00:02:57 instead of 
# 00:02:57 because it subtracted the date as well as the time).


# Removing the original 'day_of_week' and 'ride_length'
cyclistic_data <- subset(total_trips, select = -c(day_of_week, ride_length))


# Removing 'total_trips' data frame
remove(total_trips)


# Changing the column name from 'day_of_week2' to 'day_of_week'
colnames(cyclistic_data)[colnames(cyclistic_data) == "day_of_week2"] = 
                                                    "day_of_week"


# Calculating the ride length by subtracting the 'ended_at' time from the 
# 'started_at' time and converting it into minutes
cyclistic_data$ride_length <- difftime(cyclistic_data$ended_at, 
                                       cyclistic_data$started_at, units = 'mins') 
cyclistic_data$ride_length <- round(cyclistic_data$ride_length, digits = 1)


# Creating new columns pt 2
cyclistic_data$start_time <- format(as.Date(cyclistic_data$date), "%H:%M:%S")
cyclistic_data$start_time <- as_hms((cyclistic_data$started_at))
cyclistic_data$hour_trip_started <- hour(cyclistic_data$start_time)
cyclistic_data$hour_trip_ended <- hour(cyclistic_data$ended_at)


# ---Cleaning the Data---


# Removing duplicate rows
cyclistic_data <- distinct(cyclistic_data)


# Checking for missing values and removing those rows
sum(is.na(cyclistic_data))
cyclistic_data <- na.omit(cyclistic_data)


# removing rows were the ride_length is <= 0
cyclistic_data <- cyclistic_data[!cyclistic_data$ride_length <=0,]


# Removing unnecessary rows
cdata <- subset(cyclistic_data, select = -c(ride_id, start_lat, start_lng, 
                                            end_lat, end_lng))


# ---Summary Statistics---


# Finding mean and median 'ride_length'
mean(cdata$ride_length, units = 'mins')
median(cdata$ride_length, units = 'mins')


# Finding the longest and shortest ride 
max(cdata$ride_length)
which(cdata$ride_length == 34354.1, arr.ind =TRUE) # I found an odd data point, 
# and went to investigate it. Please see my analysis for further explanation.
show(cdata[232036,])
min(cdata$ride_length)


# Comparing the ride length of casual users to annual members
aggregate(cdata$ride_length ~ cdata$member_casual, FUN = mean)
aggregate(cdata$ride_length ~ cdata$member_casual, FUN = median)
aggregate(cdata$ride_length ~ cdata$member_casual, FUN = max)
aggregate(cdata$ride_length ~ cdata$member_casual, FUN = min)


# Investigating the number of people who kept the bikes for over 24 hours
sum(cdata$member_casual == 'casual' & cdata$ride_length >= 1440)
sum(cdata$member_casual == 'member' & cdata$ride_length >= 1440)


# Comparing annual members and casual riders in type of bike used
sum(cdata$member_casual == 'casual' & cdata$rideable_type == "classic_bike")
sum(cdata$member_casual == 'casual' & cdata$rideable_type == "docked_bike")
sum(cdata$member_casual == 'casual' & cdata$rideable_type == "electric_bike")

sum(cdata$member_casual == 'member' & cdata$rideable_type == "classic_bike")
sum(cdata$member_casual == 'member' & cdata$rideable_type == "docked_bike")
sum(cdata$member_casual == 'member' & cdata$rideable_type == "electric_bike")


# Average ride length for each day and member type
aggregate(cdata$ride_length ~ cdata$member_casual + cdata$day_of_week, FUN = mean)


# Total number of casual users and annual members
cdata %>%
  group_by(member_casual) %>%
  count(member_casual)


# Calculating the number of rides and the average ride length for each day and
# member type
cdata %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) 


# Total number of rows
nrow(cdata)


# Total number of trips per hour started
cdata %>%
  count(hour_trip_started) %>% 
  print(n = 24)


# Average start and end time by day and member type
cdata %>%
  group_by(member_casual, day) %>%
  summarise(average_start_hour = mean(hour_trip_started), average_end_hour = 
              mean(hour_trip_ended))


# Data visualization: Average trip length for each day of the week and member type
cdata %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")