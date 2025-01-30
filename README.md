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
- "rideable_type" - string format, there are 3 types of bikes: electric, classic or docked
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

Most Cyclistic's members preffer classic bikes. Docked bikes are the least used bikes at Cyclistic.

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/4153adb0-f746-42cf-ab22-1236283f1f0a)




2.1. Average of trip length for every member type

Casual members have a considerably higher average trip length than annual members.

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/11581613-949a-462b-ad53-f88cd62e77fb)


2.2. Max of trip lengths for every member type

Casual members have a maximum trip length of 12136 minutes (202 hours), while annual members have a maximum trip length of 1498 minutes (25 hours). 

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/415bcd00-6a9e-4f80-bad6-4faf6d702d7b)


2.3. Min of trip lengths for every member type

Minimum trip length for both member types is 0 minutes, which means the trip can last a few seconds.

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/88ed480b-6cd6-4904-9d95-d0e04ee6e2db)


3. Total number of trips longer than 24h

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/71ab3a00-e020-41de-b216-99ce3385eed9)


4. Number of trips longer than 1 day per member type and bike type

There are zero trips longer than 1 day for electric bikes and annual members who got docked bikes.

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/734fc8db-e306-46cf-8f8f-251a34a72497)


5. Average trip length in minutes for each day of the week by member type

Casual and annual members have a higher average trip length on weekends

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/cdd6cb15-a68a-4440-92ab-04aa0588ed2d)


6. Average trip length in minutes per month for each member type

Both member types preffer to ride bikes on hot season.

For annual members:

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/d4da1601-cd24-4324-95a1-5f51feaf4076)


For casual members:

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/ed9c6917-21de-435c-9a84-6d2f79584441)


7.1 Number of trips per hour by each member types

I copy-pasted the result because it couldn't fit in a screenshot.

- number_trips	hour	member_casual
- 150649	17	casual
- 138641	16	casual
- 126652	18	casual
- 119605	15	casual
- 108312	14	casual
- 104383	13	casual
- 100356	12	casual
- 92713	19	casual
- 85118	11	casual
- 67222	10	casual
- 66291	20	casual
- 54619	21	casual
- 53037	9	casual
- 52971	8	casual
- 48340	22	casual
- 39126	7	casual
- 34773	23	casual
- 25018	0	casual
- 22166	6	casual
- 16066	1	casual
- 9277	2	casual
- 8221	5	casual
- 4705	3	casual
- 3589	4	casual
- 303521	17	member
- 258638	16	member
- 235056	18	member
- 194764	8	member
- 189087	15	member
- 163859	19	member
- 158379	7	member
- 152822	14	member
- 152495	12	member
- 151263	13	member
- 134066	11	member
- 127084	9	member
- 113653	10	member
- 112637	20	member
- 85504	21	member
- 84802	6	member
- 61874	22	member
- 38462	23	member
- 26724	5	member
- 23586	0	member
- 13592	1	member
- 7439	2	member
- 5922	4	member
- 4709	3	member


7.2 Number of trips per weekday by each member types

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/fb9e6592-9a25-47df-9562-a01c559c0af3)

  
7.3 Number of trips per month by each member types

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/8696aa58-419a-4718-a59b-7d37205ddf8d)


8. Percent of member riders and casual riders

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/67956c9b-5590-4df7-a124-d45ef816885e)

   
9. Bike type count per user type

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/876debe3-18bd-46d9-a453-52f410f64a60)


10. Top 10 most popular starting stations

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/c3fe63d8-e348-4120-ab7b-897d411e01af)


11. Top 10 most popular ending stations

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/368c2988-1ab4-4d7f-b953-b9f194fd9b75)



## 5. SHARE

I created a Dashboard using Tableau Public to present my findings through effective data vizualisations.

![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/b986ed71-0697-49ae-9a86-53ee3b020b0b)


### Key findings:

- Annual members represent 64.64% of the total members, while casual members represent 35.36%

- Annual members have an average trip duration nearly half of the casual member's average trip duration.

- Annual members travel more frequently but on shorter distances, while casual members travel less frequently (mostly on weekends) but on longer distances.

- Annual members don't ride docked bikes.

- Annual members prefer riding clasic and electric bikes on workdays, while casual members prefer riding bikes on weekends.

- Both member types enjoy using bikes during the warm season.

- Most annual members ride bikes during peak hours (8 AM and 5 PM), most likely for work/school.

- Most casual members ride bikes in the afternoon, most likely for leisure activities. 



## 6. ACT

Based on my analysis, my final conclusion is that Cyclistic should convert their casual members into annual members by offering them special offers and discounts.

Based on my findings, my recommendations are:

1. Discounts for casual members who have an average trip length of minimum 10 minutes. I would recommend sending them a discount code for buying annual membership through SMS or e-mail.

2. Membership benefits: make contracts with sports shops to offer annual members a discount for every purchase they make.
  
3. Sales representatives at top 10 starting stations where casual riders begin their trips on weekends. The sales representatives should show the casual riders the benefits of having annual membership, and offer them a discount if they buy the annual membershep straight away.

4. Digital media: partnership with influencers to promote the annual memberships.
