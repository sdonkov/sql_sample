DELIMITER ##
CREATE FUNCTION ufn_count_employees_by_town(cityname VARCHAR(50))
RETURNS INT 
DETERMINISTIC
BEGIN 
DECLARE x INT;
SET x := (SELECT count(*)
FROM towns AS t
LEFT JOIN addresses AS a ON t.town_id = a.town_id
LEFT JOIN employees AS e ON e.address_id = a.address_id
WHERE t.name =cityname);

RETURN x;
END
##

DELIMITER ;
-------------------------------------------
DELIMITER ##
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(100))
BEGIN
	UPDATE employees AS e
    RIGHT JOIN departments AS d ON e.department_id = d.department_id
    SET salary = salary + salary * 0.05
    WHERE d.name = department_name;
END
##

DELIMITER ;

----------------------------------
DELIMITER ##

CREATE PROCEDURE usp_raise_salary_by_id(userid INT)
BEGIN
	IF ( (SELECT COUNT(*) FROM employees WHERE employee_id = userid) > 0)
    THEN
		UPDATE employees SET salary = salary * 1.05 WHERE employee_id = userid;
	END IF;
END
##

DELIMITER ;

------------------------------------------------------------
CREATE TABLE deleted_employees(
	`employee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(20),
    `last_name` VARCHAR(20),
    `middle_name` VARCHAR(20),
    `job_title` VARCHAR(50),
    `department_id` INT,
    `salary` DOUBLE
);

CREATE TRIGGER trigger_employee AFTER DELETE
ON employees 
		FOR EACH ROW 
        INSERT INTO deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary) 
        VALUES(OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
        
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM employees WHERE employee_id = 1