-- Active: 1766378548908@@127.0.0.1@5433@n26
-- 1-QISM

\l \c n26

CREATE TABLE students (
    id SERIAL AUTO_INCREMENT,
    full_name VARCHAR(50),
    age INT,
    gender VARCHAR(50),
    group_name VARCHAR(50),
    created_at DATE NOW()
);

ALTER TABLE students ADD PRIMARY KEY (id);

ALTER TABLE students ALTER COLUMN created_at SET DEFAULT NOW();

INSERT INTO
    students (
        id,
        full_name,
        age,
        gender,
        group_name
    )
VALUES (
        1,
        "Ali Aliyev",
        23,
        "male",
        "Backend"
    )

INSERT INTO
    students (
        full_name,
        age,
        gender,
        group_name
    )
VALUES (
        'Ali Aliyev',
        23,
        'male',
        'Backend'
    ),
    (
        'Vali Karimov',
        21,
        'male',
        'Backend'
    ),
    (
        'Zilola Usmonova',
        20,
        'female',
        'Frontend'
    ),
    (
        'Jamshid To''rayev',
        24,
        'male',
        'Backend'
    ),
    (
        'Madina Sobirova',
        19,
        'female',
        'Frontend'
    ),
    (
        'Otabek Rahimov',
        22,
        'male',
        'Mobile'
    ),
    (
        'Sevara Xolmatova',
        21,
        'female',
        'Frontend'
    ),
    (
        'Rustam Abdullayev',
        25,
        'male',
        'Backend'
    ),
    (
        'Nilufar Yunusova',
        20,
        'female',
        'Mobile'
    ),
    (
        'Bekzod Ismoilov',
        23,
        'male',
        'Backend'
    );

SELECT * FROM students WHERE age > 17;

SELECT * FROM students WHERE group_name LIKE 'Backend';

SELECT COUNT(id) FROM students;

SELECT * FROM students WHERE gender LIKE 'female';

-- 2-QISM

SELECT * FROM students ORDER BY age DESC;

SELECT * FROM students ORDER BY age LIMIT 3;

SELECT * FROM students ORDER BY created_at DESC;

-- 3-QISM

SELECT AVG(age) FROM students;

SELECT MIN(age) FROM students;
SELECT MAX(age) FROM students;


-- mustaqil bajarish
