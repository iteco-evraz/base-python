-- JOIN

SELECT *
FROM movies;

SELECT *
FROM genres;

SELECT movie_id    AS id
     , movie_title AS title
     , director
     , year
     , genre_title AS genre
FROM movies m
         JOIN genres g on m.genre_id = g.genre_id;

SELECT movie_id    AS id
     , movie_title AS title
     , director
     , year
     , genre_title AS genre
FROM movies m
         JOIN genres g on m.genre_id = g.genre_id
WHERE genre_title = 'Drama';


SELECT p.productCode      AS code
     , p.productName      AS name
     , pl.textDescription AS description
FROM products p
         JOIN productlines pl on pl.productLine = p.productLine;

-- INNER JOIN

SELECT movie_id    AS id
     , movie_title AS title
     , director
     , year
     , genre_title AS genre
FROM movies m
         INNER JOIN genres g on m.genre_id = g.genre_id
WHERE genre_title = 'Drama';


SELECT p.productCode      AS code
     , p.productName      AS name
     , pl.textDescription AS description
FROM products p
         INNER JOIN productlines pl on pl.productLine = p.productLine;


SELECT p.productCode      AS code
     , p.productName      AS name
     , pl.textDescription AS description
FROM products p
         INNER JOIN productlines pl USING (productLine);


SELECT o.orderNumber
     , o.orderDate
     , c.customerName
     , od.orderLineNumber
     , p.productName
     , od.quantityOrdered
     , od.priceEach
FROM orders o
         INNER JOIN customers c USING (customerNumber)
         INNER JOIN orderdetails od USING (orderNumber)
         INNER JOIN products p USING (productCode)
ORDER BY orderNumber, orderLineNumber;

SELECT *
FROM movies m
         INNER JOIN offices o ON o.officeCode = m.genre_id
ORDER BY genre_id;


SELECT od.orderNumber
     , p.productCode
     , p.productName
     , MSRP
     , priceEach
FROM products p
         INNER JOIN orderdetails od
                    ON p.productCode = od.productCode
                        AND p.MSRP <> od.priceEach
WHERE p.productCode = 'S10_1678';


-- + group by

SELECT o.orderNumber
--     , o.status
--     , od.productCode
     , p.productName
     , od.quantityOrdered
     , od.priceEach
     , od.priceEach * od.quantityOrdered AS line_total
FROM orders o
         INNER JOIN orderdetails od USING (orderNumber)
         INNER JOIN products p USING (productCode);


SELECT o.orderNumber
     , SUM(od.priceEach * od.quantityOrdered) AS order_total
     , o.comments                             AS comment
FROM orders o
         INNER JOIN orderdetails od USING (orderNumber)
         INNER JOIN products p USING (productCode)
GROUP BY orderNumber;

-- CROSS JOIN

SELECT *
FROM meals,
     drinks;

SELECT *
FROM meals m
         CROSS JOIN drinks d;

SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , m.weight + d.volume AS total_weight
FROM meals m
         CROSS JOIN drinks d
ORDER BY total_weight;

SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , m.weight + d.volume AS total_weight
FROM meals m
         CROSS JOIN drinks d
WHERE (m.weight + d.volume) > 500
ORDER BY total_weight;

SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , m.weight + d.volume AS total_weight
FROM meals m
         CROSS JOIN drinks d
WHERE m.weight > 300
  AND d.volume > 200
ORDER BY d.volume DESC, m.weight;


-- LEFT JOIN

SELECT c.customerNumber
     , c.customerName
     , o.orderNumber
     , o.status
FROM customers c
         LEFT JOIN orders o USING (customerNumber);

SELECT c.customerNumber
     , c.customerName
     , o.orderNumber
     , o.status
FROM customers c
         LEFT JOIN orders o USING (customerNumber)
WHERE o.orderNumber IS NULL;


SELECT e.lastName
     , e.firstName
     , c.customerName
--     , c.phone
     , p.checkNumber
     , p.amount
FROM employees e
         LEFT JOIN customers c
                   ON e.employeeNumber = c.salesRepEmployeeNumber
         LEFT JOIN payments p
                   ON c.customerNumber = p.customerNumber
-- WHERE c.customerNumber IS NOT NULL
ORDER BY c.customerName, p.amount DESC, p.checkNumber;


-- RIGHT JOIN

