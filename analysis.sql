
-- Query 1
-- Split difference
--This involves calculating the ratio of trips made by members compared to non-members 
SELECT 
      (COUNT(CASE WHEN member_casual="member" THEN 1 END)/COUNT(*))*100 AS members_usage_percentage, 
      (COUNT(CASE WHEN member_casual="casual" THEN 1 END)/COUNT(*))*100 AS casual_usage_percentage    
FROM `capstone-402023.capstone.cleaned_all_months` 


-- Query 2
--Bike type Preference
--Calculates the percentage preference of bike types between members and non-members. 
SELECT 
      member_casual,
      (COUNT(CASE WHEN rideable_type="electric_bike" THEN 1 END)/COUNT(*)) * 100 AS percentage_electric_bike_preference, 
      (COUNT(CASE WHEN rideable_type="classic_bike" THEN 1 END)/COUNT(*)) * 100 AS percentage_classic_bike_preference
FROM `capstone-402023.capstone.cleaned_all_months` 
GROUP BY member_casual
--Query 3
/*Count the number of casual and member users for different hours*/
SELECT 
    EXTRACT(HOUR FROM started_at) AS start_hour, 
    COUNT(CASE WHEN member_casual="member" THEN 1 END) AS members_count,
    COUNT(CASE WHEN member_casual="casual" THEN 1 END) AS casual_rider_count,
FROM `capstone-402023.capstone.cleaned_all_months`
GROUP BY start_hour
ORDER BY start_hour

-- Query 4
  SELECT 
      member_casual, 
      ROUND((COUNT(CASE WHEN rideable_type="electric_bike" THEN 1 END)/COUNT(*))*100,2) AS electric_bike_usage, 
      ROUND((COUNT(CASE WHEN rideable_type="classic_bike" THEN 1 END)/COUNT(*))*100,2) AS classic_bike_usage   
FROM `capstone-402023.capstone.cleaned_all_months` 
GROUP BY member_casual

  
-- Query 4
/*Count the number of casual and member users for different hours*/
SELECT 
    EXTRACT(HOUR FROM started_at) AS start_hour, 
    COUNT(CASE WHEN member_casual= "member"  THEN 1 END) AS members_count,
    COUNT(CASE WHEN member_casual= "casual" THEN 1 END) AS casual_rider_count
FROM `capstone-402023.capstone.cleaned_all_months`
    WHERE rideable_type="electric_bike"
    GROUP BY start_hour
    ORDER BY start_hour

--Query 5 
SELECT 
    EXTRACT(HOUR FROM started_at) AS start_hour, 
    COUNT(CASE WHEN member_casual= "member"  THEN 1 END) AS members_count,
    COUNT(CASE WHEN member_casual= "casual" THEN 1 END) AS casual_rider_count
FROM `capstone-402023.capstone.cleaned_all_months`
    WHERE rideable_type="classic_bike"
    GROUP BY start_hour
    ORDER BY start_hour

--Query 6 
 SELECT EXTRACT(MONTH FROM started_at) AS MONTH, 
COUNT(CASE WHEN member_casual= "member"  THEN 1 END) AS members_count,
COUNT(CASE WHEN member_casual= "casual" THEN 1 END) AS casual_rider_count
FROM `capstone-402023.capstone.cleaned_all_months`
WHERE rideable_type="classic_bike"
GROUP BY MONTH
ORDER BY MONTH

-- Query 7 
SELECT
  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week,
  COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS members_count,
  COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_rider_count
FROM
  `capstone-402023.capstone.cleaned_all_months`
GROUP BY
  day_of_week
ORDER BY
  CASE
    WHEN day_of_week = 'Sunday' THEN 1
    WHEN day_of_week = 'Monday' THEN 2
    WHEN day_of_week = 'Tuesday' THEN 3
    WHEN day_of_week = 'Wednesday' THEN 4
    WHEN day_of_week = 'Thursday' THEN 5
    WHEN day_of_week = 'Friday' THEN 6
    WHEN day_of_week = 'Saturday' THEN 7
  END;

