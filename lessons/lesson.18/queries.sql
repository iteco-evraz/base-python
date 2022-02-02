CREATE TABLE tbl
(
    c1 INT PRIMARY KEY AUTO_INCREMENT,
    c2 INT NOT NULL,
    c3 INT NOT NULL,
    c4 VARCHAR(10),
    -- INDEX (c4),
    INDEX (c2, c3)
);

CREATE INDEX idx_4 ON tbl (c4);
DROP INDEX idx_4 ON tbl;


--

SELECT orderNumber, orderDate, status
FROM orders;

EXPLAIN
SELECT orderNumber, orderDate, status
FROM orders
WHERE status <> 'Shipped';

EXPLAIN
SELECT orderNumber, orderDate, status
FROM orders
WHERE status NOT IN ('Shipped', 'Cancelled');

EXPLAIN
SELECT *
FROM orders
WHERE orderNumber = '10101';

EXPLAIN
SELECT *
FROM orders
WHERE orderNumber IN ('10101', '10100');

CREATE INDEX ix_status ON orders (status);

--

SELECT customerNumber, contactFirstName, contactLastName
FROM customers;

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactLastName = 'King';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean'
  AND contactLastName = 'King';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactLastName = 'King'
  AND contactFirstName = 'Jean';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactLastName = 'King';

EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactLastName = 'King';


CREATE INDEX ix_first_and_last_name
    ON customers (contactFirstName, contactLastName);


CREATE INDEX ix_last_and_first_name
    ON customers (contactLastName, contactFirstName);

DROP INDEX ix_last_and_first_name ON customers;

-- CREATE INDEX ix_name
-- ON tbl(c2, c3, c4);

-- (c2)
-- (c2, c3)
-- (c2, c3, c4)

CREATE TABLE messages
(
    id      INT          NOT NULL AUTO_INCREMENT,
    message VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

SELECT CONNECTION_ID() as conn_id;
SELECT '123';
SELECT '123', '456', '789';

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

SELECT *
FROM messages;


INSERT INTO messages(message)
VALUES ('Good Morning');

SELECT *
FROM messages;

SHOW PROCESSLIST;

UNLOCK TABLES;

--

-- START TRANSACTION
-- BEGIN
-- BEGIN WORK

-- COMMIT
-- ROLLBACK

START TRANSACTION;

SELECT *
FROM orders
ORDER BY orderNumber DESC;

SELECT @orderNumber := MAX(orderNumber) + 1
FROM orders;

INSERT INTO orders( orderNumber
                  , orderDate
                  , requiredDate
                  , shippedDate
                  , status
                  , customerNumber)
VALUES (@orderNumber,
        '2005-09-30',
        '2005-10-08',
        '2005-10-10',
        'In Process',
        145);


SELECT *
FROM orders
WHERE orderNumber = '10426';

INSERT INTO orderdetails(
     orderNumber
     , productCode
     , quantityOrdered
     , priceEach
     , orderLineNumber
) VALUES (
          @orderNumber
          , 'S18_1749'
          , 30
          , '146'
          , 1
           ),(
          @orderNumber
          , 'S18_2248'
          , 50
          , '55.42'
          , 2
           );


SELECT * FROM orderdetails WHERE orderNumber = 10426;

COMMIT;

EXPLAIN
SELECT o.orderNumber
       , orderDate
       , requiredDate
       , od.*
FROM orders o
INNER JOIN orderdetails od USING (orderNumber)
WHERE orderNumber = '10426';
# WHERE o.status <> 'Shipped';


START TRANSACTION;

DELETE FROM orderdetails
WHERE productCode <> 'abc';

SELECT *
FROM orderdetails;

ROLLBACK;