/*
Project: Customer Service Performance Dashboard
File: 02_ticket_performance_analysis.sql
Purpose: Analyse ticket volumes, resolution and operational performance
Author: Sage Edgar Samuel
*/

-- Headline customer-service KPIs.
SELECT
    COUNT(*) AS total_tickets,
    SUM(is_resolved) AS resolved_tickets,
    COUNT(*) - SUM(is_resolved) AS unresolved_tickets,
    ROUND(
        100.0 * SUM(is_resolved) / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    COUNT(first_response_time) AS tickets_with_response,
    COUNT(csat_rating) AS rated_tickets,
    ROUND(AVG(csat_rating), 2) AS average_csat,
    ROUND(
        AVG(response_to_resolution_hours)
            FILTER (WHERE timestamp_status = 'Valid sequence'),
        2
    ) AS average_post_response_resolution_hours
FROM support.tickets;

-- Analysis of tickets by status
-- Identifies the volume of closed, open and pending tickets
SELECT
    ticket_status,
    COUNT(*) AS tickets,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_tickets
FROM support.tickets
GROUP BY ticket_status
ORDER BY tickets DESC;

-- Analysis of performance by priority
SELECT
    ticket_priority,
    COUNT(*) AS total_tickets,
    SUM(is_resolved) AS resolved_tickets,
    ROUND(
        100.0 * SUM(is_resolved) / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    COUNT(csat_rating) AS rated_tickets,
    ROUND(AVG(csat_rating), 2) AS average_csat,
    ROUND(
        AVG(response_to_resolution_hours)
            FILTER (WHERE timestamp_status = 'Valid sequence'),
        2
    ) AS average_post_response_resolution_hours
FROM support.tickets
GROUP BY ticket_priority
ORDER BY total_tickets DESC;

-- Analysis of performance by channel
-- Comparison can reveal whether email, phone, char or social-media tickets produce different outcomes
SELECT
    ticket_channel,
    COUNT(*) AS total_tickets,
    SUM(is_resolved) AS resolved_tickets,
    ROUND(
        100.0 * SUM(is_resolved) / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    COUNT(csat_rating) AS rated_tickets,
    ROUND(AVG(csat_rating), 2) AS average_csat,
    ROUND(
        AVG(response_to_resolution_hours)
            FILTER (WHERE timestamp_status = 'Valid sequence'),
        2
    ) AS average_post_response_resolution_hours
FROM support.tickets
GROUP BY ticket_channel
ORDER BY total_tickets DESC;

-- Analysis of ticket types
SELECT
		ticket_type,
		COUNT(*) AS total_tickets,
		SUM(is_resolved) AS resolved_tickets,
		ROUND(
			100.0 * SUM(is_resolved) / NULLIF(COUNT(*), 0),
			2
		) AS resolution_rate_percentage,
		ROUND(AVG(csat_rating), 2) AS average_csat,
		ROUND(
			AVG(response_to_resolution_hours)
				FILTER (WHERE timestamp_status = 'Valid sequence'),
			2
		) AS average_post_response_resolution_hours
FROM support.tickets
GROUP BY ticket_type
ORDER BY total_tickets DESC;

--Analysis of ticket subjects
-- To identify the most common reasons customers contact support
SELECT
    ticket_subject,
    COUNT(*) AS total_tickets,
    SUM(is_resolved) AS resolved_tickets,
    ROUND(
        100.0 * SUM(is_resolved) / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    COUNT(csat_rating) AS rated_tickets,
    ROUND(AVG(csat_rating), 2) AS average_csat
FROM support.tickets
GROUP BY ticket_subject
ORDER BY total_tickets DESC;

-- Analysis of products
SELECT
    product_purchased,
    COUNT(*) AS total_tickets,
    SUM(is_resolved) AS resolved_tickets,
    ROUND(
        100.0 * SUM(is_resolved) / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    COUNT(csat_rating) AS rated_tickets,
    ROUND(AVG(csat_rating), 2) AS average_csat
FROM support.tickets
GROUP BY product_purchased
ORDER BY total_tickets DESC;

-- Monthly first response activity
-- Measures first responses not incoming ticket volume
SELECT 
	DATE_TRUNC('month', response_date)::date AS response_month,
	COUNT(*) AS tickets_responded_to,
	SUM(is_resolved) AS resolved_tickets,
	ROUND(AVG(csat_rating), 2) AS average_csat
FROM support.tickets
WHERE response_date IS NOT NULL
GROUP BY DATE_TRUNC('month', response_date)
ORDER BY response_month;

-- Analysis of workload by weekday
SELECT
    EXTRACT(ISODOW FROM response_date) AS weekday_number,
    response_weekday,
    COUNT(*) AS responses
FROM support.tickets
WHERE response_date IS NOT NULL
GROUP BY
    EXTRACT(ISODOW FROM response_date),
    response_weekday
ORDER BY weekday_number;

--Analysis of workload by hour
SELECT 
	response_hour,
	COUNT(*) AS responses
FROM support.tickets
WHERE response_hour IS NOT NULL
GROUP BY response_hour
ORDER BY response_hour;

SELECT
    response_time_band,
    COUNT(*) AS responses
FROM support.tickets
GROUP BY response_time_band
ORDER BY responses DESC;



