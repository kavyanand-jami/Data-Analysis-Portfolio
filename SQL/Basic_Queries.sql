-- Basic_Queries.sql
-- Starter SQL examples for Data-Analysis-Portfolio
-- (These use example table names: Orders, Customers, Products, Returns, Dates)
-- Add a small README or sample data later if you want others to run queries.

-- TABLES (example schemas)
-- Orders(OrderID, OrderDate, CustomerID, ProductID, Quantity, SalesAmount, ProfitAmount, Region)
-- Customers(CustomerID, CustomerName, City, State, Segment)
-- Products(ProductID, ProductName, Category, SubCategory, Price)
-- Returns(ReturnID, OrderID, ReturnDate, Reason)

---------------------------------------------------------
-- 1) Simple select & filter
SELECT OrderID, OrderDate, CustomerID, SalesAmount
FROM Orders
WHERE SalesAmount > 1000
ORDER BY SalesAmount DESC;

---------------------------------------------------------
-- 2) Aggregation: total sales by region
SELECT Region, SUM(SalesAmount) AS TotalSales, AVG(SalesAmount) AS AvgOrderValue, COUNT(*) AS OrdersCount
FROM Orders
GROUP BY Region
ORDER BY TotalSales DESC;

---------------------------------------------------------
-- 3) Top 10 products by revenue
SELECT p.ProductID, p.ProductName, p.Category, SUM(o.SalesAmount) AS Revenue
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category
ORDER BY Revenue DESC
LIMIT 10;

---------------------------------------------------------
-- 4) Monthly sales trend (requires Date dimension or use DATE_TRUNC)
-- Example for databases supporting DATE_TRUNC (Postgres / Redshift / Snowflake-like)
SELECT DATE_TRUNC('month', OrderDate) AS Month, SUM(SalesAmount) AS MonthSales
FROM Orders
GROUP BY DATE_TRUNC('month', OrderDate)
ORDER BY Month;

---------------------------------------------------------
-- 5) Customer segmentation: top customers by lifetime revenue
SELECT c.CustomerID, c.CustomerName, c.City, SUM(o.SalesAmount) AS LifetimeRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City
ORDER BY LifetimeRevenue DESC
LIMIT 20;

---------------------------------------------------------
-- 6) Join & conditional: returns rate by product
SELECT p.ProductID, p.ProductName,
       SUM(o.SalesAmount) AS Revenue,
       COUNT(r.OrderID) AS ReturnsCount,
       ROUND( (COUNT(r.OrderID)::decimal / NULLIF(COUNT(o.OrderID),0)) * 100, 2) AS ReturnRatePct
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
LEFT JOIN Returns r ON o.OrderID = r.OrderID
GROUP BY p.ProductID, p.ProductName
ORDER BY ReturnRatePct DESC
LIMIT 20;

---------------------------------------------------------
-- 7) Window functions: running total of sales by date
SELECT OrderDate,
       SUM(SalesAmount) AS DailySales,
       SUM(SUM(SalesAmount)) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSales
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate;

---------------------------------------------------------
-- 8) Example: sales by product category and region pivot (long format)
SELECT Category, Region, SUM(SalesAmount) AS Sales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY Category, Region
ORDER BY Category, Sales DESC;
