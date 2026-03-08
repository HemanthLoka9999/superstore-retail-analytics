# Retail Analytics SQL Project

## Overview

This project builds a **SQL-based data pipeline** using the Superstore dataset.
The raw transactional data is cleaned and transformed into a **normalized relational schema** to support analytics.

---

## Dataset

* Source: Kaggle Superstore dataset
* Records: **9,994 rows**

---

## Data Pipeline

Raw dataset
→ `superstore_raw` (staging table)
→ data cleaning & transformation
→ normalized production tables

Final tables:

* `customers`
* `orders`
* `products`
* `order_items`

---

## Database Schema

**customers**
Customer ID, Customer Name, Segment, Country, City, State, Postal Code, Region

**orders**
Order ID, Customer ID, Order Date, Ship Date, Ship Mode, Region

**products**
Product ID, Product Name, Category, Sub-Category, UnitPrice

**order_items**
Order ID, Product ID, Quantity, Sales, Discount, Profit

---

## Data Processing

* Load raw dataset into staging table
* Clean and standardize text fields
* Remove duplicates
* Normalize into relational tables
* Perform validation checks

---

## Technologies

* MySQL
* SQL (joins, aggregations, ETL transformations)

---

## Project Structure

```
sql/
├── 01_schema_design.sql
├── 02_data_loading.sql
├── 03_data_cleaning.sql
├── 04_validation_checks.sql
└── 05_kpi_analysis.sql
```
