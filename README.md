# 🍕 Pizza Sales Analysis using SQL

## 📊 Project Overview  
This SQL-based data analysis project explores sales data from a pizza restaurant to extract meaningful business insights and performance metrics. The dataset includes order-level information such as pizza type, size, category, quantity, price, and order date.

The project focuses on calculating key performance indicators (KPIs), identifying sales trends, and uncovering the best and worst-performing pizzas to help guide business decisions for inventory, marketing, and customer preferences.

---

## 🎯 Objectives
- Analyze total revenue, average order value, and product performance.
- Uncover daily and monthly order trends.
- Determine top and bottom-performing pizzas by revenue, quantity sold, and order frequency.
- Provide clear SQL-based insights to support data-driven decision-making.

---

## 🛠️ Tools Used
- **SQL Server** (or any RDBMS like MySQL, PostgreSQL, SQLite)
- **SQL** – For querying and analyzing data

---

## 📁 Dataset Structure
The project uses a single table named `pizza_sales` with the following relevant fields:
- `order_id`
- `order_date`
- `pizza_name`
- `pizza_category`
- `pizza_size`
- `quantity`
- `total_price`

---

## 📌 Key SQL Insights & Queries

### ✅ A. **KPIs**
- **Total Revenue**  
- **Average Order Value**  
- **Total Pizzas Sold**  
- **Total Orders**  
- **Average Pizzas Per Order**

### 📅 B. **Daily Trend of Orders**  
Analyze how many orders occur each day of the week.

### 📆 C. **Monthly Trend of Orders**  
Reveal seasonal ordering behavior by month.

### 📊 D. **% of Sales by Pizza Category**  
Compare revenue contributions across categories (e.g., Classic, Veggie, Supreme).

### 🍕 E. **% of Sales by Pizza Size**  
Discover the most profitable pizza sizes (e.g., S, M, L, XL).

### 📦 F. **Pizzas Sold by Category (for February)**  
Identify top-selling categories in a specific month.

### 💰 G–L. **Performance Rankings**
- **Top & Bottom 5 Pizzas by Revenue**
- **Top & Bottom 5 Pizzas by Quantity Sold**
- **Top & Bottom 5 Pizzas by Order Count**

Each analysis helps identify what items should be promoted, restocked, or reconsidered based on their performance.

---

## 📌 Filtering by Category or Size  
Additional filtering can be done using SQL `WHERE` clauses, for example:

```sql
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders DESC;
