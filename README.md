# Retail Analytics Project (SQL + Python)

## Overview

This project builds a **retail analytics pipeline** using the Superstore dataset.
The raw dataset is first loaded into a staging table and then transformed into a **normalized relational schema** to support analytical queries and business insights.

The project demonstrates **data ingestion, data cleaning, relational schema design, SQL analytics, and planned Python-based visualization**.

Database Schema Used: **`superstore_analytics`**

---

## Dataset

Source: Kaggle Superstore Dataset

Total Records: **9,994 rows**

The dataset contains retail transaction information including:

* customers
* orders
* products
* sales transactions
* discounts and profit

---

## Data Pipeline

The data processing workflow follows a structured pipeline:

```
Superstore.csv
      ↓
superstore_raw (staging table)
      ↓
Data Cleaning & Transformation
      ↓
Normalized Tables
```

Final production tables:

* `customers`
* `orders`
* `products`
* `order_items`

---

## Database Tables

### superstore_raw

Staging table containing the original dataset before transformation.

Used for:

* initial data loading
* validation
* transformation into normalized tables

---

### customers

Stores customer information.

Columns include:

* Customer ID
* Customer Name
* Segment
* Country
* City
* State
* Postal Code
* Region

---

### orders

Stores order-level details.

Columns include:

* Order ID
* Customer ID
* Order Date
* Ship Date
* Ship Mode
* Region

---

### products

Stores product catalog information.

Columns include:

* Product ID
* Product Name
* Category
* Sub-Category
* UnitPrice

---

### order_items

Stores transaction-level sales information.

Columns include:

* Order ID
* Product ID
* Quantity
* Sales
* Discount
* Profit

---

## Data Processing Steps

The following data engineering steps were performed:

* Load raw CSV dataset into `superstore_raw`
* Clean and standardize data fields
* Remove duplicate records
* Normalize the dataset into relational tables
* Create relationships between tables
* Perform validation checks to ensure data integrity

---

## SQL Analytics

Business analysis was performed using SQL queries on the cleaned dataset.

Key analyses include:

* Monthly revenue trend
* Month-over-month revenue growth
* Revenue by region
* Profit by region
* Top products by revenue
* Category and sub-category sales contribution
* Discount distribution analysis
* Customer lifetime revenue
* Market basket analysis (products frequently bought together)

SQL techniques demonstrated:

* Joins
* Aggregations
* Window functions
* Common Table Expressions (CTEs)
* Self joins
* Analytical percentage calculations

---

## Planned Python Analysis

The project will be extended with **Python-based analysis and visualizations using Jupyter Notebook**.

Planned analyses include:

* Revenue trend visualization
* Customer revenue distribution
* Profit vs discount relationship
* Category and sub-category performance
* Customer segmentation using **RFM analysis**
* Product pair frequency heatmap

Libraries to be used:

* Pandas
* Matplotlib
* Seaborn

---

## Technologies Used

* **MySQL**
* **SQL**
* **Python (planned)**
* **Pandas**
* **Matplotlib**
* **Seaborn**
* **Jupyter Notebook**

---

## Project Structure

```
retail-analytics-sql/

data/
 └── Superstore.csv

sql/
 ├── 01_schema_design.sql
 ├── 02_data_loading.sql
 ├── 03_data_ingestion and cleaning
 ├── 04_validation_checks.sql
 └── 05_kpi_analysis.sql

python/
 ├── 01_data_loading.ipynb
 └── 02_analysis_visualization.ipynb

README.md
```

---

## Objective

The goal of this project is to simulate a **real-world retail analytics workflow**, starting from raw data ingestion to generating business insights using SQL and extending the analysis with Python-based visualizations.
