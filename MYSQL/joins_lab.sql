SELECT e.employee_id, CONCAT(e.first_name, " ", e.last_name) AS full_name, d.department_id, d.`name` AS deparment_name FROM employees AS e 
JOIN departments AS d ON e.employee_id = d.manager_id
ORDER BY employee_id LIMIT 5;

------------------------------------------------

SELECT a.town_id, t.name, a.address_text
FROM towns as t
JOIN addresses as a ON a.town_id = t.town_id
WHERE t.town_id in (9,15,32)
ORDER BY t.town_id, a.address_id;

---------------------------------------------

SELECT e.employee_id, e.first_name, e.last_name, e.department_id, e.salary FROM
employees AS e 
WHERE e.manager_id IS NULL;

-------------------------------------------------

SELECT count(*) FROM employees 
WHERE salary > (SELECT avg(salary) FROM employees);