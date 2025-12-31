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
(1, 1, '2025-12-20'),
(2, 2, '2025-10-21'),
(3, 3, '2025-11-20'),
(4, 1, '2025-09-19'),
(5, 5, '2025-12-18');

CREATE TABLE order_items(
  id INT PRIMARY KEY,
  order_id INT REFERENCES orders(id),
  product_id INT REFERENCES products(id),
  quantity INT
)

INSERT INTO order_items (id, order_id, product_id, quantity) VALUES
(1, 1, 1, 2), 
(2, 1, 2, 1),
(3, 2, 3, 1),
(4, 3, 4, 3),
(5, 3, 1, 1),
(6, 4, 5, 1),
(7, 5, 2, 2);

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

-- Jami buyurtmalar sonini aniqlash.
SELECT COUNT(id) FROM orders;

-- Har bir shahar bo‘yicha mijozlar sonini chiqarish.
SELECT 
    city AS shahar,
    COUNT(*) AS mijozlar_soni
FROM customers
GROUP BY city
ORDER BY mijozlar_soni DESC;

-- Har bir mahsulot nechta marta buyurtma qilinganini chiqarish.
SELECT
  p.name AS mahsulot_nomi,
  COUNT(oi.product_id) AS buyurtmalar_soni
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id
ORDER BY buyurtmalar_soni DESC;

-- Eng qimmat va eng arzon mahsulot narxini aniqlash.

SELECT * FROM products ORDER BY price DESC LIMIT 1;

SELECT * FROM products ORDER BY price LIMIT 1;

-- Har bir buyurtmadagi jami mahsulot sonini hisoblash.

SELECT 
p.name as product_name,
COUNT(oi.quantity) as count_product 
FROM products p
LEFT JOIN order_items oi on p.id = oi.product_id 
GROUP BY p.id
ORDER BY count_product;

-- 1 martadan ko‘p sotilgan mahsulotlarni chiqarish.
SELECT
p.id,
p.name as product_name,
COUNT(oi.quantity) as sotilganlarSoni
FROM products p
LEFT JOIN order_items oi on p.id = oi.product_id
GROUP BY p.id
HAVING COUNT(oi.product_id) > 1; 

--  3-qism — JOIN (INNER JOIN)
-- Buyurtma raqami va uni bergan mijoz ismini chiqarish.

SELECT 
o.id, 
c.full_name as customerName
FROM orders o
LEFT JOIN customers c on o.customer_id = c.id;


-- Buyurtma raqami, mahsulot nomi va miqdorini chiqarish.

SELECT
oi.order_id as buyurtmaRaqami,
p.name as mahsulotNomi,
quantity as miqdori
FROM order_items oi 
LEFT JOIN products p on p.id = oi.product_id;

-- Buyurtma raqami, mahsulot nomi va umumiy summani chiqarish

SELECT
oi.order_id as buyurtmaRaqami,
p.name as mahsulotNomi,
SUM(oi.quantity * p.price) as umumiySumma
FROM order_items oi
LEFT JOIN products p on p.id = oi.product_id
GROUP BY oi.order_id, p.id
ORDER BY oi.order_id;;

-- (price × quantity).
SELECT
p.name,
p.price,
oi.quantity
FROM order_items oi
LEFT JOIN products p on p.id = oi.product_id;

-- Mijoz ismi va u bergan buyurtmalar sanasini chiqarish.
SELECT
customers.full_name as name,
orders.order_date as date
FROM orders
LEFT JOIN customers on customers.id = orders.id;

-- Faqat buyurtmasi mavjud bo‘lgan mijozlarni chiqarish.
SELECT DISTINCT
c.id,
c.full_name
FROM customers c
INNER JOIN orders o on o.customer_id = c.id; 


-- Jami summasi 1 000 000 dan katta bo‘lgan buyurtmalarni chiqarish.
SELECT
p.name,
sum(p.price * oi.quantity) as summaJami
FROM products p
JOIN order_items oi on oi.product_id = p.id
GROUP BY p.id
HAVING sum(p.price * oi.quantity) > 1000000
ORDER BY summaJami DESC;


-- 🟣 4-qism — Bir nechta JOINlar
-- -- Mijoz ismi, mahsulot nomi va buyurtma sanasini chiqarish.
SELECT
c.full_name,
p.name, 
o.order_date
FROM orders o
JOIN customers c on c.id = o.customer_id
JOIN order_items oi on oi.order_id = o.id
JOIN products p on p.id = oi.product_id
ORDER BY o.order_date;

-- Har bir mijoz qancha pul sarflaganini hisoblash.
SELECT
c.id,
c.full_name,
SUM(p.price * oi.quantity) as summa
FROM order_items oi
JOIN products p on p.id = oi.product_id
JOIN orders o on o.id = oi.order_id
JOIN customers c on c.id = o.customer_id
GROUP BY c.id, c.full_name;
-- Eng ko‘p buyurtma bergan mijozni topish.
SELECT
c.id,
c.full_name,
SUM(p.price * oi.quantity) as summ
FROM order_items oi
JOIN products p on p.id = oi.product_id
JOIN orders o on o.id = oi.order_id
JOIN customers c on c.id = o.customer_id
GROUP BY c.id, c.full_name
ORDER BY summ DESC LIMIT 1;
-- Eng ko‘p sotilgan mahsulotni aniqlash.
SELECT 
p.id,
p.name,
SUM(oi.quantity) as soni
FROM order_items oi
JOIN products p on p.id = oi.product_id
GROUP BY p.id, p.name
ORDER BY soni DESC
LIMIT 1;
-- Har bir shahar bo‘yicha jami savdo summasini chiqarish.
SELECT
c.city,
SUM(oi.quantity * p.price) as summ
FROM order_items oi
JOIN products p on p.id = oi.product_id
JOIN orders o on o.id = oi.order_id
JOIN customers c on c.id = o.customer_id
GROUP BY c.city
ORDER BY summ;
-- 2 tadan ko‘p mahsulot bo‘lgan buyurtmalarni chiqarish.
SELECT
o.id
FROM orders o
JOIN order_items oi on oi.order_id = o.id
JOIN products p on p.id = oi.product_id
GROUP BY o.id
HAVING COUNT(oi.quantity) > 2;

SELECT o.id
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id
HAVING COUNT(*) > 2;
 