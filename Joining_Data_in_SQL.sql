-- How many rows are in the athletes table? 4216 How many distinct athlete ids? 4215
SELECT
	COUNT(*)
FROM
	athletes;

SELECT
	COUNT (DISTINCT ID)
FROM
	athletes;

-- Which years are represented in the summer_games, winter_games, and country_stats tables?
-- summer_games 2016
-- winter_games 2014
-- country_stats 2000-2017

SELECT 
	DISTINCT summer.year AS summer_years,
	winter.year AS winter_years
FROM
	summer_games AS summer
FULL JOIN
	winter_games AS winter
USING(year)


SELECT
	DISTINCT year
FROM
	country_stats
ORDER BY year ASC

-- How many distinct countries are represented in the countries and country_stats table? 203

SELECT
	COUNT(DISTINCT countries.id),
	COUNT(DISTINCT country_stats.country_id)
FROM
	countries
FULL JOIN
	country_stats
ON
	countries.id = country_stats.country_id

SELECT
	COUNT(DISTINCT country_id)
FROM
	country_stats

SELECT
	COUNT(DISTINCT id)
FROM
	countries

-- How many distinct events are in the winter_games and summer_games table?
-- summer_games 95
-- winter_games 32

SELECT
	COUNT(DISTINCT s.event) AS summer_events,
	COUNT(DISTINCT w.event) AS winter_events
FROM
	summer_games AS s
FULL JOIN
	winter_games AS w
USING(event)

-- Count the number of athletes who participated in the summer games for each country. Your output should have country name and 
-- number of athletes in their own columns. Did any country have no athletes? no

SELECT 
	c.country,
	COUNT(s.athlete_id) AS num_athletes
FROM
	summer_games AS s
LEFT JOIN
	countries AS c
ON
	s.country_id=c.id
GROUP BY
	c.country
ORDER BY
	num_athletes ASC;

-- Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom.

SELECT 
	c.country,
	COUNT(s.bronze) AS s_bronze
FROM
	summer_games AS s
INNER JOIN
	countries AS c
ON
	s.country_id=c.id
GROUP BY
	c.country
ORDER BY
	s_bronze DESC;

		-- Adjust the query to only return the country with the most bronze medals

SELECT 
	c.country,
	COUNT(s.bronze) AS s_bronze
FROM
	summer_games AS s
INNER JOIN
	countries AS c
ON
	s.country_id=c.id
GROUP BY
	c.country
ORDER BY
	s_bronze DESC
LIMIT 1;

-- Calculate the average population in the country_stats table for countries in the winter_games. This will require 2 joins.
		-- First query gives you country names and the average population    198 rows(no null)
SELECT
	c.country,
	AVG(cs.pop_in_millions::FLOAT) AS avg_pop
FROM 
	country_stats AS cs
INNER JOIN
	countries AS c
ON
	cs.country_id = c.id
WHERE
	cs.pop_in_millions IS NOT NULL
GROUP BY 
	c.country
ORDER BY
	avg_pop DESC


SELECT
	pop_in_millions
FROM 
	country_stats
ORDER BY
	pop_in_millions DESC

		-- Second query returns only countries that participated in the winter_games  78 rows(no null)

SELECT
	c.country,
	AVG(cs.pop_in_millions::FLOAT) AS avg_pop
FROM 
	country_stats AS cs
INNER JOIN
	countries AS c
ON
	cs.country_id = c.id
INNER JOIN 
	winter_games AS w
USING
	(country_id)
WHERE
	cs.pop_in_millions IS NOT NULL
GROUP BY 
	c.country
ORDER BY
	avg_pop DESC
	
-- -- Identify countries where the population decreased from 2000 to 2006.

SELECT
	c.country,
	cs1.year,
	cs1.pop_in_millions AS pop_2000,
	cs2.year,
	cs2.pop_in_millions AS pop_2006
FROM 
	country_stats AS cs1
INNER JOIN
	country_stats AS cs2
USING(country_id)
INNER JOIN
	countries AS c
ON
	cs1.country_id=c.id
WHERE
	cs1.year ILIKE '%2000%'
	AND cs2.year ILIKE '%2006%'
	AND cs2.pop_in_millions < cs1.pop_in_millions


SELECT
	c.country,
	cs1.pop_in_millions AS pop_2000,
	cs2.pop_in_millions AS pop_2006
FROM 
	country_stats AS cs1
INNER JOIN
	country_stats AS cs2
USING(country_id)
INNER JOIN
	countries AS c
ON
	cs1.country_id=c.id
WHERE
	cs1.year ILIKE '%2000%'
	AND cs2.year ILIKE '%2006%'
	AND cs2.pop_in_millions < cs1.pop_in_millions


SELECT
	c.country,
	cs1.pop_in_millions AS pop_2000,
	cs2.pop_in_millions AS pop_2006
FROM 
	country_stats AS cs1
INNER JOIN
	country_stats AS cs2
USING(country_id)
INNER JOIN
	countries AS c
ON
	cs1.country_id=c.id
WHERE
	cs1.year ILIKE '%2000%'
	AND cs2.year ILIKE '%2006%'
	AND cs2.pop_in_millions::NUMERIC < cs1.pop_in_millions::NUMERIC;