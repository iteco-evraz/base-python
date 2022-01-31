CREATE TABLE students
(
    student_number INT AUTO_INCREMENT PRIMARY KEY,
    student_name   VARCHAR(100),
    dept_name      VARCHAR(100),
    subject        VARCHAR(100),
    marks          INT
);

INSERT INTO students (student_name, dept_name, subject, marks)
VALUES ('Tom', 'CS', 'Programming', 90),
       ('Tom', 'CS', 'Database', 100),
       ('Rob', 'CS', 'Programming', 95),
       ('Fred', 'CS', 'Programming', 80),
       ('Alter', 'CS', 'Database', 100),
       ('Jason', 'CS', 'Database', 98),
       ('Jason', 'CS', 'Programming', 80),
       ('John', 'English', 'Literature', 75),
       ('Alicia', 'English', 'History', 60),
       ('Sofia', 'English', 'History', 70),
       ('Sofia', 'English', 'Grammar', 70);

CREATE INDEX ix_student_name ON students(student_name);
DROP INDEX ix_student_name ON students;

SELECT * FROM students
WHERE student_name = 'Sofia';

SELECT SUM(marks) AS total_marks
FROM students;

SELECT student_name, SUM(marks) AS total_marks
FROM students
GROUP BY student_name;


SELECT student_name, AVG(marks) AS avg_marks
FROM students
GROUP BY student_name;


SELECT student_name, MIN(marks) AS min_mark, MAX(marks) AS max_mark
FROM students
GROUP BY student_name;

SELECT COUNT(*)
FROM students;

SELECT DISTINCT student_name
FROM students;

SELECT COUNT(DISTINCT student_name) as total_students
FROM students;

--

SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
#      , ROW_NUMBER() OVER (ORDER BY marks) as row_num
     , ROW_NUMBER() OVER (ORDER BY student_name) as row_num
FROM students;

SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
#      , ROW_NUMBER() OVER (ORDER BY marks) as row_num
     , ROW_NUMBER() OVER (
    PARTITION BY dept_name
    ORDER BY marks
    ) as row_num
FROM students;

-- RANK


SELECT student_name
     , dept_name
     , subject
     , marks
     , ROW_NUMBER() OVER (
    PARTITION BY dept_name
    ORDER BY marks
    )                                     as row_num
     , RANK() OVER (ORDER BY marks)       AS rank_num
     , DENSE_RANK() OVER (ORDER BY marks) as dense_rank_num
FROM students;

--
CREATE TABLE sales
(
    sales_employee VARCHAR(50)    NOT NULL,
    fiscal_year    INT            NOT NULL,
    sale           DECIMAL(14, 2) NOT NULL,
    PRIMARY KEY (sales_employee, fiscal_year)
);

INSERT INTO sales(sales_employee, fiscal_year, sale)
VALUES ('Bob', 2016, 100),
       ('Bob', 2017, 150),
       ('Bob', 2018, 200),
       ('Alice', 2016, 150),
       ('Alice', 2017, 100),
       ('Alice', 2018, 200),
       ('John', 2016, 200),
       ('John', 2017, 150),
       ('John', 2018, 250);


SELECT SUM(sale) AS total_sum
FROM sales;


SELECT fiscal_year, SUM(sale) AS total_sum
FROM sales
GROUP BY fiscal_year;


SELECT fiscal_year
     , sales_employee
     , sale
     , SUM(sale) OVER (PARTITION BY fiscal_year) as total_sales
FROM sales;



SELECT fiscal_year, AVG(sale) AS avg_sum
FROM sales
GROUP BY fiscal_year;


SELECT fiscal_year
     , SUM(sale) AS total_sum
     , AVG(sale) AS avg_sum
     , MIN(sale) AS min_sale
     , MAX(sale) AS max_sale
FROM sales
GROUP BY fiscal_year;



SELECT fiscal_year
     , sales_employee
     , sale
     , SUM(sale) OVER (PARTITION BY fiscal_year) AS total_sum
     , AVG(sale) OVER (PARTITION BY fiscal_year) AS avg_sum
     , MIN(sale) OVER (PARTITION BY fiscal_year) AS min_sale
     , MAX(sale) OVER (PARTITION BY fiscal_year) AS max_sale
FROM sales;


--

CREATE TABLE productLineSales
SELECT p.productLine
#      , orderDate
     , YEAR(orderDate)                   AS orderYear
     , od.quantityOrdered * od.priceEach AS orderValue
FROM orderdetails od
         JOIN orders o USING (orderNumber)
         JOIN products p USING (productCode)

GROUP BY productLine, YEAR(orderDate);

SELECT productLine
     , SUM(orderValue) as order_value_sum
FROM productLineSales
GROUP BY productLine;


WITH cte_pls AS (
    SELECT p.productLine
#      , orderDate
         , YEAR(orderDate)                   AS orderYear
         , od.quantityOrdered * od.priceEach AS orderValue
    FROM orderdetails od
             JOIN orders o USING (orderNumber)
             JOIN products p USING (productCode)
    GROUP BY productLine, YEAR(orderDate)
)
SELECT productLine
     , SUM(orderValue) as order_value_sum
FROM cte_pls
GROUP BY productLine;

--
WITH pl_totals AS (
    SELECT productLine, SUM(orderValue) as order_value_sum
    FROM productLineSales
    GROUP BY productLine
)
SELECT productLine
     , order_value_sum
     , RANK() OVER (ORDER BY order_value_sum) as row_rank
FROM pl_totals;



SELECT productLine
     , orderYear
     , orderValue
     , ROUND(
        PERCENT_RANK() OVER (
            PARTITION BY orderYear
            ORDER BY orderValue
            ),
        2
    ) AS row_rank
FROM productLineSales;

-- LEAD
SELECT customerName, orderDate
FROM orders
         JOIN customers c on c.customerNumber = orders.customerNumber;

SELECT customerName
     , orderDate
     , LEAD(orderDate, 1)
            OVER (PARTITION BY c.customerNumber ORDER BY orderDate) AS next_order_date
FROM orders
         JOIN customers c USING (customerNumber);

-- LAG

SELECT customerName
     , orderDate
     , LAG(orderDate, 1)
           OVER (PARTITION BY c.customerNumber ORDER BY orderDate) AS prev_order_date
FROM orders
         JOIN customers c USING (customerNumber);

--

SELECT productLine
     , YEAR(orderDate)                   AS orderYear
     , ROUND(
         SUM(od.quantityOrdered * od.priceEach),
         0
    ) AS orderValue

FROM orders
         JOIN orderdetails od USING (orderNumber)
         JOIN products p USING (productCode)
GROUP BY productLine, orderYear;


WITH cte_product_line_sales AS (
    SELECT productLine
         , YEAR(orderDate)                   AS orderYear
         , ROUND(
             SUM(od.quantityOrdered * od.priceEach),
             0
        ) AS orderValue

    FROM orders
             JOIN orderdetails od USING (orderNumber)
             JOIN products p USING (productCode)
    GROUP BY productLine, orderYear
)
SELECT productLine
     , orderYear
     , orderValue
     , LAG(orderValue, 1) OVER (
         PARTITION BY productLine
         ORDER BY orderYear
    ) as prev_year_order_total
FROM cte_product_line_sales;

