
-- # Quarterly Sales Performance Analysis
-- ## 🎯 Problem Statement
-- **Calculate total sales for each store for each quarter and rank stores based on sales figures to identify top performers.**

-- ## 💡 Solution

WITH cte AS (
    SELECT
        CONCAT(EXTRACT(YEAR FROM o.order_date), '_Q', EXTRACT(QUARTER FROM o.order_date)) AS year_quarter,
        s.store_name,
        ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
    FROM orders o 
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN stocks st ON st.product_id = oi.product_id
    JOIN stores s ON s.store_id = st.store_id
    GROUP BY EXTRACT(YEAR FROM o.order_date), EXTRACT(QUARTER FROM o.order_date), s.store_name
)
SELECT *,
    RANK() OVER (PARTITION BY year_quarter ORDER BY total_sales DESC) AS performance_rank 
FROM cte;

-- 🔍 Approach
-- Created quarterly periods using date extraction functions
-- Calculated total sales with proper discount application
-- Used RANK() window function for performance ranking per quarter
-- Structured output for management review

-- 🛠️ Skills Demonstrated
-- Complex date manipulation (EXTRACT, CONCAT)
-- Advanced mathematical calculations
-- Window functions with partitioning
-- Multi-table joins for comprehensive analysis

-- 💼 Business Impact
-- Enables data-driven decisions for store performance improvement and resource allocation.
