CREATE SCHEMA sgd;
USE sgd;

CREATE TABLE addresses (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL);

CREATE TABLE offices (
id INT PRIMARY KEY AUTO_INCREMENT,
workspace_capacity INT NOT NULL,
website VARCHAR(50),
address_id INT NOT NULL
);

CREATE TABLE teams (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR (40) NOT NULL,
office_id INT NOT NULL,
leader_id INT NOT NULL UNIQUE
);

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
age INT NOT NULL,
salary DECIMAL (10,2) NOT NULL,
job_title VARCHAR(20) NOT NULL,
happiness_level CHAR(1) NOT NULL
);

CREATE TABLE games (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE,
description TEXT,
rating FLOAT NOT NULL DEFAULT 5.5,
budget DECIMAL(10,2) NOT NULL,
release_date DATE,
team_id INT NOT NULL
);

CREATE TABLE games_categories (
game_id INT,
category_id INT
);

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(10) NOT NULL);

ALTER TABLE offices 
ADD CONSTRAINT `fk_offices_addresses`
FOREIGN KEY (address_id) REFERENCES addresses(id);

ALTER TABLE teams
ADD CONSTRAINT `fk_teams_offices`
FOREIGN KEY (office_id) REFERENCES offices(id), 
ADD CONSTRAINT `fk_teams_employees`
FOREIGN KEY (leader_id) REFERENCES employees(id);

ALTER TABLE games
ADD CONSTRAINT `fk_games_teams`
FOREIGN KEY (team_id) REFERENCES teams(id);

ALTER TABLE games_categories
ADD CONSTRAINT `pk_games_cat_composite`
PRIMARY KEY (game_id, category_id);

ALTER TABLE games_categories 
ADD CONSTRAINT `fk_composite_games`
FOREIGN KEY (game_id) REFERENCES games(id), 
ADD CONSTRAINT `fk_composite_cat`
FOREIGN KEY (category_id) REFERENCES categories(id);

----------------------------------------------------------

INSERT INTO games (`name`, rating, budget, team_id) 
SELECT REVERSE(SUBSTRING(lower(t.name), 2, 10000000)), t.id, leader_id *1000, t.id 
FROM teams AS t 
WHERE t.id >=1 AND t.id <=9;

---------------------------------------------------------------
UPDATE employees AS e
JOIN teams AS t ON e.id = t.leader_id
SET salary = salary + 1000
WHERE age < 40 AND salary < 5000;

-------------------------------------------------------------------

DELETE g FROM games AS g 
LEFT JOIN games_categories AS gc ON gc.game_id = g.id
WHERE g.release_date IS NULL AND gc.category_id IS NULL;
--------------------------------------------------------------

SELECT first_name, last_name, age, salary, happiness_level FROM employees
ORDER by salary ,id;

------------------------------------------------------------------

SELECT t.name AS team_name, a.name AS addresss_name, length(a.name) AS count
FROM teams AS t 
JOIN offices AS o ON o.id = t.office_id
JOIN addresses AS a ON o.address_id = a.id
WHERE o.website IS NOT NULL
ORDER BY t.name, a.name;

----------------------------------------------------------
SELECT c.name, COUNT(c.name) AS games_count, ROUND(AVG(g.budget),2) AS avg_budget, MAX(g.rating) AS max_rating
FROM categories AS c 
JOIN games_categories AS gc ON c.id = gc.category_id
JOIN games AS g ON g.id = gc.game_id
GROUP BY c.name
HAVING max_rating > 9.4
ORDER BY games_count DESC, c.name;

------------------------------------------------------------
SELECT g.name, g.release_date, CONCAT(SUBSTRING(g.description , 1, 10), "...") AS summary,
CASE WHEN month(g.release_date) IN (1,2,3) THEN "Q1"
	WHEN month(g.release_date) IN (4,5,6) THEN "Q2"
    WHEN month(g.release_date) IN (7,8,9) THEN "Q3"
    WHEN month(g.release_date) IN (10,11,12) THEN "Q4" 
    END AS `Quarters`,
    t.name
FROM games AS g
JOIN teams AS t ON t.id = g.team_id
WHERE g.name LIKE "%2" AND month(g.release_date) % 2 =0 AND year(g.release_date) = 2022
ORDER BY Quarters;


------------------------------------------------------------------
SELECT g.name, CASE 
WHEN g.budget < 50000 THEN "Normal budget"
WHEN g.budget >50000 THEN "Insufficient budget" END AS budget_level,
t.name AS team_name, a.name AS address_name
FROM games AS g
LEFT JOIN teams AS t ON g.team_id = t.id
LEFT JOIN offices AS o ON t.office_id = o.id
LEFT JOIN addresses AS a ON a.id = o.address_id
LEFT JOIN games_categories AS gc ON gc.game_id = g.id
WHERE g.release_date IS NULL AND gc.category_id IS NULL
ORDER BY g.name;

---------------------------------------------------------

DELIMITER ##
CREATE FUNCTION `udf_game_info_by_name` (game_name VARCHAR (20))
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
RETURN (SELECT CONCAT("The ", g.name, " is developed by a ", t.name, " in an office with an address ", a.name) AS text FROM games AS g 
		JOIN teams AS t ON t.id = g.team_id
		JOIN offices AS o ON o.id = t.office_id
		JOIN addresses AS a ON a.id = o.address_id
		WHERE game_name = g.name)
        -- GROUP BY t.id

;
END
##

SELECT udf_game_info_by_name('Bitwolf') AS info;
SELECT udf_game_info_by_name('Fix San') AS info;



DELIMITER ; 
-------------------------------------------------

DELIMITER ##
CREATE PROCEDURE `udp_update_budget` (min_game_rating FLOAT)
BEGIN 
UPDATE games AS g 
LEFT JOIN games_categories AS gc ON gc.game_id = g.id
SET budget = budget + 100000
WHERE gc.category_id IS NULL AND g.release_date IS NOT NULL 
    AND g.rating > min_game_rating;
END
##
CALL udp_update_budget (8);

