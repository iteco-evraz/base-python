-- JOIN

SELECT *
FROM movies;

SELECT *
FROM genres;


SELECT movie_id      AS id
     , movie_title   AS title
     , director
     , year
     , g.genre_title AS genre
FROM movies m
         JOIN genres g on m.genre_id = g.genre_id;


SELECT movie_id      AS id
     , movie_title   AS title
     , director
     , year
     , g.genre_title AS genre
FROM movies m
         JOIN genres g on m.genre_id = g.genre_id
WHERE genre_title = 'Drama';

SELECT p.productCode      AS code
     , p.productName      AS name
     , pl.productLine     AS line
     , pl.textDescription AS description
FROM products p
         JOIN productlines pl on pl.productLine = p.productLine;


-- INNER JOIN


SELECT movie_id      AS id
     , movie_title   AS title
     , director
     , year
     , g.genre_title AS genre
FROM movies m
         INNER JOIN genres g on m.genre_id = g.genre_id
WHERE genre_title = 'Drama';


SELECT p.productCode      AS code
     , p.productName      AS name
     , pl.productLine     AS line
     , pl.textDescription AS description
FROM products p
         INNER JOIN productlines pl on pl.productLine = p.productLine;


SELECT p.productCode      AS code
     , p.productName      AS name
     , pl.productLine     AS line
     , pl.textDescription AS description
FROM products p
         INNER JOIN productlines pl USING (productLine);


SELECT o.orderNumber
     , o.orderDate
     , o.customerNumber
     , c.customerName
     , od.orderLineNumber
     , p.productName
     , od.quantityOrdered
     , od.priceEach
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
    INNER JOIN products p USING (productCode)
    INNER JOIN customers c USING (customerNumber)
ORDER BY orderNumber, orderLineNumber;


SELECT o.orderNumber
     , p.productName
     , p.MSRP
     , o.priceEach
FROM products p
    INNER JOIN orderdetails o on p.productCode = o.productCode
WHERE p.productCode = 'S10_1678';


SELECT o.orderNumber
     , p.productName
     , p.MSRP
     , o.priceEach
FROM products p
    INNER JOIN orderdetails o
     ON p.productCode = o.productCode
            AND p.MSRP > o.priceEach
WHERE p.productCode = 'S10_1678';


SELECT o.orderNumber
     , p.productName
     , p.MSRP
     , o.priceEach
FROM products p
    INNER JOIN orderdetails o
     ON p.productCode = o.productCode
            AND p.MSRP = o.priceEach
WHERE p.productCode = 'S10_1678';

-- GROUPING

SELECT o.orderNumber
     , o.status
     , od.productCode
     , p.productName
     , od.quantityOrdered
     , od.priceEach
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
    INNER JOIN products p USING (productCode);


SELECT o.orderNumber
     , o.status
     , od.productCode
     , p.productName
     , od.quantityOrdered
     , od.priceEach
     , od.priceEach * od.quantityOrdered AS line_total
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
    INNER JOIN products p USING (productCode);


SELECT o.orderNumber
     , o.status
     , SUM(od.priceEach * od.quantityOrdered) AS total
     , o.comments
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
GROUP BY orderNumber;


-- CROSS JOIN
SELECT m.id, m.name, m.weight, d.id, d.name, d.volume
FROM meals m
    CROSS JOIN drinks d;

SELECT m.name, m.weight, d.id, d.name, mv.movie_title
FROM meals m
    CROSS JOIN drinks d
    CROSS JOIN movies mv;


SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , (m.weight + d.volume) AS total_weight
FROM meals m
    CROSS JOIN drinks d;

SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , (m.weight + d.volume) AS total_weight
FROM meals m
    CROSS JOIN drinks d
ORDER BY total_weight;

SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , (m.weight + d.volume) AS total_weight
FROM meals m
    CROSS JOIN drinks d
WHERE m.weight > 300 AND d.volume > 200
ORDER BY m.name DESC, d.name;


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
WHERE o.orderNumber is NULL;

