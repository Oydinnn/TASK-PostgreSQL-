-- Active: 1766378548908@@127.0.0.1@5433@erp

CREATE DATABASE  erp;

CREATE TABLE students(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INT,
  password VARCHAR(50),
  photo VARCHAR(255),
  phone VARCHAR(13)
)

CREATE TABLE teachers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INT,
  password VARCHAR(50),
  photo VARCHAR(255),
  experience INT,
  skills VARCHAR(255)
)

CREATE TABLE course(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL,
  duration INT,
  duration_hours INT
)

CREATE TABLE groups(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  teacherId INT REFERENCES teachers(id),
  courseId INT REFERENCES course(id),
  start_date INT,
  start_time INT

)

CREATE TABLE studentGroup(
  id SERIAL PRIMARY KEY,
  studentId INT REFERENCES students(id),
  groupId INT REFERENCES groups(id)
)