-- Query 8 
SELECT 
EXTRACT(DAY FROM started_at) AS ride_date, 
COUNT(CASE WHEN member_casual="member" THEN 1 END) AS member_rides, COUNT(CASE WHEN member_casual="casual" THEN 1 END) AS casual_rides
FROM `capstone-402023.capstone.cleaned_all_months` 
GROUP BY ride_date
ORDER BY ride_date

-- Query 9 
SELECT member_casual, ROUND(AVG(trip_duration_seconds)/60,1) AS average_trip_duration
FROM `capstone-402023.capstone.cleaned_all_months` 
GROUP BY member_casual

-- Query 10 
SELECT
  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week,
  ROUND(AVG(CASE WHEN member_casual="member" THEN trip_duration_seconds END)/60,1) AS average_member_trip_duration, 
   ROUND(AVG(CASE WHEN member_casual="casual" THEN trip_duration_seconds END)/60,1) AS average_non_member_trip_duration, 
FROM
  `capstone-402023.capstone.cleaned_all_months`
GROUP BY
  day_of_week
ORDER BY
  CASE
    WHEN day_of_week = 'Sunday' THEN 1
    WHEN day_of_week = 'Monday' THEN 2
    WHEN day_of_week = 'Tuesday' THEN 3
    WHEN day_of_week = 'Wednesday' THEN 4
    WHEN day_of_week = 'Thursday' THEN 5
    WHEN day_of_week = 'Friday' THEN 6
    WHEN day_of_week = 'Saturday' THEN 7
  END;
  -- Query 11 
SELECT
  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week,
  ROUND(AVG(CASE WHEN member_casual="member" THEN trip_duration_seconds END)/60,1) AS average_member_trip_duration, 
   ROUND(AVG(CASE WHEN member_casual="casual" THEN trip_duration_seconds END)/60,1) AS average_non_member_trip_duration, 
FROM
  `capstone-402023.capstone.cleaned_all_months`
GROUP BY
  day_of_week
ORDER BY
  CASE
    WHEN day_of_week = 'Sunday' THEN 1
    WHEN day_of_week = 'Monday' THEN 2
    WHEN day_of_week = 'Tuesday' THEN 3
    WHEN day_of_week = 'Wednesday' THEN 4
    WHEN day_of_week = 'Thursday' THEN 5
    WHEN day_of_week = 'Friday' THEN 6
    WHEN day_of_week = 'Saturday' THEN 7
  END;
  

-- Query 12 
SELECT
  CASE
    WHEN EXTRACT(DAYOFWEEK FROM DATE(started_at)) IN (1, 7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_category,
  ROUND(AVG(trip_duration_seconds) / 60, 1) AS average_trip_duration
FROM
  `capstone-402023.capstone.cleaned_all_months`
GROUP BY
  day_category
ORDER BY
  CASE
    WHEN day_category = 'Weekday' THEN 1
    WHEN day_category = 'Weekend' THEN 2
  END;

-- Query 13
SELECT
EXTRACT(MONTH FROM started_at) AS MONTH, 
  ROUND(AVG(CASE WHEN member_casual= "member" THEN trip_duration_seconds END)/60, 1) AS member_average_trip_duration,
  ROUND(AVG(CASE WHEN member_casual= "casual" THEN trip_duration_seconds END)/60, 1) AS non_member_average_trip_duration
FROM
  `capstone-402023.capstone.cleaned_all_months`
GROUP BY
  MONTH
ORDER BY
  MONTH


-- Query 14
-- TOP start_stations for members 
SELECT 
start_station_name AS top_start_stations_for_members
FROM
  `capstone-402023.capstone.cleaned_all_months`
  WHERE member_casual="member" AND start_station_name!="undocked"
  GROUP BY member_casual, start_station_name
  ORDER BY COUNT(*) DESC
LIMIT 5

-- Query 15
-- TOP start_stations for non-members 
SELECT 
start_station_name AS top_start_stations_for_members
FROM
  `capstone-402023.capstone.cleaned_all_months`
  WHERE member_casual="casual" AND start_station_name!="undocked"
  GROUP BY member_casual, start_station_name
  ORDER BY COUNT(*) DESC
LIMIT 5






