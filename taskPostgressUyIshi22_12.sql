-- Active: 1766419843621@@127.0.0.1@5433@erp
CREATE TABLE customers(
  id INT PRIMARY KEY,
  full_name VARCHAR(50),
  city VARCHAR(50)
)

INSERT INTO customers (id, full_name, city) VALUES
(1, 'Ali Valiyev', 'Toshkent'),
(2, 'Zilola Karimova', 'Samarqand'),
(3, 'Jamshid Ahmadov', 'Buxoro'),
(4, 'Madina Sobirova', 'Andijon'),
(5, 'Otabek Rahimov', 'Farg''ona');

CREATE TABLE products(
id INT PRIMARY KEY,
name VARCHAR(50),
price NUMERIC
)

INSERT INTO products (id, name, price) VALUES
(1, 'Smartphone Samsung A54', 45000),
(2, 'Noutbuk Lenovo IdeaPad', 120000),
(3, 'Televizor LG 55"', 850000),
(4, 'Naushnik AirPods Pro', 3000000),
(5, 'Planshet iPad Air', 95000);

CREATE TABLE orders(
  id INT PRIMARY KEY,
  customer_id INT REFERENCES customers(id),
  order_date DATE
)

INSERT INTO TABLE orders(
  (1, 1, 11)
)

INSERT INTO orders (id, customer_id, order_date) VALUES
(1, 1, '2025-12-20'),   -- Ali Valiyev (Toshkent)
(2, 2, '2025-10-21'),   -- Zilola Karimova (Samarqand)
(3, 3, '2025-11-20'),   -- Jamshid Ahmadov (Buxoro) — bugun
(4, 1, '2025-09-19'),   -- Ali Valiyev yana bir buyurtma
(5, 5, '2025-12-18');   -- Otabek Rahimov (Farg'ona)

CREATE TABLE order_items(
  id INT PRIMARY KEY,
  order_id INT REFERENCES orders(id),
  product_id INT REFERENCES products(id),
  quantity INT
)

-- 1-qism
SELECT * FROM customers;

SELECT * from customers WHERE city = 'Toshkent';

SELECT * from products WHERE price > 100000

SELECT * from products ORDER BY price DESC;

SELECT DISTINCT city FROM customers;


SELECT * FROM orders 
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY order_date DESC;

-- 2-qism
SELECT COUNT(id) FROM orders;

SELECT 
    city AS shahar,
    COUNT(*) AS mijozlar_soni
FROM customers
GROUP BY city
ORDER BY mijozlar_soni DESC;