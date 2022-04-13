select first_name, last_name from employees where substring(first_name, 1, 2) ="Sa";

select first_name, last_name from employees WHERE last_name LIKE '%ei%';

select first_name from employees WHERE department_id in (3,10) and year(hire_date)
between 1995 and 2005 order by employee_id asc;

select first_name, last_name from employees WHERE job_title not LIKE "%engineer%";

SELECT `name` from towns WHERE char_length(`name`) in(5,6) order by `name` asc;

SELECT town_id, `name` from towns WHERE `name` LIKE "M%"
OR `name` LIKE "B%" OR `name` LIKE "E%" OR `NAME` LIKE 'K%'
order by `name` asc;

select town_id, `name` from towns WHERE `name` NOT LIKE 'R%'
AND `name` not LIKE "B%" AND `name` not LIKE "D%"
order by `name` asc;

CREATE VIEW `v_employees_hired_after_2000` AS SELECT first_name, last_name
 FROM employees WHERE YEAR(hire_date) > 2000;

select * from v_employees_hired_after_2000 ;

SELECT first_name, last_name FROM employees where char_length(last_name) = 5;

select country_name, iso_code FROM  countries WHERE (char_length(country_name) - 
char_length(replace(lower(country_name), 'a', ''))) >= 3 
order by iso_code; 


SELECT peak_name, river_name, group_concat(peak_name,river_name) AS mix  from  rivers, peaks;

select peak_name, river_name, lower(concat(left(peak_name,char_length(peak_name)-1), river_name))
AS mix from rivers,peaks WHERE lower(right(peak_name,1)) = lower(left(river_name,1)) order by mix;

SELECT peak_name, river_name, lower(concat(peak_name, SUBSTRING(river_name, 2))) AS MIX
FROM rivers,peaks WHERE lower(right(peak_name,1)) = LOWER(left(river_name,1))
order by mix;

SELECT `name`, DATE_FORMAT(start,"%Y-%m-%d") AS start FROM games
WHERE YEAR(start) in (2011,2012)
order by date(start), name limit 50;


select user_name, RIGHT(email, length(email) - instr(email,'@'))
 AS email_provider FROM users 
 order by email_provider, user_name;

select user_name, SUBSTRING_INDEX(email, "@", -1) AS email_provider
FROM USERS order by email_provider, user_name;

select * from users;

SELECT user_name, ip_address FROM users 
WHERE ip_address LIKE "___.1%.%.___"
ORDER BY user_name;

select * from games;


select name AS `game`,
CASE 
WHEN hour(start)>= 0 and hour(start)<12  THEN 'Morning'
WHEN hour(start) >=12 and hour(start)< 18 THEN 'Afternoon'
ELSE 'Evening'
END
AS `Part of the Day`,
CASE 
WHEN duration <= 3 THEN 'Extra Short'
WHEN duration > 3 AND duration <=6 THEN 'Short'
WHEN duration >6 AND duration <=10 THEN 'Long'
ELSE 'Extra Long'
END
AS `Duration`
FROM games;

select * from orders;

select product_name, order_date, date_add(order_date, INTERVAL 3  DAY) AS `pay_due`,
date_add(order_date, INTERVAL 1 MONTH) AS `delivery_due`
FROM orders;


