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

<img width="600" height="400" alt="ERD" src="https://github.com/user-attachments/assets/6965c5d6-5009-4ab5-b3f4-7dd96afabefe" />

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
| `README.md` | Project documentation |
