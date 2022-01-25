CREATE TABLE authors
(
    id       INT                NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) UNIQUE NOT NULL,
    email    VARCHAR(80) UNIQUE,
    PRIMARY KEY (id)
);


CREATE TABLE articles
(
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    body TEXT NOT NULL DEFAULT '',
    author_id INT NOT NULL,
    -- deleted BOOL NOT NULL default 0,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES authors (id)
        -- ON DELETE CASCADE
);

ALTER TABLE authors
ADD COLUMN full_name VARCHAR(50);

--

SELECT *
FROM authors;

SELECT id, username
FROM authors;

SELECT id, username
FROM authors
ORDER BY id;

SELECT id, username
FROM authors
ORDER BY id DESC;

SELECT id, username
FROM authors
ORDER BY username;

SELECT id, username
FROM authors
ORDER BY id
LIMIT 5;

SELECT id, username
FROM authors
ORDER BY id DESC
LIMIT 5;

SELECT id, username
FROM authors
ORDER BY id DESC
LIMIT 5
OFFSET 2;


SELECT *
FROM authors
WHERE username = 'sam';


SELECT *
FROM authors
WHERE username = 'john';

SELECT *
FROM authors
WHERE email IS NOT NULL;


SELECT *
FROM authors
WHERE username LIKE 'j%';

SELECT *
FROM authors
WHERE username LIKE 'ja%';


SELECT *
FROM authors
WHERE email LIKE '%@example.com';
-- WHERE email = '';


INSERT INTO authors (username, email)
VALUES ('ann', 'ann@example.com');


INSERT INTO authors (username, email)
VALUES ('kate', 'kate@google.com');


SELECT *
FROM authors
WHERE email IS NOT NULL;


SELECT *
FROM authors
WHERE email IS NULL;


SELECT *
FROM authors
WHERE email LIKE '%@google.com';



INSERT INTO articles (title, author_id)
VALUES ('SQL Lesson', 2);


SELECT *
FROM articles;


SELECT id, title, author_id
FROM articles;

SELECT id, title, author_id
FROM articles
WHERE author_id = 2;

SELECT id, title, author_id
FROM articles
WHERE author_id = 4;

SELECT *
FROM authors
WHERE username = 'sam';


SELECT *
FROM articles ar
JOIN authors a on a.id = ar.author_id;


SELECT *
FROM articles
JOIN authors on authors.id = articles.author_id;


SELECT *
FROM articles ar
JOIN authors a on a.id = ar.author_id
WHERE a.id = 2;



SELECT *
FROM articles ar
JOIN authors a on a.id = ar.author_id
WHERE a.username = 'john';

SELECT author_id
FROM articles;

SELECT DISTINCT author_id
FROM articles;

SELECT *
FROM authors
WHERE id IN (
    SELECT DISTINCT author_id
    FROM articles
);

SELECT *
FROM articles
WHERE body = '' AND title like '%Falcon%';


SELECT *
FROM authors
WHERE id > 5;



SELECT *
FROM authors
WHERE id > 5 AND id < 13;


SELECT *
FROM authors
WHERE id BETWEEN 5 AND 13;

UPDATE authors
SET email = 'nick@google.com'
WHERE username = 'nick';

UPDATE authors
SET email = 'kate@example.com'
WHERE username = 'kate';

UPDATE authors
SET full_name = 'Kate Smith'
WHERE username = 'kate';

UPDATE authors
SET full_name = 'Kate Smith'
WHERE username = 'admin';

DELETE FROM authors
WHERE username = 'sam';
-- WHERE id = 4;


DELETE FROM authors
WHERE username = 'george';


DELETE FROM articles
WHERE author_id = 2;


DELETE FROM authors
WHERE id = 2;
