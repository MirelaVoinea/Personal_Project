# Cyclistic Case Study

<h3>Introduction</h3>

I am doing this case study to put to practice my new knowledge I've learned in Google Data Analysis Certificate Program. In this case study I will use two data analysis tools: SQL and Tableau.

This case study is about Cyclistic, a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use the bikes to commute to work each day.


<h4>Scenario</h4>

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

Customers who purchase single-ride or full-day passes are referred to as casual riders.
Customers who purchase annual memberships are Cyclistic members.

<h4>Stakeholders and Team</h4>

-Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
-Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.
-Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals—as well as how you, as a junior data analyst, can help Cyclistic achieve them.

I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share and Act in order to answer the business questions.

<h3>1. ASK</h3>

At this level I need to identify the business task, so I ask myself what my stakeholders saying their problems are and how can I help them resolve their questions. 
These are the three questions which will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

<h3>2. PREPARE</h3>

<h4>Data Source</h4>
I will use Cyclicstic's historical trip data from the previous 12 months to analyze and identify trends. The data has been made available by Motivate International Inc.
The data has been downloaded from [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) and stored in a folder into my computer using proper naming conventions.

<h4>Data organization</h4>
There are 12 CSV files, every file representing a month of historical trip data, from January 2023 to December 2023.
Each CSV file organizes its data into 13 columns. Each column is named using proper naming conventions: 
"ride_id" - string format, unique identifier for each ride
"rideable_type" - string format, there are 3 types of bikes: electric, classic or docked
"started_at" - date format, date and hour when the ride started
"ended_at" -date format, date and hour when the ride ended
"start_station_name" - string format, name of the station where ride started
"start_station_id" - string format, ID of the station where ride started
"end_station_name" - string format, name of the station where ride ended
"end_station_id" - string format, ID of the station where ride ended
"start_lat" - float format, latitude where ride started
"start_lng" - float format, longitude where ride started
"end_lat" - float format, latitude where ride ended
"end_lng" - float format, longitude where ride ended
"member_casual" - string format, the type for each membership (it can be member or casual)

<h4>ROCCC analysis</h4>
Realiable- yes, it is unbiased
Original- yes, validated with the original source
Comprehensive- yes, it contain all the data I need to answer the stakeholders questions
Current- yes, it is updated monthly
Cited- yes
There are no issues with bias or credibility in this data, because this is a public dataset especially created to be used in a case study.

I imported the CSV files into Microsoft SQL Server.
Using SQL function UNION I combined the 12 tables I've just imported into a new table, resulting in over 5 million rows (5719877 rows). 

<h3>3. PROCESS</h3>

At this phase of the analysis I will transform, clean the data and check for possible errors, inaccuracies, nulls, and duplicates.
The tool I will be using for this step is SQL, through Microsoft SQL Server software.

Firstly we create a staging table, so I don't modify the original raw table.

1.Remove duplicates
2.Standardize the data
3.Null or blank values
4.Remove rides with negative trip length values

<h3>4. ANALYZE</h3>

In this phase of the analysis process I will 

1. Peoples favorite bike type
2.1. Average of trip length for every member type
2.2. Max of trip lengths for every member type
2.3. Min of trip lengths for every member type
3. Total number of trips longer than 24h
4. Number of trips longer than 1 day per member type and bike type
5. Average trip length in minutes for each day of the week by member type
6. Average trip length in minutes per month for each member type
7. Number of trips per hour, weekday, month by each member types
8. Percent of member riders and casual riders
9. Bike type count per user type
10. Top 10 most popular starting stations
11. Top 10 most popular ending stations

<h3>5. SHARE</h3>


<h3>6. ACT</h3>


![image](https://github.com/MirelaVoinea/Personal_Project/assets/171570001/b986ed71-0697-49ae-9a86-53ee3b020b0b)


