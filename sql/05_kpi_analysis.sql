/* ============================================================
RETAIL SALES ANALYTICS PROJECT
Author: Hemanth Loka

Tables Used:
- customers
- orders
- order_items
- products

Techniques Used:
- Joins
- Aggregations
- Window Functions
- CTEs
- Self Joins
- Date Functions
- CASE Expressions
============================================================ */


/* ============================================================
1. MONTHLY REVENUE TREND
Business Question:
How does revenue change month-by-month?
============================================================ */

SELECT 
DATE_FORMAT(o.`Order Date`, '%Y-%m') AS year_month,
ROUND(SUM(oi.Sales),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.`Order ID` = oi.`Order ID`
GROUP BY year_month
ORDER BY year_month;



/* ============================================================
2. MONTH-OVER-MONTH REVENUE GROWTH
Business Question:
What is the growth rate compared to the previous month?
============================================================ */

WITH monthly_revenue AS
(
SELECT 
DATE_FORMAT(o.`Order Date`, '%Y-%m') AS year_month,
SUM(oi.Sales) AS revenue
FROM orders o
JOIN order_items oi
ON o.`Order ID` = oi.`Order ID`
GROUP BY year_month
),

revenue_with_lag AS
(
SELECT
year_month,
revenue,
LAG(revenue) OVER (ORDER BY year_month) AS previous_month_revenue
FROM monthly_revenue
)

SELECT
year_month,
revenue,
previous_month_revenue,
ROUND(
(revenue - previous_month_revenue) /
previous_month_revenue * 100
,2) AS mom_growth_pct
FROM revenue_with_lag
ORDER BY year_month;



/* ============================================================
3. AVERAGE ORDER VALUE (AOV) & UNITS PER TRANSACTION
Business Question:
How much revenue does an average order generate?
============================================================ */

SELECT
DATE_FORMAT(o.`Order Date`, '%Y-%m') AS year_month,
ROUND(SUM(oi.Sales) / COUNT(DISTINCT o.`Order ID`),2) AS avg_order_value,
ROUND(COUNT(oi.`Product ID`) / COUNT(DISTINCT o.`Order ID`),2) AS units_per_transaction
FROM orders o
JOIN order_items oi
ON o.`Order ID` = oi.`Order ID`
GROUP BY year_month
ORDER BY year_month;



/* ============================================================
4. REGIONAL REVENUE PERFORMANCE
============================================================ */

SELECT 
o.Region,
ROUND(SUM(oi.Sales),2) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.`Order ID` = oi.`Order ID`
GROUP BY o.Region
ORDER BY total_revenue DESC;



/* ============================================================
5. REGIONAL PROFITABILITY
============================================================ */

SELECT 
o.Region,
ROUND(SUM(oi.Profit),2) AS total_profit
FROM orders o
JOIN order_items oi
ON o.`Order ID` = oi.`Order ID`
GROUP BY o.Region
ORDER BY total_profit DESC;



/* ============================================================
6. TOP PRODUCTS BY REVENUE
============================================================ */

SELECT 
p.`Product Name`,
ROUND(SUM(oi.Sales),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.`Product ID` = p.`Product ID`
GROUP BY p.`Product Name`
ORDER BY revenue DESC
LIMIT 10;



/* ============================================================
7. CATEGORY & SUBCATEGORY SALES CONTRIBUTION
============================================================ */

WITH categorysum AS (
SELECT 
p.`Category` AS category,
p.`Sub-Category` AS sub_category,
SUM(oi.Sales) AS sub_category_revenue
FROM products p
JOIN order_items oi
ON p.`Product ID` = oi.`Product ID`
GROUP BY p.`Category`, p.`Sub-Category`
),

category_totals AS (
SELECT
category,
SUM(sub_category_revenue) AS category_total
FROM categorysum
GROUP BY category
),

overall_total AS (
SELECT SUM(category_total) AS overall_sales
FROM category_totals
)

SELECT
c.category,
c.sub_category,
c.sub_category_revenue,
ROUND(c.sub_category_revenue / t.category_total * 100,2) AS subcategory_pct_of_category,
t.category_total,
ROUND(t.category_total / o.overall_sales * 100,2) AS category_pct_of_overall
FROM categorysum c
JOIN category_totals t
ON c.category = t.category
CROSS JOIN overall_total o
ORDER BY category_pct_of_overall DESC;



/* ============================================================
8. DISCOUNT IMPACT ON PROFIT
Business Question:
How do discount levels affect profit margin?
============================================================ */

SELECT
CASE 
WHEN oi.Discount = 0 THEN 'No Discount'
WHEN oi.Discount <= 0.1 THEN '0-10%'
WHEN oi.Discount <= 0.2 THEN '10-20%'
ELSE '20%+'
END AS discount_bucket,

ROUND(SUM(oi.Sales),2) AS total_sales,
ROUND(SUM(oi.Profit),2) AS total_profit,
ROUND(SUM(oi.Profit) / SUM(oi.Sales) * 100,2) AS profit_margin_pct

FROM order_items oi
GROUP BY discount_bucket
ORDER BY profit_margin_pct DESC;



/* ============================================================
9. CUSTOMER LIFETIME VALUE (TOP CUSTOMERS)
============================================================ */

SELECT 
c.`Customer ID`,
ROUND(SUM(oi.Sales),2) AS total_revenue
FROM customers c
JOIN orders o
ON c.`Customer ID` = o.`Customer ID`
JOIN order_items oi
ON o.`Order ID` = oi.`Order ID`
GROUP BY c.`Customer ID`
ORDER BY total_revenue DESC
LIMIT 10;



/* ============================================================
10. MARKET BASKET ANALYSIS
Business Question:
Which products are frequently bought together?
============================================================ */

WITH product_pairs AS (
SELECT 
oi.`Order ID` AS OrderID,
oi.`Product ID` AS Product1,
oi2.`Product ID` AS Product2
FROM order_items oi
JOIN order_items oi2
ON oi.`Order ID` = oi2.`Order ID`
AND oi.`Product ID` < oi2.`Product ID`
)

SELECT 
pp.Product1,
pp.Product2,
P1.`Product Name` AS Product1_Name,
P2.`Product Name` AS Product2_Name,
COUNT(*) AS times_bought_together
FROM product_pairs pp
JOIN products P1
ON pp.Product1 = P1.`Product ID`
JOIN products P2
ON pp.Product2 = P2.`Product ID`
GROUP BY pp.Product1, pp.Product2, P1.`Product Name`, P2.`Product Name`
HAVING COUNT(*) >= 2
ORDER BY times_bought_together DESC;