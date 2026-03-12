-----------------------------
-- 03_data_cleaning // data_cleaning // etl_normalization_final.sql
-- Fully automated insert + normalization for all production tables
-- Handles deduplication, case standardization, and aggregation
-- Source: Kaggle Superstore Dataset
-- -----------------------------

-- =========================
-- Customers
-- =========================
INSERT INTO customers (
    `Customer ID`,
    `Customer Name`,
    Segment,
    Country,
    City,
    State,
    `Postal Code`,
    Region
)
SELECT
    `Customer ID`,
    UPPER(TRIM(MIN(`Customer Name`))),
    UPPER(TRIM(MIN(Segment))),
    UPPER(TRIM(MIN(Country))),
    UPPER(TRIM(MIN(City))),
    UPPER(TRIM(MIN(State))),
    MIN(`Postal Code`),
    UPPER(TRIM(MIN(Region)))
FROM superstore_raw
GROUP BY `Customer ID`;

-- =========================
-- Products
-- =========================
INSERT INTO products (
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`,
    UnitPrice
)
SELECT
    `Product ID`,
    UPPER(TRIM(MIN(`Product Name`))),
    UPPER(TRIM(MIN(Category))),
    UPPER(TRIM(MIN(`Sub-Category`))),
    ROUND(MIN(Sales / NULLIF(Quantity,0)), 2) AS UnitPrice
FROM superstore_raw
GROUP BY `Product ID`;

-- =========================
-- Orders
-- =========================
INSERT INTO orders (
    `Order ID`,
    `Customer ID`,
    `Order Date`,
    `Ship Date`,
    `Ship Mode`,
    Region
)
SELECT
    `Order ID`,
    MIN(`Customer ID`) AS `Customer ID`,
    STR_TO_DATE(MIN(`Order Date`), '%m/%d/%Y') AS `Order Date`,
    STR_TO_DATE(MIN(`Ship Date`), '%m/%d/%Y') AS `Ship Date`,
    UPPER(TRIM(MIN(`Ship Mode`))) AS `Ship Mode`,
    UPPER(TRIM(MIN(Region))) AS Region
FROM superstore_raw
GROUP BY `Order ID`;

-- =========================
-- Order Items
-- =========================
INSERT INTO order_items (
    `Order ID`,
    `Product ID`,
    Quantity,
    Sales,
    Discount,
    Profit
)
SELECT
    `Order ID`,
    `Product ID`,
    SUM(Quantity) AS Quantity,
    ROUND(SUM(Sales), 2) AS Sales,
    ROUND(AVG(Discount), 2) AS Discount,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_raw
GROUP BY `Order ID`, `Product ID`;

-- =========================
-- Post-Insertion Normalization
-- =========================

-- Customers
UPDATE customers
SET
    `Customer Name` = UPPER(TRIM(`Customer Name`)),
    Segment        = UPPER(TRIM(Segment)),
    Country        = UPPER(TRIM(Country)),
    City           = UPPER(TRIM(City)),
    State          = UPPER(TRIM(State)),
    Region         = UPPER(TRIM(Region))
WHERE `Customer ID` IS NOT NULL;

-- Products
UPDATE products
SET
    `Product Name` = UPPER(TRIM(`Product Name`)),
    Category       = UPPER(TRIM(Category)),
    `Sub-Category` = UPPER(TRIM(`Sub-Category`))
WHERE `Product ID` IS NOT NULL;

-- Orders
UPDATE orders
SET
    `Ship Mode` = UPPER(TRIM(`Ship Mode`)),
    Region      = UPPER(TRIM(Region))
WHERE `Order ID` IS NOT NULL;

-- Order Items
-- Numeric aggregation already handled; no string columns to normalize