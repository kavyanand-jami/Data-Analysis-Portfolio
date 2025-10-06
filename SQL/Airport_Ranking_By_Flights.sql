

-- # Airport Traffic Analysis

-- ## 🎯 Problem Statement
-- **Rank airports based on the number of flights departing from them.**  
-- *Expected output: departure_airport, total_flights, airport_rank*

-- ## 💡 Solution

SELECT 
    departure_airport,
    COUNT(flight_id) AS total_flights,
    DENSE_RANK() OVER (ORDER BY COUNT(flight_id) DESC) AS airport_rank 
FROM flights 
GROUP BY departure_airport;

-- 🔍 Approach
-- Counted flights per departure airport using COUNT aggregation
-- Used DENSE_RANK() for ranking without gaps
-- Ordered by flight count in descending order
-- Maintained exact output sequence as required

-- 🛠️ Skills Demonstrated
-- Aggregation with COUNT and GROUP BY
-- DENSE_RANK() window function
-- Result ordering and ranking logic
-- Aviation domain data analysis

-- 💼 Business Impact
-- Helps airlines optimize flight schedules and resource allocation at different airports.
