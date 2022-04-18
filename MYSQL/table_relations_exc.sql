CREATE TABLE people(
person_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
salary DECIMAL(10,2),
passport_id INT UNIQUE
);

CREATE TABLE passports(
passport_id INT UNIQUE AUTO_INCREMENT PRIMARY KEY,
passport_number VARCHAR(50) NOT NULL 
);

INSERT INTO people (person_id, first_name, salary,passport_id) VALUES
('1', 'Roberto', '43300.000', 102),
('2', 'Tom', '56100.00', 103),
('3', 'Yana', '60200.00', 101);

INSERT INTO `passports` VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

ALTER TABLE people
ADD CONSTRAINT `fk_people_passports`
FOREIGN KEY (passport_id)
REFERENCES passports(`passport_id`);

----------------------- 2 -------------------------------

CREATE TABLE manufacturers(
manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
established_on DATE NOT NULL
);

CREATE TABLE  models(
model_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
manufacturer_id INT NOT NULL
)auto_increment = 101;

INSERT INTO manufacturers (`name`, established_on) VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models (`name`, manufacturer_id) VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3) ;


ALTER TABLE models
ADD CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(`manufacturer_id`);

------------------------3-----------------------------

CREATE TABLE exams(
exam_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`name` VARCHAR(50) NOT NULL) 
AUTO_INCREMENT = 101;

CREATE TABLE students(
student_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`name` VARCHAR(50)
);

CREATE TABLE students_exams(
student_id INT  NOT NULL,
exam_id INT  NOT NULL,
CONSTRAINT fk_studentsexam_students
FOREIGN KEY (student_id)
REFERENCES students(`student_id`),
CONSTRAINT fk_studentsexam_exams
FOREIGN KEY(exam_id)
REFERENCES exams(`exam_id`)
);

INSERT INTO exams (`name`) VALUES 
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

INSERT INTO students(`name`) VALUES
('Mila'),
('Toni'),
('Ron');

INSERT INTO students_exams (student_id, exam_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);


------------------4-----------------------

CREATE TABLE teachers (
teacher_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
manager_id INT) AUTO_INCREMENT = 101;

INSERT INTO teachers (`name`, manager_id) VALUES
('John' , NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);

ALTER TABLE teachers 
ADD CONSTRAINT `fk_manager_teacher`
FOREIGN KEY (manager_id)
REFERENCES teachers(`teacher_id`);

---------------5--------------------------------;
CREATE SCHEMA EXERCISE_5;
USE exercise_5;
CREATE TABLE cities (
city_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL)
;

CREATE TABLE customers(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(50) NOT NULL,
birthday DATE ,
city_id INT );

CREATE TABLE orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT );

CREATE TABLE order_items(
order_id INT NOT NULL ,
item_id INT NOT NULL
);

CREATE TABLE items ( 
item_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
item_type_id INT);

CREATE TABLE item_types(
item_type_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL);

ALTER TABLE items
ADD CONSTRAINT `fk_item_itemstype`
FOREIGN KEY (item_type_id)
REFERENCES 	item_types(`item_type_id`);


ALTER TABLE order_items
ADD CONSTRAINT `pk_orderid_itemid`
PRIMARY KEY (order_id,item_id),
ADD CONSTRAINT `fk_orderitems_orders`
FOREIGN KEY (order_id)
REFERENCES orders(`order_id`),
ADD CONSTRAINT `fk_orderitems_items`
FOREIGN KEY (item_id)
REFERENCES items(`item_id`);

ALTER TABLE orders
ADD CONSTRAINT `fk_orders_customers`
FOREIGN KEY (customer_id)
REFERENCES customers(`customer_id`);

ALTER TABLE customers
ADD CONSTRAINT `fk_customers_cities`
FOREIGN KEY (city_id)
REFERENCES cities(`city_id`);

----------- 6 -----------------------
CREATE SCHEMA TASK_6;
USE TASK_6;

CREATE TABLE subjects(
subject_id INT PRIMARY KEY AUTO_INCREMENT,
subject_name VARCHAR(50) NOT NULL);

CREATE TABLE majors(
major_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL);

CREATE TABLE students(
student_id INT PRIMARY KEY auto_increment,
student_number VARCHAR(12),
student_name VARCHAR(50),
major_id INT,
CONSTRAINT `fk_students_majors`
FOREIGN KEY (major_id)
REFERENCES majors(`major_id`)
);

CREATE TABLE agenda(
student_id INT NOT NULL,
subject_id INT NOT NULL,
CONSTRAINT `pk_agenda_studentsubject`
PRIMARY KEY (student_id,subject_id),
CONSTRAINT `fk_agenda_students`
FOREIGN KEY (student_id)
REFERENCES students(`student_id`),
CONSTRAINT `fk_agenda_subjects`
FOREIGN KEY (subject_id)
REFERENCES subjects(`subject_id`)
);

CREATE TABLE payments(
payment_id INT PRIMARY KEY AUTO_INCREMENT,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT,
CONSTRAINT `fk_payments_students`
FOREIGN KEY (student_id)
REFERENCES students(`student_id`)
);

------------- 9 --------------------
SELECT 
    m.mountain_range, p.peak_name, p.elevation
FROM
    mountains AS m
        JOIN
    peaks AS p ON p.mountain_id = m.id
WHERE
    m.mountain_range = 'Rila'
ORDER BY p.elevation DESC;
