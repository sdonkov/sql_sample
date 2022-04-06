CREATE DATABASE minions;
USE minions;

CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT,
    UNIQUE KEY id (id)
);

CREATE TABLE towns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    UNIQUE KEY id (id)
);

ALTER TABLE minions
ADD COLUMN town_id INT default NULL,
ADD CONSTRAINT FK_minions_towns foreign key (town_id) references towns(id);

INSERT INTO towns (id, name) values (1, 'Sofia'),(2, 'Plovdiv'),(3, 'Varna');

INSERT INTO minions (name, age, town_id) 
VALUES ('Kevin', 22, 1), ('Bob', 15, 3), ('Steward', Null, 2);

TRUNCATE TABLE minions;
DROP DATABASE minions;

SELECT * FROM minions;

CREATE TABLE people (
    id INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(2 , 2 ),
    weight DOUBLE(3 , 2 ),
    gender ENUM('m', 'f') NOT NULL,
    birthdate DATE NOT NULL,
    biography LONGTEXT
);

INSERT INTO people(name, gender, birthdate) VALUES 
('Peter Petrov', 'm', '1980-02-10'), ('Ivo Ivov', 'm', '1983-03-20'), ('Maria Marieva', 'f', '1985-10-10');

SELECT * FROM people;

CREATE TABLE users (
    id BIGINT UNIQUE PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time TIMESTAMP,
    is_deleted BOOLEAN
);

INSERT INTO users(username, password, last_login_time, is_deleted) VALUES 
('Gosho', 'gosho123', NOW(), TRUE),
('Pesho', 'pesho123', NOW(), FALSE),
('Ico', 'ivo123', NOW(), TRUE);

ALTER TABLE users
DROP PRIMARY KEY ,
ADD CONSTRAINT pk_users PRIMARY KEY(id, username);

ALTER TABLE users MODIFY COLUMN last_login_time
TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users DROP PRIMARY KEY,
ADD CONSTRAINT PRIMARY KEY(id),
ADD CONSTRAINT UNIQUE (username);

CREATE DATABASE Movies;
USE Movies;

CREATE TABLE directors (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    director_name VARCHAR(30) NOT NULL,
    notes TEXT
);

CREATE TABLE genres (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(30) NOT NULL,
    notes TEXT
);

CREATE TABLE categories (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(30) NOT NULL,
    notes TEXT
);

CREATE TABLE movies (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(30) NOT NULL,
    director_id INT NOT NULL,
    copyright_year YEAR NOT NULL,
    lenght TIME NOT NULL,
    genre_id INT NOT NULL,
    category_id INT NOT NULL,
    rating DOUBLE NOT NULL DEFAULT 0,
    notes TEXT
);

INSERT INTO directors(id, director_name, notes) VALUES 
(1, 'Steve', 'blq blq'),
(2, 'John', 'gdfgd'),
(3, 'Jean', 'fdgd');

INSERT INTO genres(id, genre_name, notes) VALUES 
(1, 'Horror', 'blq blq'),
(2, 'Comedy', 'gdfgd'),
(3, 'Drama', 'fdgd');

INSERT INTO categories(id, category_name) VALUES 
(1, 'fgfdg'),
(2, 'fdgdfgdf'),
(3, 'dfgfdg');

INSERT INTO movies(`id`, `title`, `director_id`, `copyright_year`, `lenght`, `genre_id`, `category_id`) VALUES
	(11,"kamen",2,'2016',23,1,2),
	(10,"kamen",2,'2016',23,1,2),
	(13,"kamen",2,'2016',23,1,2),
	(14,"kamen",2,'2016',23,1,2),
	(15,"kamen",1,'2016',23,1,2);

SELECT * FROM movies;

CREATE DATABASE Hotel;
USE Hotel;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    title VARCHAR(30),
    notes VARCHAR(128)
);

INSERT INTO `employees`
		(`first_name`, `last_name`, `title`, `notes`)
	VALUES 
		('Gosho', 'Goshev', 'Boss', ''),
		('Pesho', 'Peshev', 'Supervisor', ''),
		('Bai', 'Ivan', 'Worker', 'Can do any work');
        
CREATE TABLE customers (
    account_number INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    emergency_name VARCHAR(45) ,
    emergency_number TEXT ,
    notes VARCHAR(128)
);

