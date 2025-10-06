-- # PROBLEM STATEMENT
-- How many tickets are there without boarding passes?
-- Expected Output: just one number is required.

SELECT COUNT(*) AS ticket_no_boarding 
FROM tickets t 
LEFT JOIN boarding_passes b ON t.ticket_no = b.ticket_no  
WHERE b.ticket_no IS NULL;

-- ## Solution Approach
-- - Used LEFT JOIN to find tickets without matching boarding passes
-- - Filtered results where boarding pass ticket number is NULL
-- - Used COUNT aggregation to get the total number

-- ## SQL Skills Demonstrated
-- - LEFT JOIN operations
-- - NULL value handling
-- - COUNT aggregation
-- - Business logic implementation
