# E-Commerce Operations Analysis (SQL)

End-to-end SQL analysis of a real Brazilian e-commerce platform (Olist), covering 
revenue trends, seller performance, and product category health across 100,000+ orders.

---

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle

**Size:** ~100,000 orders across 9 relational tables covering customers, sellers, 
products, payments, and reviews.

---

## Tools

- SQLite (query execution)
- DuckDB (initial data exploration)
- VSCode with SQLite extension

---

## Business Questions

### 1. Monthly Revenue & Quality Trend (2017–2018)
How did total revenue, order volume, average order value, and customer satisfaction 
trend month-over-month across delivered orders? Which months saw quality dip below 
acceptable thresholds?

### 2. Seller Performance Ranking
Which sellers generated the most revenue in 2017? How do they rank within their 
own state? Which high-volume sellers have dangerously low review scores?

### 3. Product Category Drop-off Analysis
Across the top 10 categories by order volume, what percentage of orders were 
successfully delivered vs cancelled? Which categories carry above-average 
cancellation risk?

---

## Key Findings

- 
- 
- 
- 
-

---

## Skills Demonstrated

- Multi-table JOINs across 4–5 tables simultaneously
- Common Table Expressions (CTEs) with multiple chained layers
- Window functions: `RANK()`, `SUM() OVER()`
- Conditional aggregation: `COUNT(CASE WHEN ... END)`
- Date filtering and `strftime` formatting in SQLite
- Dynamic flagging using window-function averages as benchmarks

---

## How to Run

1. Download the dataset from the Kaggle link above
2. Open VSCode with the SQLite extension installed
3. Load all CSV files into a SQLite database
4. Run queries in order: `01_monthly_revenue_quality.sql` → 
`02_seller_performance.sql` → `03_category_dropoff.sql`

---

## Files

| File | Business Question |
|------|------------------|
| `01_monthly_revenue_quality.sql` | Monthly revenue and satisfaction trends |
| `02_seller_performance.sql` | Seller revenue ranking by state |
| `03_category_dropoff.sql` | Category delivery vs cancellation rates |

---

*Dataset credit: Olist, the largest department store in Brazilian marketplaces.*
