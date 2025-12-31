-- Active: 1766419843621@@127.0.0.1@5433@n26
CREATE DATABASE TRIGGER;

CREATE TABLE users (
    id SERIAL,
    name VARCHAR(20),
    balance DECIMAL
)

INSERT INTO
    users (name, balance)
VALUES ('ali', 5000),
    ('vali', 40000),
    ('malika', 8900)
RETURNING
    *;

SELECT * FROM users;
-- 1-misol: INSERT bo‘lganda xabar chiqarish
CREATE or REPLACE FUNCTION userQushish()
RETURNS TRIGGER AS $$
BEGIN
  RAISE NOTICE 'Yangi user qushildi: %', NEW.name;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_qushish
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION userQushish();

INSERT INTO users (name, balance) VALUES ('abduvali', 1000);

SELECT * FROM users;

-- 2-misol: Yosh manfiy bo‘lmasligi

ALTER TABLE users ADD COLUMN age INTEGER DEFAULT 1;

SELECT * FROM users;


CREATE OR REPLACE FUNCTION check_age()
RETURNS TRIGGER AS $$
BEGIN 
  IF NEW.age < 0 THEN
  RAISE EXCEPTION 'yosh manfiy bulishi mumkin emas';
  END IF;
  RETURN NEW;
END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER trg_check_age
BEFORE INSERT OR UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION check_age();


insert into users (name, balance, age) VALUES('madina', 20000, 22);
SELECT * FROM users;


--  3-misol: updated_at avtomatik to‘lishi


CREATE OR REPLACE FUNCTION set_updated_time()
RETURNS TRIGGER AS $$
BEGIN
NEW.updated_at = now();
RETURN NEW;
END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER trg_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_updated_time();

alter table users add column updated_at timestamp default now();

-- 4-misol: DELETE bo‘lganda log yozish

CREATE OR REPLACE FUNCTION log_user_delete()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_logs(user_id, deleted_at)
  VALUES(OLD.id, now());
  RETURN OLD;
END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER trg_user_delete
AFTER DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION log_user_delete();


CREATE TABLE user_logs(
  id SERIAL PRIMARY KEY,
  user_id INTEGER,
  deleted_at TIMESTAMP DEFAULT now()
);
DELETE FROM users WHERE id = 8;

