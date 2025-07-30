-- 1. Find Athletes from Summer or Winter Games
		-- Write a query to list all athlete names who participated in the Summer or Winter Olympics.
		-- Ensure no duplicates appear in the final table using a set theory clause. 4212 rows
(SELECT
	athlete_id,name
FROM
	summer_games
LEFT JOIN
	athletes
ON summer_games.athlete_id = athletes.id)
UNION
(SELECT
	athlete_id,name
FROM
	winter_games
LEFT JOIN
	athletes
ON winter_games.athlete_id = athletes.id);

-- 2. Find Countries Participating in Both Games
	-- Write a query to retrieve country_id and country_name for countries in the Summer Olympics. 203 rows

SELECT
	DISTINCT(c.country),
	s.country_id
FROM 
	summer_games AS s
LEFT JOIN
	countries AS c
ON
	s.country_id = c.id;

-- Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement. 203 rows

SELECT
	DISTINCT(c.country),
	cs.pop_in_millions,
	cs.year
FROM 
	summer_games AS s
LEFT JOIN
	countries AS c
ON
	s.country_id = c.id
LEFT JOIN
	country_stats AS cs
ON
	s.country_id = cs.country_id
WHERE
	cs.year ILIKE '%2016%';

-- Repeat the process for the Winter Olympics. 78 rows
		
SELECT
	DISTINCT(c.country),
	cs.pop_in_millions,
	cs.year
FROM 
	winter_games AS w
LEFT JOIN
	countries AS c
ON
	w.country_id = c.id
LEFT JOIN
	country_stats AS cs
ON
	w.country_id = cs.country_id
WHERE
	cs.year ILIKE '%2016%';

-- Use a set theory clause to combine the results. 78 rows

(SELECT
	DISTINCT(c.country),
	cs.pop_in_millions,
	cs.year
FROM 
	summer_games AS s
LEFT JOIN
	countries AS c
ON
	s.country_id = c.id
LEFT JOIN
	country_stats AS cs
ON
	s.country_id = cs.country_id
WHERE
	cs.year ILIKE '%2016%')
INTERSECT
(SELECT
	DISTINCT(c.country),
	cs.pop_in_millions,
	cs.year
FROM 
	winter_games AS w
LEFT JOIN
	countries AS c
ON
	w.country_id = c.id
LEFT JOIN
	country_stats AS cs
ON
	w.country_id = cs.country_id
WHERE
	cs.year ILIKE '%2016%');
	
-- 3. Identify Countries Exclusive to the Summer Olympics
	-- Return the country_name and region for countries present in the countries table but not in the winter_games table.
	-- (Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.) 125 rows

(SELECT
	country,
	region
FROM
	countries)
EXCEPT
(SELECT
	country,
	region
FROM
	winter_games AS w
LEFT JOIN
	countries
ON
	w.country_id=countries.id);

	--test
SELECT
	country_id
FROM
	summer_games
EXCEPT
SELECT 
	country_id
FROM
	winter_games;