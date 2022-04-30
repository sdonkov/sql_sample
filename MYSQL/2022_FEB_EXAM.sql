CREATE SCHEMA online_store;
USE online_store;

CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
phone VARCHAR(30) NOT NULL UNIQUE,
address VARCHAR(60) NOT NULL,
discount_card BIT (1) NOT NULL DEFAULT FALSE
);

CREATE TABLE orders (
id INT PRIMARY KEY AUTO_INCREMENT,
order_datetime DATETIME NOT NULL,
customer_id INT NOT NULL
);

CREATE TABLE orders_products (
order_id INT,
product_id INT
);

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL,
price DECIMAL (19,2) NOT NULL,
quantity_in_stock INT,
description TEXT,
brand_id INT NOT NULL,
category_id INT NOT NULL,
review_id INT
);

CREATE TABLE reviews (
id INT PRIMARY KEY AUTO_INCREMENT,
content TEXT,
rating DECIMAL (10,2) NOT NULL,
picture_url VARCHAR(80) NOT NULL,
published_at DATETIME NOT NULL
);

CREATE TABLE brands (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE);

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE);

ALTER TABLE orders 
ADD CONSTRAINT `fk_orders_customers`
FOREIGN KEY (customer_id) REFERENCES customers(id);

ALTER TABLE orders_products
ADD CONSTRAINT `fk_mapping_orders`
FOREIGN KEY (order_id) REFERENCES orders(id),
ADD CONSTRAINT `fk_mapping_procuts`
FOREIGN KEY (product_id) REFERENCES products(id);

ALTER TABLE products 
ADD CONSTRAINT `fk_products_brands`
FOREIGN KEY (brand_id) REFERENCES brands(id),
ADD CONSTRAINT `fk_products_categories`
FOREIGN KEY (category_id) REFERENCES categories(id),
ADD CONSTRAINT `fk_products_reviews`
FOREIGN KEY (review_id) REFERENCES reviews(id);

---------------------------------------------------------

INSERT INTO reviews (content, picture_url, published_at, rating)
SELECT SUBSTRING(p.`description`, 1, 15), REVERSE(p.`name`), DATE("2010-10-10"), p.price / 8
FROM products AS p WHERE p.id >= 5;

SELECT * FROM reviews;

------------------------------------------------------------
UPDATE products 
SET quantity_in_stock = quantity_in_stock - 5
WHERE quantity_in_stock >= 60 AND quantity_in_stock <=70;


----------------------------------------------


DELETE c FROM customers AS c 
LEFT JOIN orders AS o ON o.customer_id = c.id
WHERE o.customer_id IS NULL;


---------------------------------------------------

SELECT * from categories
ORDER BY NAME DESC;

----------------------------------------------------
SELECT id, brand_id, name, quantity_in_stock FROM products AS p
WHERE price  > 1000 AND quantity_in_stock <30
ORDER BY quantity_in_stock, id;


---------------------------------------------------

SELECT id, content, rating, picture_url, published_at FROM reviews
WHERE content LIKE "My%" AND char_length(content) > 61
ORDER BY rating DESC;

---------------------------------------------------
SELECT CONCAT(c.first_name, " ", c.last_name) AS `full_name`, c.address, o.order_datetime FROM customers AS c
JOIN orders AS o ON c.id = o.customer_id
WHERE YEAR(o.order_datetime) <= 2018
ORDER BY `full_name` DESC;

---------------------------------------------------------------
SELECT COUNT(p.category_id) AS items_count, c.name, SUM(p.quantity_in_stock) AS total_quantity
FROM categories AS c
JOIN products AS p ON c.id = p.category_id
GROUP BY p.category_id
ORDER BY items_count DESC, total_quantity ASC
LIMIT 5;


--------------------------------------------------------------

delimiter ##
CREATE FUNCTION `udf_customer_products_count` (name VARCHAR(30))
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(c.id) FROM  orders AS o
		JOIN customers AS c ON c.id = o.customer_id
		JOIN orders_products AS op ON op.order_id = o.id
        WHERE name =  c.first_name
        GROUP BY c.id);
END
##

SELECT c.first_name,c.last_name, udf_customer_products_count('Shirley') as `total_products` FROM customers c
WHERE c.first_name = 'Shirley';

-------------------------------------------------------------
DELIMITER ##
CREATE PROCEDURE `udp_reduce_price` (category_name VARCHAR(50))

BEGIN	
UPDATE categories AS c 
JOIN products AS p ON c.id = p.category_id 
JOIN reviews AS r ON r.id = p.review_id
SET p.price = p.price * 0.7
WHERE r.rating < 4 AND category_name = c.name;
END
##

CALL udp_reduce_price ('Phones and tablets');

##
SELECT * from products

