-- 1. Use a window function to add columns showing:
	-- The maximum population (max_pop) for each county.
	-- The minimum population (min_pop) for each county.

SELECT
	county,
	MAX(population) OVER (PARTITION BY county) AS max_pop,
	MIN(population) OVER (PARTITION BY county) AS min_pop
FROM
	population;
	
-- 2. Rank counties from largest to smallest population for each year.

SELECT
	county,
	year,
	population,
	RANK() OVER(PARTITION BY year ORDER BY population DESC) AS pop_size
FROM
	population;

-- 3. Use the unemployment table:
	-- Calculate the rolling 12-month average unemployment rate using the unemployment table.
	-- Include the current month and the preceding 11 months.
	-- Hint: Reference two columns in the ORDER BY argument (county and period).

SELECT
	county,
	period,
	value,
	ROUND(AVG(value) OVER(
		PARTITION BY county
		ORDER BY county, period
		ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 2
	) AS twelve_month_avg
FROM
	unemployment;

-- ** ORDER BY year and period instead **

SELECT
	county,
	period,
	year,
	value,
	ROUND(AVG(value) OVER(
		PARTITION BY county
		ORDER BY year, period
		ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 2
	) AS twelve_month_avg
FROM
	unemployment;