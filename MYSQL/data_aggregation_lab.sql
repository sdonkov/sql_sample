select department_id, count(department_id) as `number of employees`
from employees group by department_id;

select department_id, ROUND(AVG(salary),2) AS `Average Salary`
from employees group by department_id;

select department_id, MIN(salary) as `Min Salary`
from employees
group by department_id
HAVING `Min Salary` > 800;

select count(category_id) from products where price >8 and category_id = 2;

select category_id, ROUND(AVG(price),2) AS `Average Price`,
min(price) AS `Cheapest Product`,
max(price) AS  `Most Expensive Product` from products group by category_id