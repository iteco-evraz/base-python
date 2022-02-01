CREATE TABLE tbl
(
    c1 INT PRIMARY KEY,
    c2 INT NOT NULL,
    c3 INT NOT NULL,
    c4 VARCHAR(10),
    INDEX (c2, c3)
);

CREATE INDEX idx_c4 ON tbl (c4);

--

SELECT *
FROM orders;

EXPLAIN
SELECT *
FROM orders
WHERE status <> 'Shipped';

EXPLAIN
SELECT *
FROM orders
WHERE status NOT IN ('Shipped', 'Resolved');

CREATE INDEX ix_status ON orders (status);

EXPLAIN
SELECT *
FROM orders
WHERE orderNumber = 10101;

EXPLAIN
SELECT *
FROM orders
WHERE comments IS NULL;


--

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean'
  AND contactLastName = 'King';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactLastName = 'King';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactLastName = 'King';


CREATE INDEX ix_first_and_last_name
    ON customers (contactFirstName, contactLastName);

CREATE INDEX ix_last_and_first_name
    ON customers (contactLastName, contactFirstName);


DROP INDEX ix_first_and_last_name ON customers;

CREATE INDEX ix_first_name ON customers (contactFirstName);
CREATE INDEX ix_last_name ON customers (contactLastName);

DROP INDEX ix_first_name ON customers;
DROP INDEX ix_last_name ON customers;

CREATE INDEX ix_name
    ON tbl (c2, c3, c4);

-- (c2)
-- (c2, c3)
-- (c2, c3, c4)

DROP INDEX ix_name ON tbl;

--
CREATE TABLE messages
(
    id      INT          NOT NULL AUTO_INCREMENT,
    message VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

SELECT CONNECTION_ID() as conn_id;

INSERT INTO messages(message)
VALUES ('Hello');

SELECT *
FROM messages;

LOCK TABLES messages READ;

INSERT INTO messages(message)
VALUES ('Hi');


SHOW PROCESSLIST;

UNLOCK TABLES;


LOCK TABLES messages WRITE;

INSERT INTO messages(message)
VALUES ('Good Morning!');

SELECT *
FROM messages;

UNLOCK TABLES;

--
-- START TRANSACTION
-- BEGIN
-- BEGIN WORK

-- COMMIT
-- ROLLBACK

# SET autocommit = 0;
# SET autocommit = 1;

-- 1. начинаем новую транзакцию
START TRANSACTION;

-- 2. Получение заказа
SELECT @orderNumber := MAX(orderNumber) + 1
FROM orders;

-- 3. добавляем заказ
INSERT INTO orders ( orderNumber
                   , orderDate
                   , requiredDate
                   , shippedDate
                   , status
                   , customerNumber)
VALUES (@orderNumber,
        '2005-05-31',
        '2005-06-01',
        '2005-06-11',
        'In Progress',
        145);

SELECT *
FROM orders
WHERE orderNumber = @orderNumber;

INSERT INTO orderdetails( orderNumber
                        , productCode
                        , quantityOrdered
                        , priceEach
                        , orderLineNumber)
VALUES (@orderNumber, 'S18_1749', 30, '125', 1),
       (@orderNumber, 'S18_2248', 50, '55.42', 2);

SELECT *
FROM orderdetails
WHERE orderNumber = 10426;

COMMIT;

SELECT *
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
WHERE o.orderNumber = 10426;

--

START TRANSACTION;

DELETE FROM orderdetails
WHERE orderdetails.orderNumber IS NOT NULL;

DELETE FROM orders
WHERE orderNumber IS NOT NULL;

SELECT *
FROM orders;

SELECT *
FROM orderdetails;

ROLLBACK;
