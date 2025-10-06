                                        -- # Date Formatting Analysis

-- ## 🎯 Problem Statement  
-- **Represent the "book_date" column in "yyyy-mm-dd" format using Bookings table.**  
-- *Expected output: book_ref, book_date (in "yyyy-mm-dd" format) & total_amount.*

-- ## 💡 Solution

SELECT 
    book_ref,
    TO_CHAR(book_date, 'YYYY-MM-DD') AS formatted_date,
    total_amount 
FROM bookings;

-- 🔍 Approach
-- Used TO_CHAR function for consistent date formatting
-- Maintained exact column sequence as business requirement
-- Ensured data standardization for reporting

-- 🛠️ Skills Demonstrated
-- Date formatting with TO_CHAR
-- Column aliasing and sequencing
-- Output formatting for business reports

-- 💼 Business Impact
-- Standardized date formats ensure consistent reporting across the organization.
