install.packages("tidyverse")
install.packages("readr")
install.packages("janitor")
install.packages("ggplot2")
install.packages("skimr")
library(tidyverse)
library(readr)
library(janitor)
library(ggplot2)
library(lubridate)
library(skimr)

##load up all the different files
q1<-read_csv("Desktop/Divvy_Trips_2020_Q1.csv")
apr<-read_csv("Desktop/202004-divvy-tripdata.csv")
may<-read_csv("Desktop/202005-divvy-tripdata.csv")
jun<-read_csv("Desktop/202006-divvy-tripdata.csv")
jul<-read_csv("Desktop/202007-divvy-tripdata.csv")
aug<-read_csv("Desktop/202008-divvy-tripdata.csv")
sep<-read_csv("Desktop/202009-divvy-tripdata.csv")
oct<-read_csv("Desktop/202010-divvy-tripdata.csv")
nov<-read_csv("Desktop/202011-divvy-tripdata.csv")
dec<-read_csv("Desktop/202012-divvy-tripdata.csv")
##combines the data together through rbind
Cyclistic_rides<-rbind(q1,apr,may,jun,jul,aug,sep,oct,nov,dec)
Cyclistic_rides<-remove_empty(Cyclistic_rides,which =c("rows")) ##removes empty rows
Cyclistic_rides<-remove_empty(Cyclistic_rides,which =c("cols")) ##removes empty columns

##POSIXct is the time
##This converts the character data in the df into a date format
Cycilstic_rides_started_at<-ymd_hms(Cyclistic_rides$started_at) ##changes the column to ymd_hms
Cyclistic_rides_ended_at<-ymd_hms(Cyclistic_rides$ended_at) ##changes the column to ymd_hms
Cyclistic_rides$Ymd<-as.Date(Cyclistic_rides$started_at) ##prints it in the format YYYY-MM-DD

##this converts the column into hours from 0-24
Cyclistic_rides$start_time<-hour(Cyclistic_rides$started_at)
Cyclistic_rides$end_time<-hour(Cyclistic_rides$ended_at)

##need $ to extract hours and minutes that we already changed into a date function
Cyclistic_rides$hour<-difftime(Cyclistic_rides$ended_at,Cyclistic_rides$started_at,units="hour")
Cyclistic_rides$minutes<-difftime(Cyclistic_rides$ended_at,Cyclistic_rides$started_at,units="min")

Cyclistic_ride_length<-Cyclistic_rides %>% 
  filter(ride_length_min>0) %>% 
  drop_na()

Cyclistic_rides3<-Cyclistic_rides %>% 
  group_by(ymd,start_time,member_casual) %>%
  summarise(
    Average =mean(minutes),
    Median =median(minutes),
    Total= sum(minutes)
  )
  

getwd()

write.csv(Cyclistic_rides3,"/Users/briansam/Desktop/Data analysis/",row.names = FALSE)



