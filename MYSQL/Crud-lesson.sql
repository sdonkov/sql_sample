SELECT id, first_name, last_name, job_title FROM employees;


SELECT id, CONCAT_ws(" ", first_name, last_name) AS 'full_name',
job_title, salary FROM  employees WHERE salary >= 1000;

UPDATE employees SET salary =salary + 100 WHERE job_title = 'Manager';
SELECT salary FROM employees;

SELECT * FROM employees order by salary DESC LIMIT 1;

SELECT * FROM employees WHERE department_id = 4 AND salary >= 1000 order by id asc;

DELETE FROM employees WHERE department_id = 1 or department_id = 2;
select *  FROM employees order by id asc;