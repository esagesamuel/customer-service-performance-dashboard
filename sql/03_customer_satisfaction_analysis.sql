/*
Project: Customer Service Performance Dashboard
File: 03_customer_satisfaction_analysis.sql
Purpose: Analyse satisfaction and identify potential service-quality drivers
Author: Sage Edgar Samuel
*/

-- CSAT distribution
SELECT
    csat_rating,
    COUNT(*) AS rated_tickets,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_ratings
FROM support.tickets
WHERE csat_rating IS NOT NULL
GROUP BY csat_rating
ORDER BY csat_rating;

--Analysis of CSAT bands
SELECT 
	csat_band,
	COUNT(*) AS tickets,
	ROUND(
		100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
		2
	) AS percentage_of_rated_tickets
FROM support.tickets
WHERE csat_status = 'Rated'
GROUP BY csat_band
ORDER BY tickets DESC;

-- Low satisfaction rate
-- The denominator is rated tickets, not all tickets
SELECT
    COUNT(*) FILTER (WHERE csat_rating <= 2) AS low_csat_tickets,
    COUNT(csat_rating) AS rated_tickets,
    ROUND(
        100.0
        * COUNT(*) FILTER (WHERE csat_rating <= 2)
        / NULLIF(COUNT(csat_rating), 0),
        2
    ) AS low_csat_rate_percentage
FROM support.tickets;

-- Compare CSAT with resolution status
-- Whether resolved tickets receive stronger satisfaction scores
SELECT 
	CASE 	
		WHEN is_resolved = 1 THEN 'Resolved'
		ELSE 'Unresolved'
	END AS resolution_group,
	COUNT(*) AS total_tickets,
	COUNT(csat_rating) AS rated_tickets,
	ROUND(AVG(csat_rating), 2) AS average_csat
FROM support.tickets
GROUP BY is_resolved
ORDER BY is_resolved DESC;

--Compare CSAT with handling duration
SELECT
    CASE
        WHEN response_to_resolution_hours < 24 THEN 'Under 24 hours'
        WHEN response_to_resolution_hours < 72 THEN '24-72 hours'
        WHEN response_to_resolution_hours < 168 THEN '3-7 days'
        ELSE 'Over 7 days'
    END AS handling_time_band,
    COUNT(*) AS tickets,
    ROUND(AVG(csat_rating), 2) AS average_csat
FROM support.tickets
WHERE timestamp_status = 'Valid sequence'
  AND response_to_resolution_hours IS NOT NULL
GROUP BY handling_time_band
ORDER BY MIN(response_to_resolution_hours);

--Median duration 
--Averages can be distorted by extreme values
-- The 90th percentile shows the duration within which 90% of valid tickets were handled after the first response.
SELECT
    ROUND(
        AVG(response_to_resolution_hours),
        2
    ) AS average_hours,
    ROUND(
        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY response_to_resolution_hours
        )::numeric,
        2
    ) AS median_hours,
    ROUND(
        PERCENTILE_CONT(0.9) WITHIN GROUP (
            ORDER BY response_to_resolution_hours
        )::numeric,
        2
    ) AS percentile_90_hours
FROM support.tickets
WHERE timestamp_status = 'Valid sequence'
  AND response_to_resolution_hours IS NOT NULL;

-- Test the relationship between duration and CSAT
-- Close to -1: longer durations strongly accompany lower satisfaction
-- Close to 0: little linear relationship
-- Close to 1: longer durations accompany higher satisfaction
--Corelation doesn't prove causation
SELECT
    ROUND(
        CORR(
            response_to_resolution_hours,
            csat_rating
        )::numeric,
        3
    ) AS duration_csat_correlation
FROM support.tickets
WHERE timestamp_status = 'Valid sequence'
  AND response_to_resolution_hours IS NOT NULL
  AND csat_rating IS NOT NULL;