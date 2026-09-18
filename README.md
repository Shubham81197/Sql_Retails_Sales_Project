# 🛍️ SQL Retail Sales Analysis Project

## 📌 Project Overview

This project focuses on analyzing **retail sales transaction data using SQL** to identify sales trends, customer behavior, category performance, and operational insights.

The project demonstrates my ability to perform **data cleaning, data exploration, SQL querying, aggregation, date/time analysis, customer analysis, and business problem-solving** using PostgreSQL.

---

## 🎯 Project Objectives

The main objectives of this project are:

* Clean and validate retail sales data.
* Analyze overall sales and customer activity.
* Identify top-performing product categories.
* Analyze customer purchasing behavior.
* Find high-value transactions and customers.
* Analyze sales performance by gender and category.
* Identify monthly sales trends.
* Analyze sales according to different time shifts.
* Answer practical business questions using SQL.

---

## 🗂️ Dataset

The dataset contains retail transaction-level information.

### Table: `Retail_Sales`

| Column            | Data Type | Description             |
| ----------------- | --------- | ----------------------- |
| `transactions_id` | INT       | Unique transaction ID   |
| `sale_date`       | DATE      | Date of sale            |
| `sale_time`       | TIME      | Time of sale            |
| `customer_id`     | INT       | Unique customer ID      |
| `gender`          | VARCHAR   | Customer gender         |
| `age`             | INT       | Customer age            |
| `category`        | VARCHAR   | Product category        |
| `quantiy`         | INT       | Quantity purchased      |
| `price_per_unit`  | FLOAT     | Price per unit          |
| `cogs`            | FLOAT     | Cost of goods sold      |
| `total_sale`      | FLOAT     | Total transaction value |

> **Note:** The column `quantiy` is retained as it appears in the original database table.

---

## 🛠️ Tools & Technologies

* **PostgreSQL**
* **SQL**
* **pgAdmin**
* GitHub

### SQL Concepts Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `COUNT`
* `COUNT(DISTINCT)`
* `SUM`
* `AVG`
* `ROUND`
* `CASE WHEN`
* `EXTRACT`
* `TO_CHAR`
* Common Table Expressions (CTEs)
* Date & Time functions
* Filtering
* Aggregation
* Data Cleaning

---

# 🔄 Project Workflow

```text
Raw Retail Data
       ↓
Data Validation
       ↓
Data Cleaning
       ↓
Data Exploration
       ↓
Business Analysis
       ↓
SQL Insights
       ↓
Business Recommendations
```

---

# 🧹 1. Data Cleaning

Before performing analysis, I checked the dataset for missing values across important columns.

The following fields were validated:

* Transaction ID
* Sale Date
* Sale Time
* Customer ID
* Gender
* Age
* Category
* Quantity
* Price per Unit
* COGS
* Total Sale

Records containing NULL values were removed to ensure that the analysis was performed on complete transaction records.

Example:

```sql
DELETE FROM Retail_Sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

# 🔎 2. Data Exploration

### Total Number of Sales Transactions

```sql
SELECT COUNT(*) AS total_sales
FROM Retail_Sales;
```

### Total Number of Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customer
FROM Retail_Sales;
```

### Available Product Categories

```sql
SELECT DISTINCT category
FROM Retail_Sales;
```

---

# 📊 3. Business Analysis

## Question 1 — Sales on a Specific Date

Retrieve all transactions made on **5 November 2022**.

```sql
SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05';
```

---

## Question 2 — Clothing Sales in November 2022

Find clothing transactions where the quantity sold was at least 4 during November 2022.

```sql
SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantiy >= 4;
```

---

## Question 3 — Sales Performance by Category

Calculate total sales and total orders for each category.

```sql
SELECT
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_order
FROM Retail_Sales
GROUP BY category;
```

This helps identify categories generating higher sales and transaction volumes.

---

## Question 4 — Average Customer Age for Beauty Category

```sql
SELECT
    ROUND(AVG(age), 2) AS avg_age
FROM Retail_Sales
WHERE category = 'Beauty';
```

This provides an indication of the average age of customers purchasing products from the Beauty category.

---

## Question 5 — High-Value Transactions

Find transactions where total sales exceeded 1,000.

```sql
SELECT *
FROM Retail_Sales
WHERE total_sale > 1000;
```

This can be used to identify high-value purchases.

---

## Question 6 — Transactions by Gender and Category

Calculate the number of transactions for each gender within each category.

```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_transaction
FROM Retail_Sales
GROUP BY category, gender
ORDER BY category;
```

This helps analyze purchasing activity across customer segments.

---

## Question 7 — Monthly Sales Performance

Calculate the average transaction value for each month.

```sql
SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM Retail_Sales
GROUP BY 1, 2
ORDER BY 1, 2, 3;
```

This analysis can be used to identify monthly sales patterns and periods with higher average transaction values.

---

# 🏆 8. Top 5 Customers by Total Sales

Identify the five customers who generated the highest total sales.

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

This helps identify high-value customers.

---

# 👥 9. Unique Customers by Category

Calculate the number of unique customers purchasing from each category.

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM Retail_Sales
GROUP BY category;
```

This provides insight into customer reach across different product categories.

---

# ⏰ 10. Sales by Time Shift

Sales transactions were divided into three operational shifts:

* **Morning:** Before 12 PM
* **Afternoon:** 12 PM–5 PM
* **Evening:** After 5 PM

```sql
WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12
                THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17
                THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retail_Sales
)

SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

This analysis can help understand when customer transaction activity is highest.

---

# 💡 Business Questions Answered

The project addresses the following business questions:

1. How many sales transactions are recorded?
2. How many unique customers are there?
3. What product categories are available?
4. What transactions occurred on a specific date?
5. What Clothing transactions had high quantities during November 2022?
6. Which categories generate the highest sales?
7. What is the average age of Beauty-category customers?
8. How many high-value transactions are there?
9. Which gender/category combinations have the most transactions?
10. How does average sales value vary by month?
11. Who are the top 5 customers by total sales?
12. How many unique customers purchase from each category?
13. Which time shift has the highest number of orders?

---

# 📈 Key Analytical Skills Demonstrated

Through this project, I demonstrated practical experience with:

### Data Cleaning

* NULL value identification
* Data validation
* Removing incomplete records

### Data Exploration

* Row counts
* Unique customer counts
* Category exploration
* Transaction analysis

### Data Analysis

* Sales aggregation
* Customer segmentation
* Category analysis
* Gender analysis
* Monthly trend analysis
* Time-based analysis
* High-value transaction analysis

### SQL Techniques

* Aggregations
* `GROUP BY`
* `ORDER BY`
* `HAVING`
* `CASE`
* CTEs
* Date functions
* Time functions
* Distinct counts

---

# 📁 Repository Structure

```text
SQL_Retail_Sales_Project/
│
├── README.md
│
├── Retail_Sales.csv
│
└── Retail_Sales_Analysis.sql
```

---

# 🚀 Future Improvements

Possible extensions to this project include:

* Calculate total profit and profit margin.
* Analyze sales by weekday/weekend.
* Calculate customer lifetime value.
* Identify repeat customers.
* Analyze average order value.
* Calculate category-wise profit margins.
* Identify the best-selling products.
* Create customer segmentation.
* Build a Power BI dashboard using the SQL output.
* Add advanced SQL analysis using window functions.

---

# 👨‍💻 Author

**Shubham Sharma**

Aspiring Data Analyst | SQL | Excel | Power BI | Google Sheets

This project was created as part of my practical Data Analytics portfolio to demonstrate SQL and business analysis skills.

