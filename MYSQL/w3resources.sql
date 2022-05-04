SELECT s.name, c.cust_name, c.city  FROM salesman AS s 
JOIN customer AS c ON c.salesman_id = s.salesman_id
WHERE c.city = s.city;


---------------------- 2 ----------------------------------

SELECT  o.ord_no,o.purch_amt,
c.cust_name,c.city 
FROM orders AS o 
JOIN customer AS c ON c.customer_id=o.customer_id 
AND o.purch_amt BETWEEN 500 AND 2000;

----------------------- 3 ------------------------------

SELECT c.cust_name AS "Customer Name" , c.city, s.name AS "Salesname", s.commission
FROM customer AS c 
JOIN salesman  AS s ON c.salesman_id = s.salesman_id; 

------------------------ 4 -----------------------------

SELECT c.cust_name AS "Customer Name", c.city, s.name AS "Salesman", s.commission 
FROM customer AS c 
JOIN salesman AS s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

------------------------- 5 -------------------------------


SELECT c.cust_name AS "Customer Name", c.city, s.name AS "Salesman", s.city, s.commission 
FROM customer AS c
JOIN salesman  AS s ON c.salesman_id = s.salesman_id
WHERE s.city != c.city AND s.commission > 0.12; 


------------------------- 6 --------------------------------

SELECT o.ord_no , o.ord_date, o.purch_amt, c.cust_name AS "Customer Name", c.grade, s.name AS "Salesman", s.commission
FROM customer AS c
JOIN orders  AS o ON c.customer_id= o.customer_id
JOIN salesman AS s ON s.salesman_id = c.salesman_id; 

--------------------------- 7 ---------------------------------

SELECT DISTINCT * 
FROM salesman AS s
JOIN customer  AS c ON c.salesman_id = s.salesman_id
JOIN orders AS o ON c.salesman_id= o.salesman_id; 

------------------ 8 ---------------------------------------


SELECT c.cust_name AS "Customer Name", c.city, c.grade, s.name AS "Salesman", s.city 
FROM customer AS c
JOIN salesman  AS s ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id


------------------------------ 9 ---------------------------


SELECT c.cust_name AS "Customer Name", c.city, c.grade, s.name AS "Salesman", s.city 
FROM customer AS c
JOIN salesman  AS s ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id

----------------------- 10 ----------------------------


SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM orders AS o 
LEFT JOIN customer AS c ON c.customer_id = o.customer_id
ORDER BY o.ord_date

--------------------------- 15 ------------------------------

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM orders AS o 
RIGHT JOIN customer AS c ON c.customer_id = o.customer_id
WHERE c.customer_id = o.customer_id

------------------------- 16 -------------------------

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM orders AS o 
RIGHT JOIN customer AS c ON c.customer_id = o.customer_id
WHERE c.grade IS NOT NULL

---------------------------- 11 -----------------------




