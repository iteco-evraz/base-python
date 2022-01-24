CREATE TABLE authors
(
    id       INT                NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) UNIQUE NOT NULL,
    email    VARCHAR(80) UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE articles
(
    id        INT          NOT NULL AUTO_INCREMENT,
    title     VARCHAR(200) NOT NULL,
    body      TEXT         NOT NULL DEFAULT '',
    author_id INT          NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES authors (id)
#         ON DELETE CASCADE
);


ALTER TABLE authors
ADD COLUMN full_name VARCHAR(50);


--

SELECT *
FROM authors;

SELECT id, username
FROM authors;

INSERT INTO authors (username, email)
VALUES ('ann', 'ann@example.com');


SELECT id, username
FROM authors
ORDER BY id;


SELECT id, username
FROM authors
ORDER BY id DESC;


SELECT *
FROM authors
ORDER BY id;


SELECT *
FROM authors
WHERE authors.email IS NOT NULL
ORDER BY id;


INSERT INTO authors (username)
VALUES ('ann');


INSERT INTO authors (username, email)
VALUES ('kate', 'kate@example.com');

INSERT INTO authors (username, email)
VALUES ('nick', 'nick@google.com');

SELECT *
FROM authors
WHERE authors.email LIKE '%@example.com'
ORDER BY id;

SELECT *
FROM authors
WHERE NOT (authors.email LIKE '%@example.com')
ORDER BY id;


SELECT *
FROM authors
WHERE authors.email IS NOT NULL
ORDER BY id
LIMIT 3;


SELECT *
FROM authors
WHERE authors.email IS NOT NULL
ORDER BY id DESC
LIMIT 3;


INSERT INTO articles (title, body, author_id)
VALUES ('SQL Lesson',
        'Hello...',
        4);

INSERT INTO articles (title, author_id)
VALUES ('Falcon Lesson',
        5);


SELECT *
FROM articles;

SELECT *
FROM articles
WHERE author_id = 4;

SELECT *
FROM authors
WHERE authors.username = 'sam';

SELECT ar.id, ar.title, a.username, a.email
FROM articles ar
         JOIN authors a on a.id = ar.author_id;

SELECT ar.id, ar.title, a.username, a.email
FROM articles ar
         JOIN authors a on a.id = ar.author_id
WHERE a.id = 4;

SELECT ar.id, ar.title, a.username, a.email
FROM articles ar
         JOIN authors a on a.id = ar.author_id
# WHERE a.username = 'sam';
WHERE a.username = 'john';

SELECT *
FROM authors a
     JOIN articles ar on a.id = ar.author_id;

SELECT *
FROM authors
     JOIN articles on authors.id = articles.author_id;

SELECT DISTINCT author_id
FROM articles;


SELECT *
FROM authors a
WHERE id IN (
    SELECT DISTINCT author_id
    FROM articles
);

SELECT *
FROM articles
WHERE articles.body = '' AND articles.title like '%Falcon%';

SELECT *
FROM authors
WHERE id > 5;

SELECT *
FROM authors
WHERE id > 5 AND id < 10;

SELECT *
FROM authors
WHERE id BETWEEN 6 AND 10;


UPDATE authors
SET email = 'john@example.com'
WHERE username = 'john';


UPDATE authors
SET email = 'kate@google.com'
WHERE username = 'kate';

UPDATE authors
SET full_name = 'Kate Smith'
WHERE username = 'kate';

UPDATE authors
SET full_name = 'Kate Smith'
WHERE username = 'admin';


DELETE FROM articles
WHERE author_id = 5;

DELETE FROM authors
WHERE id = 5;
