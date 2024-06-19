
--- I combine the 12 tables I have imported using UNION function

SELECT *
INTO [personalproject].[dbo].[2023-divvy-tripdata-union]
FROM [personalproject].[dbo].[202301_divvy_tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202302-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202303-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202304-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202305-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202306-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202307-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202308-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202309-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202310-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202311-divvy-tripdata]
UNION ALL
SELECT *
FROM [personalproject].[dbo].[202312-divvy-tripdata]



--- I count total number of rows my new table has (5719877 rows)

SELECT count(ride_id)
FROM [personalproject].[dbo].[2023-divvy-tripdata-union]



--- I create an identical table, so I don't modify the raw table

SELECT * INTO [2023-divvy-tripdata-union-staging]
FROM [2023-divvy-tripdata-union]



--- Removing duplicates

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual ORDER BY ride_id) AS row_num
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

--- There are no duplicate rows



--- Standardizing data

UPDATE [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
SET ride_id = TRIM(ride_id)

--- All ride id's have 16 characters

SELECT distinct(len(ride_id))
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]

SELECT distinct(rideable_type)
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]

SELECT distinct(member_casual)
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]

--- There are only 3 rideable types: electric, classic and docked and 2 member types: casual and member (annual)

SELECT distinct(start_station_name)
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
ORDER BY 1



--- Checking rows with null values

SELECT COUNT(*)
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE start_station_name IS NULL

--- There are nulls only in start_station_name, start_station_id, end_station_name, end_station_id, 
--- Deleting rows with nulls

SELECT * 
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE start_station_name IS NULL or start_station_id IS NULL OR end_station_name IS NULL or end_station_id IS NULL

DELETE FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE start_station_name IS NULL or start_station_id IS NULL OR end_station_name IS NULL or end_station_id IS NULL



--- 1. Checking people's favorite bike type

SELECT DISTINCT(rideable_type),
COUNT(rideable_type) AS total_rides
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY rideable_type
ORDER BY rideable_type;
--- Most people preffer classic bikes 



--- I create a new column where I calculate trip length in minutes, and extract weekday and month names from starting date

