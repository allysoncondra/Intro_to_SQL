-- Find which county had the most months with unemployment rates above the state average:
	-- Write a query to calculate the state average unemployment rate.

SELECT
	AVG(value)
FROM
	unemployment;

	-- Use this query in the WHERE clause of an outer query to filter for months above the average.

SELECT
	period_name,
	value
FROM 
	unemployment
WHERE
	value > 
	(SELECT
		AVG(value)
	FROM
		unemployment);
	
	-- Use Select to count the number of months each county was above the average. Which country had the most?
			-- Giles, Sevier, Benton, and Loudon all = 65
	
SELECT
	county,
	COUNT(period_name) AS mo_above_avg
FROM 
	unemployment
WHERE
	value > 
	(SELECT
		AVG(value)
	FROM
		unemployment)
GROUP BY
	county
ORDER BY
	mo_above_avg DESC;
		
-- Find the average number of jobs created for each county based on projects involving the largest capital investment by each company:
	-- Write a query to find each company’s largest capital investment, returning the company name along with the relevant 
	-- capital investment amount for each.

SELECT
	company,
	MAX(capital_investment) AS max_cap_invest
FROM
	ecd
GROUP BY
	company;
		
	-- Use this query in the FROM clause of an outer query, alias it, and join it with the original table.
		-- Use Select * in the outer query to make sure your join worked properly

SELECT
	*
FROM 
	(SELECT
		company,
		MAX(capital_investment) AS max_cap_invest
	FROM
		ecd
	GROUP BY
		company) AS company_max_invest
	INNER JOIN
		ecd
	ON
		ecd.company = company_max_invest.company AND ecd.capital_investment = company_max_invest.max_cap_invest;

	-- Adjust the SELECT clause to calculate the average number of jobs created by county.

SELECT
	*
FROM 
	(SELECT
		county,
		AVG(new_jobs) AS avg_new_jobs
	FROM
		ecd
	GROUP BY
		county) AS avg_jobs_county
	INNER JOIN
		ecd
	ON
		ecd.county = avg_jobs_county.county AND ecd.new_jobs = avg_jobs_county.avg_new_jobs;

-- average number of jobs created for each county based on projects involving the largest capital investment by each company

SELECT
	DISTINCT company,
	county,
	AVG(new_jobs) AS avg_new_jobs,
	MAX(capital_investment) AS max_cap_invest
FROM 
	ecd
GROUP BY
	county, company
ORDER BY
	max_cap_invest DESC;

-- test 1
SELECT
	company,
	MAX(capital_investment) AS max_cap_invest
FROM
	ecd
GROUP BY
	company
ORDER BY
	max_cap_invest DESC;
-- test2
SELECT
	county,
	AVG(new_jobs) AS avg_new_jobs
FROM
	ecd
GROUP BY
	county
ORDER BY avg_new_jobs DESC;