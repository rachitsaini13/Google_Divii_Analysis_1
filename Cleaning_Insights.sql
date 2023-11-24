-- -- PREPARE PHASE --

-- Check the character length of ride_id
SELECT 
	LENGTH(ride_id)  
	FROM `capstone-402023.capstone.all_months` 
	GROUP BY LENGTH(ride_id)


-- Check the redeable_types values 
SELECT rideable_type  
	FROM `capstone-402023.capstone.all_months` 
	GROUP BY rideable_type

-- Checked the number of start station id - there are 1480 
SELECT start_station_id 
	FROM `capstone-402023.capstone.all_months` 
	GROUP BY start_station_id 

-- Check types of ride 
	SELECT rideable_type  
		FROM `capstone-402023.capstone.all_months` 
		GROUP BY rideable_type


-------------------------------------------
	-------------------------------------------
	-------------------------------------------------------
	------------------------------------------------------------------
	--Cleaning Data

-- checking for duplicates 
-- check if there are any ride_id with count more than 1 
SELECT ride_id, 
       COUNT(*) 
FROM `capstone-402023.capstone.all_months`  
GROUP BY ride_id 
HAVING COUNT(*) >1





-- trimmed leading, ending and in-between whitespaces 

--determine which columns have white spaces 
SELECT 
    COUNT(CASE WHEN (REGEXP_CONTAINS(ride_id, r'\s')) THEN 1 END) AS ride_id_count,
    COUNT(CASE WHEN (REGEXP_CONTAINS(rideable_type, r'\s')) THEN 1 END) AS rideable_type_count,
    COUNT(CASE WHEN (REGEXP_CONTAINS(start_station_name, r'\s')) THEN 1 END) AS start_station_name_count,
    COUNT(CASE WHEN (REGEXP_CONTAINS(start_station_id, r'\s')) THEN 1 END) AS start_station_id_count,
    COUNT(CASE WHEN (REGEXP_CONTAINS(end_station_name, r'\s')) THEN 1 END) AS end_station_name_count,
    COUNT(CASE WHEN (REGEXP_CONTAINS(end_station_id, r'\s')) THEN 1 END) AS end_station_id_count,
    COUNT(CASE WHEN (REGEXP_CONTAINS(member_casual, r'\s')) THEN 1 END) AS member_casual_count
FROM `capstone-402023.capstone.all_months`;

-- removed those whitespaces from required columns
SELECT
    REPLACE(RTRIM(LTRIM(REPLACE(start_station_name, '  ', ' '))), '  ', ' ') AS start_station_name,
    start_station_id,
    REPLACE(RTRIM(LTRIM(REPLACE(end_station_name, '  ', ' '))), '  ', ' ') AS end_station_name,
    end_station_id,
    REPLACE(RTRIM(LTRIM(REPLACE(member_casual, '  ', ' '))), '  ', ' ') AS member_casual
FROM 
    `capstone-402023.capstone.all_months`;
	

-- Tried seeing if there is any pattern to follow from the missing starting and ending location name
        -- Tried to find pattern in longitude and latitude to see any corelation between it and the starting and ending points. 
        -- didnt find anything from this. It was still a little 
                    SELECT start_station_id,  ROUND(start_lat,2), ROUND(start_lng,2)  FROM `capstone-402023.capstone.all_months` 
                    AS c 
                    GROUP BY start_station_id, end_station_id, ROUND(start_lat,2), ROUND(start_lng,2) 
        -- didnt find much corelation and found didnt find repeating or significantly reduced attributes even after rounding, was led to believe that this was data entry issue but realised 
        -- that it is cause the company allows to park anywhere not in the dock with paid option. Hence the random long and lat without station id's and name

    --Discovered that there are 1670 station combinations.
    --repeated this for all others with positive values earlier. 


--percentage DELETED (AROUND 24 PERCENT of the whole data.) 
          
	ROUND(count(*)/(SELECT COUNT(*) FROM `capstone-402023.capstone.all_months`),2)*100
 AS null_row_percentage
	
	FROM `capstone-402023.capstone.all_months`

	WHERE start_station_name IS NULL
		OR start_station_id IS NULL
		OR end_station_name IS NULL
		OR end_station_id IS NULL
		OR end_lat IS NULL
		OR end_lng IS NULL
			    