ALTER TABLE [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
ADD 
	trip_length_minutes INT,
	weekday nvarchar(50),
	month nvarchar(50);
	hour int;


UPDATE [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
SET 
	trip_length_minutes = DATEDIFF(minute, started_at, ended_at),
	weekday = DATENAME (weekday, started_at),
	month = DATENAME (month, started_at),
	hour = DATENAME (hour, started_at);

--- Removing rides with negative trip length values
DELETE
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE trip_length_minutes < 0;



--- 2. Calculating average, longest and shortest trip lengths in minutes by member type

SELECT member_casual, AVG(trip_length_minutes) as avg_trip_length_minutes
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY member_casual
ORDER BY 2;

SELECT member_casual, MAX(trip_length_minutes) as max_trip_length_minutes
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY member_casual
ORDER BY 2;

SELECT member_casual, MIN(trip_length_minutes) as min_trip_length_minutes
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY member_casual
ORDER BY 2;



--- 3. Counting total number of trips which lasted longer than 24 hours (1440 minutes)

SELECT COUNT(*) AS number_trips_longer_than_one_day
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE trip_length_minutes > 1440;



--- 4. Number of trips longer than 1 day per member type and bike type

SELECT COUNT(*) AS number_trips_longer_than_one_day, member_casual, rideable_type
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE trip_length_minutes > 1440
GROUP BY rideable_type, member_casual;

SELECT COUNT(*)
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE trip_length_minutes > 1440 AND rideable_type = 'docked_bike' AND member_casual = 'member'
--- There are zero trips longer than 1 day for annual members who got docked bikes


SELECT COUNT(*) AS number_trips_longer_than_one_day_electric_bikes
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE trip_length_minutes > 1440 AND rideable_type = 'electric_bike';
--- There are zero trips for electric bikes longer than 1 day



--- 5. Average trip length in minutes for each day of the week by member type

SELECT AVG(trip_length_minutes) AS avg_trip_length_minutes, weekday, member_casual
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY weekday, member_casual
ORDER BY 1 desc;


--- 6. Average trip length per month for each member type

SELECT AVG(trip_length_minutes) AS avg_trip_length, month
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE member_casual = 'member'
GROUP BY month
ORDER BY  
	CASE
          WHEN month = 'January' THEN 1
          WHEN month = 'February' THEN 2
          WHEN month = 'March' THEN 3
          WHEN month = 'April' THEN 4
          WHEN month = 'May' THEN 5
          WHEN month = 'June' THEN 6
		  WHEN month = 'July' THEN 7
		  WHEN month = 'August' THEN 8
		  WHEN month = 'September' THEN 9
		  WHEN month = 'October' THEN 10
		  WHEN month = 'November' THEN 11
		  WHEN month = 'December' THEN 12
     END asc;

SELECT AVG(trip_length_minutes) AS avg_trip_length, month
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
WHERE member_casual = 'casual'
GROUP BY month
ORDER BY  
	CASE
          WHEN month = 'January' THEN 1
          WHEN month = 'February' THEN 2
          WHEN month = 'March' THEN 3
          WHEN month = 'April' THEN 4
          WHEN month = 'May' THEN 5
          WHEN month = 'June' THEN 6
		  WHEN month = 'July' THEN 7
		  WHEN month = 'August' THEN 8
		  WHEN month = 'September' THEN 9
		  WHEN month = 'October' THEN 10
		  WHEN month = 'November' THEN 11
		  WHEN month = 'December' THEN 12
     END asc;

--- 7. Number of trips per hour, week, month by each member type

SELECT COUNT(*) AS number_trips, hour, member_casual
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY hour, member_casual
ORDER BY member_casual, number_trips desc;

SELECT COUNT(*) AS number_trips, weekday, member_casual
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY weekday, member_casual
ORDER BY 
	member_casual,
	CASE
          WHEN weekday = 'Monday' THEN 1
          WHEN weekday = 'Tuesday' THEN 2
          WHEN weekday = 'Wednesday' THEN 3
          WHEN weekday = 'Thursday' THEN 4
          WHEN weekday = 'Friday' THEN 5
          WHEN weekday = 'Saturday' THEN 6
		  WHEN weekday = 'Sunday' THEN 7
     END asc;

SELECT COUNT(*) AS number_trips, month, member_casual
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY month, member_casual
ORDER BY 1 desc;



--- 8. Calculating percentage of annual members and casual members from total share of rides

WITH CTE_number_riders AS
(
SELECT 
	(SELECT COUNT(*) AS total_number_riders
		FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]) AS total_number_riders,
	(SELECT COUNT(*) AS total_number_annual_members
		FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
		WHERE member_casual = 'member') AS total_number_annual_members,
	(SELECT COUNT(*) AS total_number_casual_members
		FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
		WHERE member_casual = 'casual') AS total_number_casual_members
)
SELECT 
	total_number_riders, 
	total_number_annual_members, 
	total_number_casual_members,
	(total_number_annual_members*1.0/total_number_riders)*100 AS percentage_annual_members,
	(total_number_casual_members*1.0/total_number_riders)*100 AS percentage_casual_member
FROM CTE_number_riders



--- 9. Bike type count per rider type

SELECT COUNT(rideable_type) AS number_rides_per_bike_type, rideable_type, member_casual
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY member_casual, rideable_type
--- No docked bikes for annual members



--- 10. Checking for the 10 most popular starting stations

SELECT TOP(10) COUNT(start_station_name) AS number_rides, start_station_name
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY start_station_name
ORDER BY 1 desc;



 --- 11. Checking for the 10 most popular ending stations

SELECT TOP(10) COUNT(end_station_name) AS number_rides, end_station_name
FROM [personalproject].[dbo].[2023-divvy-tripdata-union-staging]
GROUP BY end_station_name
ORDER BY 1 desc;