INSERT INTO `customers`
		(account_number, `first_name`, `last_name`, `phone_number`)
	VALUES 
		(1,'Gosho', 'Goshev', '123'),
		(2,'Pesho', 'Peshev', '44-2432'),
		(3,'Bai', 'Ivan', '007');

CREATE TABLE room_status (
    room_status INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    notes VARCHAR(128)
);

INSERT INTO `room_status` 
		(`notes`)
	VALUES 
		('Free'),
		('For clean'),
		('Occupied');
        
CREATE TABLE room_type (
    room_type INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    notes VARCHAR(128)
);

INSERT INTO `room_type` 
		(`notes`)
	VALUES 
		('Small'),
		('Medium'),
		('Appartment');
        
CREATE TABLE bed_type (
    bed_type INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    notes VARCHAR(128)
);

INSERT INTO `bed_type` 
		(`notes`)
	VALUES 
		('Single'),
		('Double'),
		('Water-filled');

CREATE TABLE rooms (
    room_number INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    room_type VARCHAR(40),
    bed_type VARCHAR(40),
    rate DOUBLE DEFAULT 0,
    room_status INT NOT NULL,
    notes VARCHAR(128)
);

INSERT INTO `rooms` 
		(`room_type`, `bed_type`, `room_status`)
	VALUES 
		(1, 1, 1),
		(2, 2, 2),
		(3, 3, 3);

CREATE TABLE payments (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    payment_date DATE NOT NULL,
    account_number INT UNSIGNED NOT NULL,
    first_date_occupied DATE,
    last_date_occupied DATE,
    total_days INT ,
    amount_charged DECIMAL(5, 2),
    tax_rate DECIMAL(3, 2) ,
    tax_amaount DOUBLE,
    payment_total DECIMAL(5, 2),
    notes VARCHAR(128)
);

INSERT INTO `payments` 
		(`employee_id`, `payment_date`, `account_number`)
	VALUES 
		(1, DATE(NOW()), 1),
		(2, DATE(NOW()), 2),
		(3, DATE(NOW()), 3);

CREATE TABLE occupancies (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    date_occupied DATE NOT NULL,
    account_number INT UNSIGNED NOT NULL,
    room_number INT NOT NULL,
    rate_applied DOUBLE,
    phone_charge DECIMAL(5 , 2 ),
    notes VARCHAR(128)
);

INSERT INTO `occupancies` 
		(`employee_id`, `date_occupied`, `account_number`, `room_number`)
	VALUES 
		(1, DATE(NOW()), 1, 1),
		(2, DATE(NOW()), 2, 2),
		(3, DATE(NOW()), 3, 3);











CREATE DATABASE SoftUni;
USE SoftUni;

CREATE TABLE towns (
    id INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT pk_towns PRIMARY KEY (id)
);

CREATE TABLE addresses (
    id INT NOT NULL AUTO_INCREMENT UNIQUE,
    address_text VARCHAR(30) NOT NULL,
    town_id INT NOT NULL,
    CONSTRAINT pk_addresses PRIMARY KEY (id),
    CONSTRAINT fk_addresses_towns FOREIGN KEY (town_id)
        REFERENCES towns (id)
);

CREATE TABLE departments (
    id INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (id)
);

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(30),
    last_name VARCHAR(30) NOT NULL,
    job_title VARCHAR(30) NOT NULL,
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10 , 2 ),
    address_id INT,
    CONSTRAINT pk_employees PRIMARY KEY (id),
    CONSTRAINT fk_empoyees_departments FOREIGN KEY (department_id)
        REFERENCES departments (id),
    CONSTRAINT fk_employee_addresses FOREIGN KEY (address_id)
        REFERENCES addresses (id)
);

INSERT INTO towns(name) VALUES('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO departments(name) VALUES('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');

INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary) VALUES
		('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
		('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
		('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
		('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
		('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

SELECT * FROM `towns` ORDER BY name asc;
SELECT * FROM `departments` ORDER BY name asc;
SELECT * FROM `employees` ORDER BY salary DESC;

SELECT name FROM towns order by name asc;
SELECT name FROM departments order by name asc;
SELECT first_name, last_name, job_title, salary FROM employees order by salary desc;

UPDATE employees SET salary = salary * 1.1;
SELECT salary FROM employees;

SELECT * FROM `customers`;

truncate table occupancies;
