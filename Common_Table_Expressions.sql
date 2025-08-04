-- 1. Winter Olympics Gold Medals
	-- Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics. 
	-- Norway, Sweden, Rissia, Switzerland, Ukraine
	
WITH top_gold_winter AS 
(SELECT
	country_id,
	COUNT(gold) AS count_gold
FROM
	winter_games
WHERE
	gold IS NOT NULL
GROUP BY
	country_id)
SELECT
	country,
	count_gold
FROM
	countries
INNER JOIN
	top_gold_winter
ON
	countries.id = top_gold_winter.country_id
ORDER BY
	count_gold DESC
LIMIT 5;

	-- Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.    
	-- 3 countries: Norway, Sweden, Russia
	
WITH top_gold_winter AS 
(SELECT
	country_id,
	COUNT(gold) AS count_gold
FROM
	winter_games
WHERE
	gold IS NOT NULL
GROUP BY
	country_id)
SELECT
	country,
	count_gold
FROM
	countries
INNER JOIN
	top_gold_winter
ON
	countries.id = top_gold_winter.country_id
WHERE
	count_gold >= '5'
ORDER BY
	count_gold DESC;

-- 2. Tall Athletes
	-- Write a CTE called tall_athletes to find athletes taller than the average height for athletes in the database. 
		-- Avg height: 174.9964421252371917, 2188 athletes
	
WITH tall_athletes AS
(SELECT
	AVG(height) AS avg_height
FROM
	athletes)
SELECT
	name,
	height
FROM
	athletes,
	tall_athletes
WHERE
	height > avg_height
ORDER BY
	height DESC;

--PER Google

WITH tall_athletes AS (
    SELECT *
    FROM athletes
    WHERE height > (SELECT AVG(height) FROM athletes)
)
SELECT * FROM tall_athletes;

	-- Query the CTE to return only female athletes over age 30 who meet the criteria. 
	-- 49 athletes

WITH tall_athletes AS
(SELECT
	AVG(height) AS avg_height
FROM
	athletes)
SELECT
	name,
	height,
	age,
	gender
FROM
	athletes,
	tall_athletes
WHERE
	height > avg_height
	AND gender = 'F'
	AND age > '30';

--Building from Google

WITH tall_athletes AS (
    SELECT *
    FROM athletes
    WHERE height > (SELECT AVG(height) 
	FROM athletes)
)
SELECT 
	* 
FROM 
	tall_athletes
WHERE
	gender = 'F'
	AND age > '30';

-- 3. Average Weight of Female Athletes
	-- Write a CTE called tall_over30_female_athletes for the results of Exercise 2. 
	-- 49 athletes

WITH tall_over30_female_athletes AS
(
    SELECT *
    FROM athletes
    WHERE height > (SELECT AVG(height) 
	FROM athletes)
	AND gender = 'F'
	AND age > '30'
)
SELECT 
	* 
FROM 
	tall_over30_female_athletes;
	
	-- Query the CTE to find the average weight of these athletes. 
	-- Avg weight: 72.2244897959183673

WITH tall_over30_female_athletes AS
(
    SELECT *
    FROM athletes
    WHERE height > (SELECT AVG(height) 
	FROM athletes)
	AND gender = 'F'
	AND age > '30'
)
SELECT 
	AVG(weight)
FROM 
	tall_over30_female_athletes;
