-- Ecommerce Database

-----------------------------------------------------------
-- TABLE 1: categories
-- Created first because products depends on it (foreign key)
-- ------------------------------------------------------------

CREATE TABLE categories (
    id   SERIAL PRIMARY KEY,   -- Auto-incremented unique ID
    category_name VARCHAR(100) NOT NULL, -- Category name is required
    description   TEXT                  -- Optional long description
);


-- ------------------------------------------------------------
-- TABLE 2: customers
-- Stores personal information about each customer
-- ------------------------------------------------------------

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,       -- Auto-incremented unique ID
    first_name  VARCHAR(50) NOT NULL,     -- First name is required
    last_name   VARCHAR(50) NOT NULL,     -- Last name is required
    email       VARCHAR(150) UNIQUE NOT NULL -- Email must be unique and required
);


-- ------------------------------------------------------------
-- TABLE 3: products
-- Stores product details and links to categories
-- ------------------------------------------------------------

CREATE TABLE products (
    id     SERIAL PRIMARY KEY,            -- Auto-incremented unique ID
    product_name   VARCHAR(150) NOT NULL,          -- Product name is required
    price          DECIMAL(10, 2) NOT NULL,        -- Price with 2 decimal places (e.g. 199.99)
    stock_quantity INT DEFAULT 0,                  -- Defaults to 0 if not provided
    category_id    INT REFERENCES categories(category_id) ON DELETE SET NULL
    -- FOREIGN KEY: links to categories
    -- ON DELETE SET NULL: if category is deleted, product remains but category_id becomes NULL
);


-- ------------------------------------------------------------
-- TABLE 4: orders
-- Stores orders placed by customers
-- ------------------------------------------------------------

CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,                                           -- Auto-incremented unique ID
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE, -- FOREIGN KEY to customers
    -- ON DELETE CASCADE: if customer is deleted, their orders are deleted too
    order_date  DATE DEFAULT CURRENT_DATE,  -- Automatically saves today's date
    status      VARCHAR(50) DEFAULT 'pending' -- Default status is 'pending'
);


-- ------------------------------------------------------------
-- TABLE 5: order_items
-- Stores each product inside an order (bridge table)
-- Links orders and products together
-- ------------------------------------------------------------

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,                                         -- Auto-incremented unique ID
    order_id      INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE, -- FOREIGN KEY to orders
    product_id    INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE, -- FOREIGN KEY to products
    -- ON DELETE CASCADE: if order or product is deleted, the item is deleted too
    quantity      INT NOT NULL,               -- Number of units ordered
    unit_price    DECIMAL(10, 2) NOT NULL     -- Price at the time of purchase (may differ from current price)
);


-- ------------------------------------------------------------
-- Insert into categories (no dependencies)
-- ------------------------------------------------------------

INSERT INTO categories (category_name, description) VALUES
('Electronics',    'Devices and gadgets'),
('Clothing',       'Men and women apparel'),
('Books',          'Fiction and non-fiction books'),
('Home & Kitchen', 'Furniture and kitchen tools');


-- ------------------------------------------------------------
-- Insert into customers (no dependencies)
-- ------------------------------------------------------------

INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Johnson', 'alice@email.com'),
('Bob',   'Smith',   'bob@email.com'),
('Clara', 'Davis',   'clara@email.com'),
('David', 'Lee',     'david@email.com');


-- ------------------------------------------------------------
-- Insert into products (depends on categories)
-- category_id refers to the IDs inserted above
-- ------------------------------------------------------------

INSERT INTO products (product_name, price, stock_quantity, category_id) VALUES
('Laptop',          999.99, 10,  1), -- Electronics
('T-Shirt',          19.99, 100, 2), -- Clothing
('PostgreSQL Book',  49.99, 50,  3), -- Books
('Coffee Maker',     79.99, 30,  4), -- Home & Kitchen
('Headphones',      149.99, 25,  1); -- Electronics


-- ------------------------------------------------------------
-- Insert into orders (depends on customers)
-- customer_id refers to the IDs inserted above
-- ------------------------------------------------------------

INSERT INTO orders (customer_id, status) VALUES
(1, 'completed'), -- Alice's order
(2, 'pending'),   -- Bob's order
(3, 'completed'), -- Clara's order
(4, 'cancelled'); -- David's order


-- ------------------------------------------------------------
-- Insert into order_items (depends on orders and products)
-- ------------------------------------------------------------

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 999.99), -- Order 1: 1 Laptop
(1, 5, 2, 149.99), -- Order 1: 2 Headphones
(2, 2, 3,  19.99), -- Order 2: 3 T-Shirts
(3, 3, 1,  49.99), -- Order 3: 1 PostgreSQL Book
(4, 4, 1,  79.99); -- Order 4: 1 Coffee Maker
