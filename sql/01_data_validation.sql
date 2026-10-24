/*
Project: Customer Service Performance Dashboard
File: 01_data_validation.sql
Purpose: Validate the cleaned customer-support dataset
Author: Sage Edgar Samuel
*/

-- Confirm total rows and unique tickets.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ticket_id) AS distinct_tickets
FROM support.tickets;

-- Check for duplicate ticket IDs.
SELECT
    ticket_id,
    COUNT(*) AS occurrences
FROM support.tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

-- Check important fields for null values.
SELECT
    COUNT(*) FILTER (WHERE ticket_id IS NULL) AS missing_ticket_ids,
    COUNT(*) FILTER (WHERE ticket_status IS NULL) AS missing_status,
    COUNT(*) FILTER (WHERE ticket_priority IS NULL) AS missing_priority,
    COUNT(*) FILTER (WHERE ticket_channel IS NULL) AS missing_channel,
    COUNT(*) FILTER (WHERE first_response_time IS NULL) AS missing_response_time,
    COUNT(*) FILTER (WHERE resolution_time IS NULL) AS missing_resolution_time,
    COUNT(*) FILTER (WHERE csat_rating IS NULL) AS missing_csat
FROM support.tickets;

-- Validate satisfaction scores.
SELECT
    MIN(csat_rating) AS minimum_csat,
    MAX(csat_rating) AS maximum_csat,
    COUNT(*) FILTER (
        WHERE csat_rating NOT BETWEEN 1 AND 5
    ) AS invalid_csat_values
FROM support.tickets;

-- Validate calculated duration.
SELECT
    MIN(response_to_resolution_hours) AS minimum_duration,
    MAX(response_to_resolution_hours) AS maximum_duration,
    COUNT(*) FILTER (
        WHERE response_to_resolution_hours < 0
    ) AS negative_durations
FROM support.tickets;

-- Review timestamp quality.
SELECT
    timestamp_status,
    COUNT(*) AS tickets,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_tickets
FROM support.tickets
GROUP BY timestamp_status
ORDER BY tickets DESC;

-- Review ticket status values.
SELECT
    ticket_status,
    COUNT(*) AS tickets
FROM support.tickets
GROUP BY ticket_status
ORDER BY tickets DESC;

-- Review categorical values.
SELECT DISTINCT ticket_priority
FROM support.tickets
ORDER BY ticket_priority;

SELECT DISTINCT ticket_channel
FROM support.tickets
ORDER BY ticket_channel;

SELECT DISTINCT ticket_type
FROM support.tickets
ORDER BY ticket_type;