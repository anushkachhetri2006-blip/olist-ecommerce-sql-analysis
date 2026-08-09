
# Brazilian E-Commerce Sales & Customer Analytics using SQL

## Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using MySQL.

The dataset contains approximately 100K e-commerce orders made between 2016 and 2018 and includes information about customers, orders, products, sellers, payments, reviews, delivery performance, and locations.

The objective of this project is to use SQL to transform raw transactional data into meaningful business insights related to revenue, customer behavior, product performance, payments, delivery, and customer satisfaction.

---

## Business Objective

The analysis focuses on answering key business questions such as:

- How does revenue change over time?
- Which products and categories generate the most revenue?
- Who are the highest-value customers?
- How many customers make repeat purchases?
- What is the average order value?
- Which payment methods are most commonly used?
- How efficiently are orders being delivered?
- Are late deliveries associated with lower review scores?
- Which categories receive the highest customer ratings?
- What percentage of total revenue comes from top customers or products?

---

## Dataset

**Dataset:** Brazilian E-Commerce Public Dataset by Olist

The dataset contains multiple relational tables covering different aspects of the e-commerce business.

### Tables Used

| Table | Description |
|---|---|
| `olist_customers_dataset` | Customer and customer location information |
| `olist_orders_dataset` | Order details, status, and timestamps |
| `olist_order_items_dataset` | Products purchased within each order |
| `olist_order_payments_dataset` | Payment methods, installments, and payment values |
| `olist_order_reviews_dataset` | Customer review scores and comments |
| `olist_products_dataset` | Product information and categories |
| `olist_sellers_dataset` | Seller information and location |
| `olist_geolocation_dataset` | Brazilian ZIP-code-level geographic information |
| `product_category_name_translation` | Product category translations |

---

## Tools & Technologies

- MySQL
- SQL
- MySQL Workbench
- GitHub

### SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions
- INNER JOIN
- LEFT JOIN
- CASE Statements
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- Running Totals
- Percentage Calculations
- Date & Time Functions
- Views

---

## 🧹 Data Exploration & Cleaning

Before performing the analysis, the dataset was explored and validated for data quality.

The following checks were performed:

- Table structure and column validation
- Row count verification
- NULL value analysis
- Duplicate key detection
- Blank value checks
- Invalid numeric value checks
- Referential integrity checks
- Date and timestamp validation
- Order status validation
- Review score validation
- Consistency checks across related tables

Expected business-related NULL values were retained where appropriate rather than automatically removing them.

For example, delivery timestamps may be missing for orders that were cancelled or not delivered.

---

##  Business Analysis

The SQL analysis covers the following areas:

### Sales Analysis

- Total revenue
- Monthly revenue trends
- Yearly revenue trends
- Revenue by state
- Revenue by city
- Monthly growth
- Revenue contribution

### Customer Analysis

- Top customers by spending
- Repeat customers
- Average order value
- Customer lifetime value
- Customer ranking
- Revenue contribution by customer

### Product Analysis

- Best-selling products
- Highest-revenue products
- Best-performing product categories
- Average product price
- Top products within each category

### Delivery Analysis

- Average delivery time
- Late delivery analysis
- Delivery performance by seller
- Estimated vs actual delivery performance

### Payment Analysis

- Most frequently used payment methods
- Payment value by payment type
- Installment analysis

### Review Analysis

- Average review score
- Review score by product category
- Relationship between delivery performance and customer satisfaction

---

## Advanced SQL Analysis

Advanced SQL techniques were used to answer more complex business questions.

Examples include:

- Common Table Expressions (CTEs)
- Window Functions
- Customer ranking
- Product ranking within categories
- Running revenue totals
- Monthly revenue growth
- Revenue contribution percentage
- Top-N analysis
- Customer segmentation logic

---

## SQL Views

Three reusable SQL views were created to simplify recurring analysis:

### 1. Customer Revenue

Provides total customer spending based on payment value.

### 2. Monthly Revenue

Provides monthly revenue trends for time-based analysis.

### 3. Category Revenue

Provides revenue by product category.

These views allow frequently used analytical queries to be accessed without rewriting the underlying joins and aggregations.

---

## Key Business Insights

> The quantitative results in this section are based on the SQL analysis performed on the dataset.

### Revenue

- Total customer payment value: 3556903.96
- Highest revenue month: 11
- Highest revenue year: 2017

### Customers

- Top customer revenue contribution: 13440
- Number of repeat customers: 186
- Average order value: 137.46

### Products

- Highest-revenue category: beleza_saude
- Highest-revenue product/category contribution: 162993.75

### Delivery

- Average delivery time: 12.4675 days
- Percentage of late deliveries: 8.06 %

### Reviews

- Average review score:4.01
- Lowest-rated category: informatica_acessorios


## 📁 Project Structure

```text
olist-ecommerce-sql-analysis/
│
├── SQL/
│   ├── 01_Data_Exploration.sql
│   ├── 02_Data_Cleaning.sql
│   ├── 03_Business_Analysis.sql
│   ├── 04_Advanced_SQL.sql
│   └── 05_Views.sql
│
└── README.md
