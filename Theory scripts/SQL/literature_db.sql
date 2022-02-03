# Creating a database and two tables with failsafe (DROP):
DROP DATABASE IF EXISTS literature;
CREATE DATABASE literature;
USE literature;
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT NOT NULL, #very useful the auto_increment
    name VARCHAR(30),
    country VARCHAR(20),
    PRIMARY KEY (author_id)
);
DROP TABLE IF EXISTS books;
CREATE TABLE books (
    book_id INT AUTO_INCREMENT NOT NULL,
    book_name VARCHAR(50),
    author_id INT,
    category VARCHAR(30),
    PRIMARY KEY (book_id),
    KEY idx_fk_author(author_id), #auto-update foreign key. idx_fk_ is a function
    CONSTRAINT fk_author_id FOREIGN KEY(author_id)
    REFERENCES authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

# Populating the tables:
INSERT INTO literature.authors(
	name,
	country
)
VALUES
('Jens Peter Jacobsen', 'Denmark'),
('Friedrich Hayek', 'Austria'),
('Mary Shelley', 'United Kingdom'),
('Fyodor Dostoevsky', 'Russia'),
('Hermann Hesse', 'Germany');

INSERT INTO literature.books(
	book_name,
    author_id,
    category
)
VALUES
('Niels Lyhne', 1, 'Novel'),
('The Fatal Conceit', 2,'Economics'),
('The Road to Serfdom', 2, 'Political Science'),
('Frankenstein', 3, 'Novel'),
('The Brothers Karamazov', 4,'Novel'),
('The Idiot', 4, 'Novel'),
('Siddhartha', 5, 'Philosophical Novel');

# Joining both tables:
SELECT 
    *
FROM
    authors AS a
        JOIN
    books AS b USING (author_id);

# Creating a view:
CREATE OR REPLACE VIEW authorsandbooks AS
    SELECT 
        *
    FROM
        books
            JOIN
        authors USING (author_id);
	
SELECT 
    *
FROM
    authorsandbooks;