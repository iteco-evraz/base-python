CREATE TABLE students
(
    student_number INT AUTO_INCREMENT PRIMARY KEY,
    student_name   VARCHAR(100),
    dept_name      VARCHAR(100),
    subject        VARCHAR(100),
    marks          INT
);

CREATE INDEX ix_student_name ON students(student_name);

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

SELECT SUM(student_number)
FROM students;

SELECT student_name, SUM(marks) as total_marks
FROM students
GROUP BY student_name;

SELECT student_name, AVG(marks) as average_marks
FROM students
GROUP BY student_name;

SELECT student_name, MIN(marks) as min_mark, MAX(marks) as max_mark
FROM students
GROUP BY student_name;

SELECT COUNT(*) as students_count
FROM students;

SELECT DISTINCT student_name
FROM students;

SELECT COUNT(DISTINCT student_name) as total_students
FROM students;


-- Window Functions

SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
FROM students;

SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
FROM students
ORDER BY marks;

SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
     , ROW_NUMBER() OVER (ORDER BY marks) as row_num
FROM students;

SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
     , ROW_NUMBER() OVER (ORDER BY marks) as row_num
FROM students
WHERE marks > 70;


SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
     , ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY marks) as row_num
FROM students;


SELECT student_number
     , student_name
     , dept_name
     , subject
     , marks
#      , ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY marks) as row_num
     , RANK() OVER (ORDER BY marks) as rank_num
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

SELECT SUM(sale) as total_sum
FROM sales;

SELECT fiscal_year,
       SUM(sale) AS year_total_sum
FROM sales
GROUP BY fiscal_year;

SELECT fiscal_year,
       sales_employee,
       sale,
       SUM(sale) OVER (PARTITION BY fiscal_year) as total_sales
FROM sales;

SELECT sales_employee, SUM(sale) as total_sum
FROM sales
GROUP BY sales_employee;

SELECT sales_employee, AVG(sale) as average_sale
FROM sales
GROUP BY sales_employee;

SELECT sales_employee
     , AVG(sale) as average_sale
     , SUM(sale) as total_sale
     , MIN(sale) as min_sale
     , MAX(sale) as max_sale
FROM sales
GROUP BY sales_employee;

--


SELECT productLine,
       YEAR(orderDate) as orderYear,
       od.quantityOrdered * od.priceEach AS orderValue
FROM orderdetails od
    INNER JOIN orders o USING(orderNumber)
    INNER JOIN products p USING(productCode)
GROUP BY productLine, YEAR(orderDate);


CREATE TABLE productLineSales
    SELECT productLine,
           YEAR(orderDate) as orderYear,
           od.quantityOrdered * od.priceEach AS orderValue
    FROM orderdetails od
        INNER JOIN orders o USING(orderNumber)
        INNER JOIN products p USING(productCode)
    GROUP BY productLine, YEAR(orderDate);

SELECT productLine,
       SUM(orderValue) AS order_value_sum
FROM productLineSales
GROUP BY productLine;

WITH pl_totals AS (
    SELECT productLine,
           SUM(orderValue) AS order_value_sum
    FROM productLineSales
    GROUP BY productLine
)
SELECT productLine,
       order_value_sum,
       RANK() OVER (ORDER BY order_value_sum) AS row_rank
FROM pl_totals;


WITH pl_totals AS (
    SELECT productLine,
           SUM(orderValue) AS order_value_sum
    FROM productLineSales
    GROUP BY productLine
)
SELECT productLine,
       order_value_sum,
       ROUND(
           PERCENT_RANK() OVER (ORDER BY order_value_sum),
           3
       ) AS percentile_rank

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
       ) AS percentile_rank

FROM productLineSales;


--

SELECT customerName, orderDate
FROM orders o
    JOIN customers c USING (customerNumber);

SELECT customerName
     , orderDate
     , LEAD(orderDate, 1) OVER (
         PARTITION BY customerNumber
         ORDER BY orderDate
    ) AS nextOrderDate
FROM orders o
    JOIN customers c USING (customerNumber);

SELECT productLine,
       orderDate AS order_date,
       YEAR(orderDate) AS order_year
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
    INNER JOIN products p USING (productCode);


SELECT productLine,
       YEAR(orderDate) as order_year,
       ROUND(
           SUM(quantityOrdered * priceEach)
           , 0
       ) AS order_total
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
    INNER JOIN products p USING (productCode)
GROUP BY productLine, order_year;


WITH productline_sales AS (

    SELECT productLine,
           YEAR(orderDate) as order_year,
           ROUND(
               SUM(quantityOrdered * priceEach)
           ) AS order_total
    FROM orders o
        INNER JOIN orderdetails od USING (orderNumber)
        INNER JOIN products p USING (productCode)
    GROUP BY productLine, order_year
)
SELECT productLine
     , order_year
     , order_total
     , LAG(order_total, 1) OVER (
         PARTITION BY productLine
         -- ORDER BY order_total
         ORDER BY order_year
    ) AS prev_year_order_total
FROM productline_sales;