-- ====================================================================
-- GRADED CHALLENGE 6 - Data Loading
-- Name : Putri Joeliya
-- Batch : CODA-RMT-020
-- ====================================================================
-- 1. Users Dimension Table 
CREATE TABLE dim_users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    traffic_source VARCHAR(50)
);

-- 2. Products Dimension Table
CREATE TABLE dim_products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(100),
    brand VARCHAR(100),
    department VARCHAR(50),
    retail_price NUMERIC(10, 2)
);

-- 3. Orders Dimension table
CREATE TABLE dim_orders (
    order_id INT PRIMARY KEY,
    status VARCHAR(50),
    num_of_item INT,
    created_at TIMESTAMP
);

-- 4. Date Dimension Table 
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter VARCHAR(10),
    year INT,
    day_of_week VARCHAR(20)
);


-- 5. Fact Sales Table
CREATE TABLE fact_sales (
    order_id INT REFERENCES dim_orders(order_id),
    product_id INT REFERENCES dim_products(product_id),
    user_id INT REFERENCES dim_users(user_id),
    date_id DATE REFERENCES dim_date(date_id),
    quantity INT,
    total_sales NUMERIC(10, 2),
    total_cost NUMERIC(10, 2),
    total_profit NUMERIC(10, 2),
    
    -- Primary Key (compisite)
    PRIMARY KEY (order_id, product_id)
);


SELECT * FROM dim_users LIMIT 5;
SELECT * FROM dim_products LIMIT 5;
SELECT * FROM dim_orders LIMIT 5;
SELECT * FROM dim_date LIMIT 5;
SELECT * FROM fact_sales LIMIT 5;

TRUNCATE TABLE fact_sales, dim_date, dim_orders, dim_products, dim_users CASCADE;