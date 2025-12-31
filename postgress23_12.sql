-- Active: 1766419843621@@127.0.0.1@5433@dars12
-- create database 12-dars;

create table users(
    id serial primary key,
    username varchar(20) not null unique,
    age int not null
);

create table orders(
    id serial,
    user_id int references users(id),
    amount decimal not null,
    created_at timestamp default now()
);

insert into users(username, age) values
('alice1', 30),
('bob2', 30),
('charlie2', 35),
('david2', 28),
('eve2', 22),
('frank2', 40),
('grace2', 27),
('heidi2', 33),
('ivan2', 29),
('judy2', 31);

insert into orders(user_id, amount,created_at) values
(1, 100.50,'2024-03-01 10:00:00'),
(2, 200.75,'2025-01-02 11:30:00'),
(1, 150.00,'2024-03-03 09:15:00'),
(3, 300.20,'2025-01-04 14:45:00'),
(4, 250.00,'2024-01-05 16:20:00'),
(2, 175.25,'2024-02-06 12:10:00'),
(5, 400.00,'2025-05-07 13:50:00'),
(6, 500.50,'2025-06-08 15:30:00'),
(7, 600.75,'2024-05-09 17:40:00'),
(8, 700.80,'2025-01-10 18:55:00'),
(9, 800.90,'2024-02-11 19:05:00'),
(10, 900.00,'2024-01-12 20:15:00');

-- 1) Userlar necha martta zakaz berganini aniklovchi sql code yozish
SELECT user_id, count(*) as order_count from orders GROUP BY user_id; 

-- har bir userning umumiy summasi

SELECT user_id, sum(amount) as summa from orders GROUP BY user_id;

SELECT 
user_id, users.username, sum(amount) as order_sum from orders 
inner join users on users.id = orders.user_id
GROUP BY user_id, users.username;

-- iktadan kop order qilgan zakaz qilgan userlarni chiqarish

-- SELECT 
-- user_id, users.username, count(amount) as order_soni from orders
-- inner join users on users.id = orders.user_id
-- GROUP BY user_id, users.username
-- HAVING COUNT(amount) > 1;

SELECT
user_id, u.username, COUNT(*) from orders o
INNER JOIN users u on u.id = o.user_id
GROUP BY user_id, u.username
HAVING COUNT(*) >= 2;

-- eng kop pul sarflagan userlarni yuqorida chiqarsin
SELECT
user_id, u.username, sum(amount) as total FROM orders o
INNER JOIN users u on u.id = o.user_id
GROUP BY user_id, u.username
ORDER BY total DESC;

-- urtacha xarajatlarni topamiz, o'rtachadan ko'p xarajat qilganlarni topish

SELECT user_id, amount FROM orders
WHERE amount > (SELECT AVG(amount) from orders)


-- SELECT user_id, u.name, amount FROM orders o
-- INNER JOIN users u on u.id = o.user_id
-- -- WHERE amount > (SELECT AVG(amount) from o)

-- eng oxirgi zakaz bergan userlar

SELECT * from users u
INNER JOIN orders o ON u.id = o.user_id
ORDER BY o.created_at DESC LIMIT 3;

 SELECT user_id, created_at FROM orders 
 WHERE created_at = (SELECT MAX(created_at) FROM orders);

--  hamma userlarni um

SELECT user_id from
(SELECT user_id, sum(amount) as amount from orders GROUP BY user_id) as sum_ordered
WHERE amount > (SELECT avg(sum_ordered.amount) from 
(SELECT user_id, sum(amount) as amount from orders GROUP BY user_id) as sum_ordered);
