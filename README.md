## 📌 Project Overview

This project creates and manages a relational database for an online store.  
It covers real-world scenarios such as managing customers, products, categories, and orders.

## 🧠 SQL Concepts Covered

| Concept | Description |
|---|---|
| `CREATE TABLE` | Building all tables from scratch |
| `PRIMARY KEY` | Unique identifier for each table |
| `FOREIGN KEY` | Linking tables together |
| `ON DELETE CASCADE` | Automatically delete related records |
| `ON DELETE SET NULL` | Set field to NULL when related record is deleted |
| `INSERT INTO` | Adding sample data to all tables |
| `ALTER TABLE` | Modifying table structure after creation |
| `UPDATE` | Updating existing records *(coming soon)* |

## 🗂️ Database Schema

<img width="500" height="300" alt="ERD" src="https://github.com/user-attachments/assets/6965c5d6-5009-4ab5-b3f4-7dd96afabefe" />

## 📋 Tables Description

### `categories`
Stores product categories (e.g. Electronics, Clothing).

| Column | Type | Notes |
|---|---|---|
| category_id | SERIAL | Primary Key |
| category_name | VARCHAR(100) | Required |
| description | TEXT | Optional |

---

### `customers`
Stores customer personal information.

| Column | Type | Notes |
|---|---|---|
| customer_id | SERIAL | Primary Key |
| first_name | VARCHAR(50) | Required |
| last_name | VARCHAR(50) | Required |
| email | VARCHAR(150) | Unique, Required |
| phone | VARCHAR(20) | Added via ALTER TABLE |

---

### `products`
Stores product details and links each product to a category.

| Column | Type | Notes |
|---|---|---|
| product_id | SERIAL | Primary Key |
| product_name | VARCHAR(150) | Required |
| price | DECIMAL(10,2) | Required |
| stock_quantity | INT | Default 0 |
| category_id | INT | Foreign Key → categories |
| discount | DECIMAL(5,2) | Added via ALTER TABLE, Default 0.00 |

---

### `orders`
Stores orders placed by customers.

| Column | Type | Notes |
|---|---|---|
| order_id | SERIAL | Primary Key |
| customer_id | INT | Foreign Key → customers |
| order_date | DATE | Default current date |
| order_status | VARCHAR(50) | Default 'pending' |

---

### `order_items`
Bridge table that stores each product inside an order.

| Column | Type | Notes |
|---|---|---|
| order_item_id | SERIAL | Primary Key |
| order_id | INT | Foreign Key → orders |
| product_id | INT | Foreign Key → products |
| quantity | INT | Required |
| unit_price | DECIMAL(10,2) | Price at time of purchase |

---

## 🔗 Relationships & ON DELETE Rules

| Relationship | Rule | Behaviour |
|---|---|---|
| products → categories | ON DELETE SET NULL | If category deleted, product stays but category_id becomes NULL |
| orders → customers | ON DELETE CASCADE | If customer deleted, all their orders are deleted too |
| order_items → orders | ON DELETE CASCADE | If order deleted, all its items are deleted too |
| order_items → products | ON DELETE CASCADE | If product deleted, related order items are deleted too |

---

## 📁 Project Files

| File | Description |
|---|---|
| `ecommerce_db.sql` | Full SQL script with all queries and comments |
| `erd_ecommerce.html` | Visual ERD diagram (open in browser) |
| `README.md` | Project documentation |