SELECT e.lastName
     , e.firstName
     , c.contactLastName
     , c.contactFirstName
     , p.checkNumber
     , p.amount
FROM employees e
    LEFT JOIN customers c
        ON e.employeeNumber = c.salesRepEmployeeNumber
    LEFT JOIN payments p ON c.customerNumber = p.customerNumber
ORDER BY customerName, checkNumber;

SELECT e.lastName
     , e.firstName
     , c.contactLastName
     , c.contactFirstName
     , p.checkNumber
     , p.amount
FROM employees e
    LEFT JOIN customers c
        ON e.employeeNumber = c.salesRepEmployeeNumber
    LEFT JOIN payments p ON c.customerNumber = p.customerNumber
-- WHERE checkNumber is NULL
-- WHERE c.customerNumber is NULL
ORDER BY customerName, checkNumber;


-- RIGHT JOIN

SELECT employeeNumber, customerNumber
FROM customers c
    RIGHT JOIN employees e on e.employeeNumber = c.salesRepEmployeeNumber
ORDER BY employeeNumber;


SELECT employeeNumber, customerNumber
FROM customers c
    RIGHT JOIN employees e on e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerNumber IS NULL
ORDER BY employeeNumber;

-- UNION

SELECT firstName, lastName
FROM employees;

SELECT contactFirstName, contactLastName
FROM customers;

SELECT firstName, lastName
FROM employees
UNION
SELECT contactFirstName, contactLastName
FROM customers;

SELECT firstName as name, lastName as surname
FROM employees
UNION
-- SELECT contactFirstName as name, contactLastName as surname
SELECT contactFirstName, contactLastName
FROM customers;


SELECT firstName, lastName, 'employee' AS category
FROM employees
UNION
SELECT contactFirstName, contactLastName, 'customer' AS category
FROM customers;


SELECT CONCAT(firstName, ' ', lastName) as fullname, 'employee' AS category
FROM employees
UNION
SELECT CONCAT(contactFirstName, ' ', contactLastName), 'customer' AS category
FROM customers
ORDER BY fullname;

SELECT CONCAT(firstName, ' ', lastName) as fullname, 'employee' AS category
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
SELECT *
FROM cte_meals
ORDER BY name DESC;


SELECT o.orderNumber
     , o.status
     , SUM(od.priceEach * od.quantityOrdered) AS total
     , o.comments
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
GROUP BY orderNumber;

WITH cte_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.priceEach * od.quantityOrdered) AS total
         , o.comments as comment
    FROM orders o
        INNER JOIN orderdetails od USING (orderNumber)
    GROUP BY orderNumber
)
SELECT orderNumber, total, comment, status
FROM cte_orders
ORDER BY status;

WITH cte_shipped_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.priceEach * od.quantityOrdered) AS total
         , o.comments as comment
    FROM orders o
        INNER JOIN orderdetails od USING (orderNumber)
    WHERE status = 'Shipped'
    GROUP BY orderNumber
)
SELECT orderNumber, total, comment
FROM cte_shipped_orders
ORDER BY total DESC;

WITH cte_shipped_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.priceEach * od.quantityOrdered) AS total
         , o.comments as comment
    FROM orders o
        INNER JOIN orderdetails od USING (orderNumber)
    WHERE status = 'Shipped'
    GROUP BY orderNumber
),
 cte_details AS (
    SELECT *
    FROM orderdetails
    WHERE quantityOrdered > 30
)
SELECT o.orderNumber, total, comment, d.quantityOrdered
FROM cte_shipped_orders o
JOIN cte_details d ON o.orderNumber = d.orderNumber
ORDER BY total DESC;


WITH cte_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.priceEach * od.quantityOrdered) AS total
         , o.comments as comment
    FROM orders o
        INNER JOIN orderdetails od USING (orderNumber)
    GROUP BY orderNumber
),
 cte_shipped_orders AS (
    SELECT *
    FROM cte_orders
    WHERE status = 'Shipped'
)
SELECT o.orderNumber, total, comment
FROM cte_shipped_orders o
ORDER BY total DESC;
