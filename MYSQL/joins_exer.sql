SELECT e.employee_id, e.job_title, a.address_id, a.address_text
FROM employees as e
JOIN addresses AS a ON a.address_id = e.address_id
ORDER BY address_id asc LIMIT 5; 

------------------- 2 --------------------------------------
SELECT first_name, last_name, t.`name` as `town`, address_text
FROM employees AS e 
JOIN addresses AS a ON a.address_id = e.address_id
JOIN towns AS t ON t.town_id = a.town_id 
ORDER BY first_name asc, last_name asc 
LIMIT 5;

-------------------- 3 --------------------------
SELECT employee_id, first_name, last_name, d.`name` AS `department_name`
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE d.`name` = 'Sales' 
ORDER BY employee_id desc;
------------------- 4 -------------------------

SELECT employee_id, first_name, salary, d.`name` AS `department_name`
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE salary > 15000 
ORDER BY d.department_id desc
LIMIT 5;
---------------------- 5 --------------------------
SELECT  e.employee_id, e.first_name 
FROM employees_projects AS ep 
RIGHT JOIN employees AS e ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY employee_id desc LIMIT 3;

--------------------- 6 ----------------------
SELECT e.first_name, e.last_name, e.`hire_date`, d.`name` AS `dept_name`
FROM employees AS e 
JOIN departments AS d ON e.department_id = d.department_id
WHERE e.`hire_date` > '1999/1/1' AND d.`name` in ('Sales', 'Finance')
ORDER BY e.hire_date ASC;

------------------ 7 --------------------------------
SELECT e.employee_id, e.first_name, p.`name` 
FROM employees as e
JOIN employees_projects as ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON p.project_id = ep.project_id
WHERE DATE(p.start_date) > '2002/08/13' AND p.end_date IS NULL
ORDER BY e.first_name asc, p.`name` asc
limit 5 ;
 -- има грешка в задачата при подаването и в джъдж четвъртият Alice изчезва
 
 ----------------- 8 ----------------------
SELECT e.employee_id, e.first_name, CASE 
WHEN YEAR(p.start_date) > 2004 THEN '' 
ELSE p.name
END AS `project_name`
FROM employees AS e
JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
JOIN projects AS p ON  ep.project_id = p.project_id
WHERE e.employee_id = 24
ORDER BY project_name;
----------------------- 9 ----------------
SELECT e.employee_id, e.first_name, e.manager_id, e2.first_name AS `manager_name`
FROM employees AS e
JOIN employees AS e2 ON e.manager_id = e2.employee_id
WHERE e.manager_id IN (3,7)
order by e.first_name;

----------------- 10 ------------------------
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS `name`,
    CONCAT(e2.first_name, ' ', e2.last_name) AS `manager_name`,
    d.`name` AS `department_name`
FROM
    employees AS e
        JOIN
    departments AS d ON d.department_id = e.department_id
        JOIN
    employees AS e2 ON e.manager_id = e2.employee_id
ORDER BY employee_id 
LIMIT 5;

-------------------- 11 ----------------------
SELECT avg(salary) AS `min_average_salary`
FROM employees AS e 
JOIN departments AS d ON d.department_id = e.department_id
GROUP BY d.department_id
ORDER BY `min_average_salary` 
LIMIT 1;

------------------ 12 ------------------------
SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM mountains_countries as mc
JOIN mountains AS m ON m.id = mc.mountain_id
JOIN peaks AS p ON p.mountain_id = m.id
WHERE p.elevation > 2835 AND country_code = 'BG'
order by p.elevation desc;

--------------- 13 ---------------------------
SELECT country_code, COUNT(m.mountain_range) AS `mountain_range`
FROM mountains_countries AS mc
JOIN mountains AS m ON m.id = mc.mountain_id
WHERE country_code IN ('BG','US','RU')
GROUP BY mc.country_code
ORDER BY mountain_range desc;

------------------- 14 -------------------
SELECT c.country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers AS cr ON cr.country_code = c.country_code
LEFT JOIN rivers AS r ON r.id = cr.river_id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

------------------- 16 -----------------
SELECT count(*) from countries AS c
LEFT JOIN mountains_countries AS mc ON mc.country_code = c.country_code
WHERE mc.country_code IS NULL;

---------------- 17 ----------------------
SELECT c.country_name as `country_name`, MAX(p.elevation) AS `highest_peak_elevation`, MAX(r.length) AS `longest_river_lenght`
FROM countries AS c
LEFT JOIN mountains_countries AS mc ON mc.country_code = c.country_code
LEFT JOIN peaks AS p ON p.mountain_id = mc.mountain_id
LEFT JOIN countries_rivers AS cr ON c.country_code = cr.country_code
LEFT JOIN rivers AS r ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY `highest_peak_elevation` desc, `longest_river_lenght` desc , c.country_name
LIMIT 5;

------------------ 15 -----------------------
SELECT 
	c.continent_code,
    c.currency_code,
     COUNT(*) AS `currency_usage`
FROM
    countries AS c
GROUP BY c.currency_code, c.continent_code
HAVING `currency_usage` > 1
AND `currency_usage` = (SELECT COUNT(*) AS cn FROM countries AS c2 WHERE c2.continent_code = c.continent_code
GROUP BY c2.currency_code
ORDER BY cn DESC
LIMIT 1 )
ORDER BY c.continent_code




