-- ====================================================================
-- GRADED CHALLENGE 6 - EXTRACT DATA
-- Author         : Putri Joeliya - RMT 020
-- Dataset Source : bigquery-public-data.thelook_ecommerce
-- Purpose        : Extract sales and dimensional data for Data Warehouse
-- ====================================================================


--1. melakukan extract untuk tabel dim_users = dim_user.csv
-- mengmabil data demografi dan lokasi pelanggan dan membuang kolom yang terlalu spesifik karna tidak di perlukan untuk analisis penjualan

SELECT `id` as user_id, `first_name`, `last_name`, `email`, `age`, `gender`, `state`, `city`, `country`, `traffic_source` FROM `bigquery-public-data.thelook_ecommerce.users` 


--2. melakukan extract untuk tabel dim_products = dim_product.csv
-- mengambik katalog produk dan juga kategori, brand, department, dan retail price yang akan digunakan untuk analisis penjualan

SELECT `id` as product_id, `category`, `name`, `brand`, `retail_price`, `department` FROM `bigquery-public-data.thelook_ecommerce.products`


--3. melakukan extract untuk tabel dim_orders = dim_order.csv
-- mengambil semua atribut oprasional pesanan seperti status dan jumlah item yang dipesan, serta tanggal pembuatan pesanan 

SELECT `order_id`, `status`, `created_at`, `num_of_item` FROM `bigquery-public-data.thelook_ecommerce.orders` 

--4. dim_date tidak di extract langsung sebagai csv dari bigquery.
--   karena akan di oprasikasn secara langung melalui pyspark pada tahapan transformation dengan emngextract atribut tanggal dari kolom created_at


--5. melakukan extract untuk tabel fact_sales = fact_sale.csv
-- membuat fact table utama dalam skema bintang yang mengagregasikan metrik penjualan (quantity, total_sales, total_cost, dan total_profit) 
-- serta menghubungkan kunci referensi (foreign key) ke seluruh tabel dimensi (dim_users, dim_products, dim_orders, dan dim_date)
SELECT 
    oi.order_id, 
    oi.product_id, 
    oi.user_id,                             
    DATE(oi.created_at) AS date_id,         
    
   
    COUNT(1) AS quantity,                   
    
    
    ROUND(SUM(oi.sale_price), 2) AS total_sales,   
    
   
    ROUND(SUM(p.cost), 2) AS total_cost,
    
    
    ROUND(SUM(oi.sale_price - p.cost), 2) AS total_profit

FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p 
  ON oi.product_id = p.id

GROUP BY 1, 2, 3, 4;