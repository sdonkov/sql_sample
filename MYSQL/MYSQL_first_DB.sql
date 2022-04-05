
CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name varchar(50),
last_name varchar(50)
);

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
category_id INT NOT NULL
);

INSERT INTO employees (first_name, last_name) VALUES
('Petar', 'Ivanov'),
('Manol', 'Glavchev'),
('Sami', 'Gero');

ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50) AFTER first_name;

ALTER TABLE products
ADD CONSTRAINT category_fk
FOREIGN KEY (category_id) 
REFERENCES categories(id);

ALTER TABLE employees
MODIFY COLUMN middle_name VARCHAR(100);


