# Cyclistic Case Study

## Introduction

I am doing this case study to put to practice my new knowledge I've learned in Google Data Analysis Certificate Program. In this case study I will use two data analysis tools: SQL (Bigquery) and Data visualization tool (Looker Studio).

This case study is about Cyclistic, a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use the bikes to commute to work each day.


### Scenario

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

Customers who purchase single-ride or full-day passes are referred to as casual riders.
Customers who purchase annual memberships are Cyclistic members.

### Stakeholders and Team

- Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
- Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.
- Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals—as well as how you, as a junior data analyst, can help Cyclistic achieve them.

I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share and Act in order to answer the business questions.

## 1. ASK

At this level I need to identify the business task, so I ask myself what my stakeholders saying their problems are and how can I help them resolve their questions. 
These are the three questions which will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

## 2. PREPARE

### Data Source
I will use Cyclicstic's historical trip data from the first 4 months of 2024 to analyze and identify trends. The data has been made available by Motivate International Inc.
The data has been downloaded from [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) and stored in a folder into my computer using proper naming conventions.
* The reason why I used only 4 months instead of 12 months is because of Bigquery's storage limitations.

### Data organization
There are 4 CSV files, every file representing a month of historical trip data, from January 2024 to April 2024.
Each CSV file organizes its data into 13 columns. Each column is named using proper naming conventions: 
- "ride_id" - string format, unique identifier for each ride
- "rideable_type" - string format, there are 2 types of bikes: electric and classic
- "started_at" - date format, date and hour when the ride started
- "ended_at" -date format, date and hour when the ride ended
- "start_station_name" - string format, name of the station where ride started
- "start_station_id" - string format, ID of the station where ride started
- "end_station_name" - string format, name of the station where ride ended
- "end_station_id" - string format, ID of the station where ride ended
- "start_lat" - float format, latitude where ride started
- "start_lng" - float format, longitude where ride started
- "end_lat" - float format, latitude where ride ended
- "end_lng" - float format, longitude where ride ended
- "member_casual" - string format, the type for each membership (it can be member or casual)

There are no issues with bias or credibility in this data, because this is a public dataset especially created to be used in a case study.
The data provided is realiable, original and comprehensive.

I imported the CSV files into Bigquery (Google Cloud).
Using SQL function UNION ALL I combined the 4 tables I've just imported into a new table, resulting in over 1 million rows (1.084.749 rows) 

## 3. PROCESS

At this phase of the analysis I will transform, clean the data and check for possible errors, inaccuracies, nulls, and duplicates.
The tool I will be using for this step is SQL, through Bigquery.

Firstly we create a duplicate table, so I don't modify the original raw table.

- Remove duplicates
- Remove rows with null or blank values
- Remove rides with negative trip length values

## 4. ANALYZE

In this phase of the analysis process I will write queries to get insights about Cyclist's annual and casual members.
Firstly I will create 4 additional columns into my new table:
- "start_month" - integer format, month when trip has started, for example month 2 is February
- "time_of_the_day_ride_start"  - string format, time of the day when trip has started, for example morning between hours 05-12
- "day_of_week_ride_start" - string format, name of the weekday when trip has started, for example Monday
- "trip_length_minutes" - integer format, every trip length in minutes, or difference between trip's ending date and trip's starting date


1. People's favorite bike type

![image](https://github.com/user-attachments/assets/c9792c0c-5840-45ef-802c-b1fe58d24bbc)

Most Cyclistic's members preffer classic bikes.


2. Trip information for every member type

![image](https://github.com/user-attachments/assets/a13ce6c3-c457-40d9-9893-eb8a59bc049c)
![image](https://github.com/user-attachments/assets/effed1b7-f4fa-4d01-a124-d18c2bd9e690)

Annual members trips represent aprox. 75% out of total trips.
Average trip length in minutes for casual members is nearly 2x bigger than the average for annual members.
Max trip length for both member types are almos the same.
Total trip length has a share of 60-40 (60% for annual members and 40% for casual members); this means that annual members preffer to have more short trips and casual members preffer to have more long trips (the average value of trip length confirms this).

3. Trips by member type and time of the day

![image](https://github.com/user-attachments/assets/59988084-241a-455e-81d8-b4280da72477)

Both annual and casual member's preffered time of the day to ride is in the afternoon.


4. Trips by member type and day of the week

![image](https://github.com/user-attachments/assets/3fd26f67-7485-4ee0-9dc1-278cd8385c20)

Annual members have most trips during the week, while casual members have the most trips during the week-ends.


3. Total number of trips longer than 1h

![image](https://github.com/user-attachments/assets/bb40459b-4562-4683-863e-130f4768daf3)

Both annual and casual members have the biggest share of trips out of total trips longer than 1 hour during the weekends.
Casual members have aprox. 7 times more trips (longer than 1 hour) than annual members during the weekends. 


4. Total number of trips shorter than 1h

![image](https://github.com/user-attachments/assets/ca1013be-2bf4-4d83-a246-fa9e0d0a017d)

Annual members have a notable bigger share of trips shorter than 1 hour.


5. Average trip lenght in minutes by member type and time of the day

![image](https://github.com/user-attachments/assets/d883dce0-ae35-493d-9a31-805f624f0834)

Annual members have a constant average trip length at any time of the day (~ 11 minutes).
Casual members have a higher average trip length during the afternoon.


5. Average trip length in minutes by member type and day of the week

![image](https://github.com/user-attachments/assets/cc36e3e4-47cd-4c6b-8dc4-79293616994a)

Both member types biggest average trip length by day of the week is during the weekends.


6. Top 10 ending stations for casual members on weekends

![image](https://github.com/user-attachments/assets/9c8cb763-0356-4a1d-9d16-aa758f604522)

I've applied a filter on this chart to include only data for casual members and only for Saturday and Sunday.


## 5. SHARE

I created a Dashboard using Looker Studio to present my findings through effective data vizualisations.
https://lookerstudio.google.com/reporting/da9998cf-8b63-4b0b-94da-013a0a83ee61/page/tEnnC/edit


### Key findings:

- Total trips by annual members represent 74.28% of the total trips, while casual members represent 25.72%.

- Annual members have an average trip duration (~11 minutes) nearly half of the casual member's average trip duration (~22 minutes).

- Annual members travel more frequently but on shorter distances, while casual members travel less frequently (mostly on weekends) but on longer distances.

- Annual members prefer riding bikes during the week, while casual members prefer riding bikes on weekends.

- Both member types preffer to have trips longer than 1 hour during the weekends.

- Casual members have 7x more trips longer than 1 hour during the weekends than annual members have.

- Annual members have more trips shorter than 1 hour than casual members have.

- Most casual members ride bikes in the afternoon, most likely for leisure activities. 



## 6. ACT

Based on my analysis, my final conclusion is that Cyclistic should convert their casual members into annual members by offering them special offers and discounts.

Based on my findings, my recommendations are:

1. Discounts for casual members who have an average trip length of minimum 10 minutes and even a bigger discount for members who have a at least a trip longer than 1 hour. I would recommend sending them a discount code for buying annual membership through SMS or e-mail.

2. Membership benefits: make contracts with sport equipment shops to offer annual members a discount for every purchase they make and use this membership benefit in the marketing program to make casual members buy annual membership.
  
3. Sales representatives at top 10 ending stations where casual riders end their trips on weekends. The sales representatives should show the casual riders the benefits of having annual membership, and offer them a discount if they buy the annual membership straight away.

4. Digital media: partnership with influencers to promote the annual memberships.