-- number of total deleted Columns
SELECT
	count(*)
	
	FROM `capstone-402023.capstone.all_months`

	WHERE start_station_name IS NULL
		OR start_station_id IS NULL
		OR end_station_name IS NULL
		OR end_station_id IS NULL
		OR end_lat IS NULL
		OR end_lng IS NULL

-- Found which columns have null values 
  SELECT 
    COUNT(CASE WHEN ride_id IS NULL THEN 1 END) AS ride_id,
    COUNT(CASE WHEN rideable_type IS NULL THEN 1 END) AS rideable_type,
    COUNT(CASE WHEN started_at IS NULL THEN 1 END) AS started_at,
    COUNT(CASE WHEN ended_at IS NULL THEN 1 END) AS ended_at,
    COUNT(CASE WHEN start_station_name IS NULL THEN 1 END) AS start_station_name,
    COUNT(CASE WHEN start_station_id IS NULL THEN 1 END) AS start_station_id,
    COUNT(CASE WHEN end_station_name IS NULL THEN 1 END) AS end_station_name,
    COUNT(CASE WHEN end_station_id IS NULL THEN 1 END) AS end_station_id,
    COUNT(CASE WHEN start_lat IS NULL THEN 1 END) AS start_lat,
    COUNT(CASE WHEN start_lng IS NULL THEN 1 END) AS start_lng,
    COUNT(CASE WHEN end_lat IS NULL THEN 1 END) AS end_lat,
    COUNT(CASE WHEN end_lng IS NULL THEN 1 END) AS end_lng,
    COUNT(CASE WHEN member_casual IS NULL THEN 1 END) AS member_casual
  FROM `capstone-402023.capstone.all_months`

    
-- Created a temporary -- I have used this table when I am required to do analysis with these attributes. 
CREATE TABLE `capstone-402023.capstone.months_no_null_values` AS (
		SELECT *
	FROM `capstone-402023.capstone.all_months`	
	WHERE 	
		(
			end_station_name IS NOT NULL  
			OR end_station_id IS NOT NULL
			OR 	
			(
				end_lat IS NOT NULL
				AND end_lng IS NOT NULL
			)


          OR
          			start_station_name IS NOT NULL  
			OR start_station_id IS NOT NULL
			OR 	
			(
				start_lat IS NOT NULL
				AND start_lng IS NOT NULL
			)
))


-- Removed any trip data that could be due to test or service 
-- CHECKED IF THERE IS ANY DATA LIKE THIS FIRST 
SELECT start_station_name, start_station_id, end_station_name, end_station_id
				FROM `capstone-402023.capstone.all_months` 

			WHERE
					LOWER(start_station_name) LIKE "%test%" OR
					LOWER(start_station_name) LIKE "%staff%" OR
					LOWER(start_station_name) LIKE "%service%" OR
					LOWER(start_station_id) LIKE "%test%" OR
					LOWER(start_station_id) LIKE "%staff%" OR
					LOWER(start_station_id) LIKE "%service%" OR
					LOWER(end_station_name) LIKE "%test%" OR
					LOWER(end_station_name) LIKE "%staff%" OR
					LOWER(end_station_name) LIKE "%service%" OR
					LOWER(end_station_id) LIKE "%test%" OR
					LOWER(end_station_id) LIKE "%staff%" OR
					LOWER(end_station_id) LIKE "%service%"
GROUP BY start_station_name, start_station_id, end_station_name, end_station_id

-- Removed this data by selcting it out. 


-- Validation 

-- Created trip duration and filtered out all the trips that were less than 60 seconds. 
SELECT *,
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS trip_duration_seconds
FROM
  `capstone-402023.capstone.months_no_null_values`
  WHERE  CAST(( TIMESTAMP_DIFF(ended_at, started_at, SECOND)) AS INT) < 60

-- 



