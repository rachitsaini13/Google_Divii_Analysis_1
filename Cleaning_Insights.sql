-- This is the analysis that I did for the capstone project from Google analytics project. 

-- Checking duplicates 
        SELECT 
        		ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat,	end_lng, member_casual, COUNT (*) AS Count
        	FROM `capstone-402023.capstone.all_months` AS c 
        	GROUP BY 
        		ride_id, 
        		rideable_type, 
        		started_at, 
        		ended_at, 
        		start_station_name, 
        		start_station_id,
        		end_station_name,
        		end_station_id,
        		start_lat,
        		start_lng,
        		end_lat,
        		end_lng,
        		member_casual
        	HAVING COUNT(*) > 1


-- Tried seeing if there is any pattern to follow from the missing starting and ending location name
        -- Tried to find pattern in longitude and latitude to see any corelation between it and the starting and ending points. 
        -- didnt find anything from this. It was still a little 
                    SELECT start_station_id,  ROUND(start_lat,2), ROUND(start_lng,2)  FROM `capstone-402023.capstone.all_months` 
                    AS c 
                    GROUP BY start_station_id, end_station_id, ROUND(start_lat,2), ROUND(start_lng,2) 
        -- didnt find much corelation and found didnt find repeating or significantly reduced attributes even after rounding, was led to believe that this was data entry issue but realised 
        -- that it is cause the company allows to park anywhere not in the dock with paid option. Hence the random long and lat without station id's and name

-- checking for whitespaces and trimming whitespaces

    SELECT 
		count(case when (ride_id LIKE "% %" OR ride_id LIKE " %"  OR ride_id LIKE "% ") then 1 end) as ride_id_count,
		count(case when (rideable_type LIKE '% %' OR rideable_type LIKE ' %' OR rideable_type LIKE '% ') then 1 end) as rideable_type_count,
		count(case when (start_station_name LIKE '% %' OR start_station_name LIKE ' %' OR start_station_name LIKE '% ') then 1 end) as start_station_name_count,
		count(case when (start_station_id LIKE '% %' OR start_station_id LIKE ' %' OR start_station_id LIKE '% ') then 1 end) as start_station_id_count,
		count(case when (end_station_name LIKE '% %' OR end_station_name LIKE ' %' OR end_station_name LIKE '% ') then 1 end) as end_station_name_count,
		count(case when (end_station_id LIKE '% %' OR end_station_id LIKE ' %' OR end_station_id LIKE '% ')  then 1 end) as end_station_id_count,
		count(case when (member_casual LIKE '% %' OR member_casual LIKE ' %' OR member_casual LIKE '% ')then 1 end) as member_casual_count
	FROM `capstone-402023.capstone.all_months`


--- checked for whitespaces further
  SELECT 
		start_station_name
	FROM `capstone-402023.capstone.all_months`
	GROUP BY start_station_name

    --Discovered that there are 1670 station combinations.
    --repeated this for all others with positive values earlier. 

-- COUNTED null values. 
SELECT
	count(*)
	
	FROM `capstone-402023.capstone.all_months`

	WHERE start_station_name IS NULL
		OR start_station_id IS NULL
		OR end_station_name IS NULL
		OR end_station_id IS NULL
		OR end_lat IS NULL
		OR end_lng IS NULL

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

    
-- Created a temporary 
CREATE TABLE `capstone-402023.capstone.temp` AS (
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