SELECT employeeNumber, customerNumber
FROM customers c
         RIGHT JOIN employees e on e.employeeNumber = c.salesRepEmployeeNumber
ORDER BY employeeNumber;

SELECT employeeNumber, customerNumber
FROM customers c
         RIGHT JOIN employees e on e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerNumber is NULL
ORDER BY employeeNumber;


-- UNION

SELECT firstName, lastName
FROM employees;

SELECT contactFirstName, contactLastName
FROM customers;

SELECT firstName AS name, lastName AS surname, 'employee' AS category
FROM employees
UNION
SELECT contactFirstName, contactLastName, 'customer' AS category
FROM customers;


SELECT CONCAT(firstName, ' ', lastName) AS full_name, 'employee' AS category
FROM employees
UNION
SELECT CONCAT(contactFirstName, ' ', contactLastName), 'customer' AS category
FROM customers;


SELECT CONCAT(firstName, ' ', lastName) AS full_name, 'employee' AS category
FROM employees
UNION
SELECT CONCAT(contactFirstName, ' ', contactLastName), 'customer' AS category
FROM customers
ORDER BY full_name;

SELECT CONCAT(firstName, ' ', lastName) AS full_name, 'employee' AS category
FROM employees
UNION
SELECT CONCAT(contactFirstName, ' ', contactLastName), 'customer' AS category
FROM customers
ORDER BY 1;

-- CTE

SELECT *
FROM meals;

WITH cte_meals AS (
    SELECT id, name
    FROM meals
)
SELECT name, id
FROM cte_meals;


SELECT o.orderNumber
     , o.status
     , SUM(od.priceEach * od.quantityOrdered) AS order_total
     , o.comments                             AS comment
FROM orders o
         INNER JOIN orderdetails od USING (orderNumber)
         INNER JOIN products p USING (productCode)
GROUP BY orderNumber;

with cte_shipped_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.priceEach * od.quantityOrdered) AS order_total
         , o.comments                             AS comment
    FROM orders o
             INNER JOIN orderdetails od USING (orderNumber)
    WHERE o.status = 'Shipped'
    GROUP BY orderNumber
),
     cte_order_details AS (
         SELECT *
         FROM orderdetails
         WHERE quantityOrdered > 30
     )
SELECT o.orderNumber
     , order_total
     , comment
     , d.quantityOrdered
     , d.productCode
     , d.orderLineNumber
FROM cte_shipped_orders o
         JOIN cte_order_details d ON o.orderNumber = d.orderNumber
ORDER BY order_total DESC;


with cte_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.priceEach * od.quantityOrdered) AS order_total
         , o.comments                             AS comment
    FROM orders o
             INNER JOIN orderdetails od USING (orderNumber)
    GROUP BY orderNumber
),
     cte_shipped_orders AS (
         SELECT *
         FROM cte_orders
         WHERE status = 'Shipped'
     )
SELECT o.orderNumber, order_total, comment, status
FROM cte_shipped_orders o
ORDER BY order_total DESC;



with cte_od AS (
    SELECT *
    FROM orderdetails
    WHERE quantityOrdered > 30
),
     cte_orders AS (
         SELECT o.orderNumber
              , o.status
              , SUM(od.priceEach * od.quantityOrdered) AS order_total
              , o.comments                             AS comment
         FROM orders o
                  INNER JOIN cte_od od USING (orderNumber)
         GROUP BY orderNumber
     ),
     cte_shipped_orders AS (
         SELECT *
         FROM cte_orders
         WHERE status = 'Shipped'
     )
SELECT o.orderNumber, order_total, comment, status
FROM cte_shipped_orders o
ORDER BY order_total DESC;



SELECT o.orderNumber
     , o.status
     , SUM(od.priceEach * od.quantityOrdered) AS order_total
     , o.comments                             AS comment
FROM orders o
         INNER JOIN orderdetails od USING (orderNumber)
GROUP BY orderNumber;


WITH cte_employees AS (
    SELECT CONCAT(firstName, ' ', lastName) AS full_name, 'employee' AS category
    FROM employees
    WHERE lastName LIKE 'M%'
),
     cte_customers AS (
         SELECT CONCAT(contactFirstName, ' ', contactLastName) AS full_name, 'customer' AS category
         FROM customers
         WHERE contactFirstName like 'G%'
     )
SELECT *
FROM cte_employees
UNION
SELECT *
FROM cte_customers
ORDER BY full_name;
