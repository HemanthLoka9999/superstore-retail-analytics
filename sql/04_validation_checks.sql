-- =====================================
-- 04_validation_checks.sql
-- Checks used during project validation
-- Run this script after executing 03_data_cleaning.sql
-- =====================================


-- 1. Check raw dataset row count
SELECT COUNT(*) AS raw_rows
FROM superstore_raw;



-- 2. Check customers table row count
SELECT COUNT(*) AS customer_rows
FROM customers;



-- 3. Check orders table row count
SELECT COUNT(*) AS order_rows
FROM orders;



-- 4. Check products table row count
SELECT COUNT(*) AS product_rows
FROM products;



-- 5. Check order_items table row count
SELECT COUNT(*) AS order_item_rows
FROM order_items;



-- 6. Check duplicate Order-Product combinations
SELECT
    `Order ID`,
    `Product ID`,
    COUNT(*) AS duplicate_count
FROM order_items
GROUP BY `Order ID`, `Product ID`
HAVING COUNT(*) > 1;



-- 7. Check if any orders exist without customers
SELECT o.`Order ID`
FROM orders o
LEFT JOIN customers c
ON o.`Customer ID` = c.`Customer ID`
WHERE c.`Customer ID` IS NULL;



-- 8. Check if any order items exist without orders
SELECT oi.`Order ID`
FROM order_items oi
LEFT JOIN orders o
ON oi.`Order ID` = o.`Order ID`
WHERE o.`Order ID` IS NULL;



-- 9. Check if any order items exist without products
SELECT oi.`Product ID`
FROM order_items oi
LEFT JOIN products p
ON oi.`Product ID` = p.`Product ID`
WHERE p.`Product ID` IS NULL;