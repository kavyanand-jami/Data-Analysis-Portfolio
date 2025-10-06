-- # Popular Products Analysis
-- ## 🎯 Problem Statement
-- **Identify the most popular product in each store based on quantity sold.**  
-- *Expected Output: store_name, product_name, quantity_sold*

-- ## 💡 Solution

WITH cte AS (
    SELECT 
        s.store_name,
        p.product_name,
        SUM(oi.quantity) AS quantity_sold 
    FROM orders o 
    JOIN stores s ON o.store_id = s.store_id
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY s.store_name, p.product_name
),
rnk AS (
    SELECT *,
        RANK() OVER (PARTITION BY store_name ORDER BY quantity_sold DESC) as rank
    FROM cte 
)
SELECT store_name, product_name, quantity_sold 
FROM rnk 
WHERE rank = 1;

-- 🔍 Approach
-- Used CTE for intermediate data aggregation
-- Calculated total quantity sold per product per store
-- Applied RANK() window function to identify top products
-- Filtered for rank = 1 to get most popular items

-- 🛠️ Skills Demonstrated
-- Common Table Expressions (CTEs)
-- Window Functions (RANK with PARTITION BY)
-- Multiple table JOIN operations
-- Complex aggregation with GROUP BY

-- 💼 Business Impact
-- Helps stores optimize inventory and marketing strategies for top-performing products.
