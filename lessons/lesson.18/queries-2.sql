SELECT CONNECTION_ID() as conn_id;

SELECT * FROM messages;

INSERT INTO messages(message)
VALUES ('Bye');

INSERT INTO messages(message)
VALUES ('Bye Bye');

SELECT * FROM messages;

SELECT *
FROM orders
WHERE orderNumber = '10426';

SELECT * FROM orderdetails WHERE orderNumber = 10426;


SELECT *
FROM orderdetails;
