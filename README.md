=======
# **Superstore Retail Analytics Project (SQL + Python)**
=======

## **Overview**

This project builds a **retail analytics pipeline** using the Superstore dataset.
The raw dataset is first loaded into a staging table and then transformed into a **normalized relational schema** to support analytical queries and business insights.

It demonstrates **data ingestion, cleaning, relational schema design, SQL analytics, and Python-based visualization**.

Database used: **`superstore_analytics`**

---

## **Dataset**

* Source: Kaggle Superstore Dataset
* Total Records: **9,994 rows**
* Contains retail transaction information including customers, orders, products, sales, discounts, and profit.

---

## **Data Pipeline**

```
Superstore.csv
      ↓
superstore_raw (staging table)
      ↓
Data Cleaning & Transformation
      ↓
Normalized Tables
```

Final tables:

* `customers` – Customer master data
* `orders` – Order-level information
* `products` – Product catalog
* `order_items` – Transaction-level sales, discount, and profit

---

## **Database Tables**

### `superstore_raw`

Staging table containing raw dataset before transformation.
Used for initial loading, validation, and transformation.

### `customers`

Stores customer information. Columns include:

* Customer ID, Customer Name, Segment, Country, City, State, Postal Code, Region

### `orders`

Stores order-level details. Columns include:

* Order ID, Customer ID, Order Date, Ship Date, Ship Mode, Region

### `products`

Stores product catalog. Columns include:

* Product ID, Product Name, Category, Sub-Category, UnitPrice

### `order_items`

Stores transaction-level sales information. Columns include:

* Order ID, Product ID, Quantity, Sales, Discount, Profit

---

## **Data Processing Steps**

* Load raw CSV into `superstore_raw`
* Clean and standardize data fields
* Remove duplicates
* Normalize into relational tables
* Create relationships between tables
* Perform validation checks to ensure data integrity

---

## **SQL Analytics**

Key analyses performed:

* Monthly revenue trend and month-over-month growth
* Revenue and profit by region
* Top products by revenue
* Category and sub-category sales contribution
* Discount distribution analysis
* Customer lifetime revenue
* Market basket analysis (products frequently bought together)

Techniques demonstrated:

* Joins, Aggregations, Window functions, CTEs, Self-joins
* Analytical percentage calculations

---

## **Python Analysis & Visualizations**

All Python analysis is performed in Jupyter notebooks.
Tables are loaded from MySQL using SQLAlchemy and stored in pandas DataFrames.

### **Notebooks**

* `01_data_loading.ipynb` – Connects to MySQL, loads tables, and executes SQL queries into DataFrames.
* `02_analysis_visualization.ipynb` – Creates visualizations using Matplotlib and Seaborn.

### **Visualizations Created**

1. Monthly Revenue Trend – Line plot
2. Category & Sub-Category Revenue – Bar plot
3. Discount vs Profit Margin – Scatter plot
4. Revenue Distribution per Customer – Histogram
5. Top Product Pairs Bought Together – Heatmap
6. Customer Order Frequency – Histogram

All plots are saved in the **`plots/` folder** in the repo.

---

## **Technologies Used**

* **MySQL**
* **SQL**
* **Python**
* **Pandas**
* **Matplotlib**
* **Seaborn**
* **Jupyter Notebook**

---

## **Project Structure**

```
retail-analytics-sql/
├── data/
│   └── Superstore.csv
├── sql/
│   ├── 01_schema_design.sql
│   ├── 02_data_loading.sql
│   ├── 03_data_ingestion_and_cleaning.sql
│   ├── 04_validation_checks.sql
│   └── 05_kpi_analysis.sql
├── python/
│   ├── 01_data_loading.ipynb
│   └── 02_analysis_visualization.ipynb
├── plots/
│   ├── monthly_revenue.png
│   ├── category_revenue.png
│   ├── discount_vs_profit.png
│   ├── revenue_distribution.png
│   ├── product_pairs_heatmap.png
│   └── customer_order_frequency.png
└── README.md
```

---

## **Objective**

Simulate a **real-world retail analytics workflow**, from raw data ingestion to **business insights using SQL**, extended with **Python-based visualizations** for interpretation and decision-making.

---
