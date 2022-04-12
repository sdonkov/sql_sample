select count(*) from wizzard_deposits ;

select max(magic_wand_size) as longest_magic_wand
from wizzard_deposits;

select deposit_group, max(magic_wand_size) as longest_magic_wand
from wizzard_deposits group by (deposit_group)
order by longest_magic_wand asc, deposit_group asc;

select deposit_group from wizzard_deposits
group by deposit_group order by avg(magic_wand_size) 
limit 1;

SELECT deposit_group, SUM(deposit_amount) AS `total_sum`
FROM wizzard_deposits GROUP BY deposit_group 
ORDER BY total_sum asc;

SELECT deposit_group, SUM(deposit_amount) AS `total_sum`
FROM wizzard_deposits WHERE magic_wand_creator = "Ollivander family"
group by deposit_group order by deposit_group asc;

SELECT deposit_group, SUM(deposit_amount) AS `total_sum`
FROM wizzard_deposits WHERE magic_wand_creator = "Ollivander family"
group by deposit_group
HAVING `total_sum` <150000
order by total_sum desc;

select * from wizzard_deposits;

SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS
`min_deposit_charge` FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator asc, deposit_group asc;

SELECT CASE
    WHEN age <= 10 THEN '[0-10]'
	WHEN age BETWEEN 11 and 20 THEN '[11-20]'
    WHEN age BETWEEN 21 and 30 THEN '[21-30]'
    WHEN age BETWEEN 31 and 40 THEN '[31-40]'
    WHEN age BETWEEN 41 and 50 THEN '[41-50]'
    WHEN age BETWEEN 51 and 60 THEN '[51-60]'
    WHEN age >= 61 THEN  '[61+]'
    END AS `age_group`,
count(*) AS `wizzard_count` FROM wizzard_deposits
group by `age_group` order by `age_group`;
    
select * from wizzard_deposits WHERE deposit_group = "Troll Chest";

SELECT CASE
WHEN deposit_group = "Troll Chest" THEN LEFT(first_name,1)
END AS `first_letter`
from wizzard_deposits
GROUP by first_letter HAVING first_letter is not null
order by first_letter asc;

select deposit_group, is_deposit_expired,
AVG(deposit_interest) AS `deposit_interest`
FROM wizzard_deposits WHERE deposit_start_date > '1985/01/01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group desc, is_deposit_expired asc;

SELECT department_id, min(salary) AS `minimum_salary`
FROM employees WHERE hire_date > '2000/01/01'
AND department_id in (2,5,7)
GROUP BY department_id 
ORDER BY department_id asc;
------------- 13 -------------------------
CREATE TABLE new_table 
SELECT * from employees WHERE salary > 30000;

DELETE FROM new_table WHERE manager_id = 42;

UPDATE new_table 
SET salary = salary + 5000 
WHERE department_id = 1;

SELECT department_id, AVG(salary) AS `avg_salary`
FROM new_table 
group by department_id 
order by department_id asc;

----------------- 14 -------------------------
SELECT department_id, MAX(salary) AS `max_salary`
from employees 
group by department_id
HAVING `max_salary` not between 30000 and 70000
order by department_id;


-------------------- 15 ----------------------

SELECT count(salary) AS`` from employees 
WHERE manager_id is null;

------------------ 16 ------------------------

SELECT 
    department_id,
    (SELECT DISTINCT
            salary
        FROM
            employees AS t2 
        WHERE
            t1.department_id = t2.department_id
        ORDER BY salary DESC
        LIMIT 2 , 1) AS `third_highest_salary`
FROM
    employees AS t1 
GROUP BY department_id
HAVING third_highest_salary IS NOT NULL
ORDER BY department_id;

------------------ 17 -----------------------------

SELECT 
    t1.first_name,
    t1.last_name, 
    t1.department_id
    FROM
    employees AS t1 
    JOIN
    (SELECT 
            t2.department_id, AVG(t2.salary) AS salary
        FROM
            employees AS t2
        GROUP BY t2.department_id) AS dep_average ON t1.department_id = dep_average.department_id
WHERE t1.salary > dep_average.salary
ORDER BY t1.department_id, t1.employee_id
LIMIT 10;


----------------- 18 ------------------------

SELECT department_id, sum(salary) AS `total_salary`
FROM employees
group by department_id
order by department_id