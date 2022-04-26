create SCHEMA instd;
USE instd;

CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(30) NOT NULL,
`password` VARCHAR(30) NOT NULL,
email VARCHAR(50) NOT NULL,
gender CHAR (1) NOT NULL,
age INT NOT NULL,
job_title VARCHAR(40) NOT NULL,
ip VARCHAR(30) NOT NULL
);

CREATE TABLE addresses (
id INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(30) NOT NULL,
town VARCHAR(30) NOT NULL,
country VARCHAR(30) NOT NULL,
user_id INT NOT NULL
);

CREATE TABLE likes (
id INT AUTO_INCREMENT PRIMARY KEY,
photo_id INT,
user_id INT
);

CREATE TABLE users_photos (
user_id INT NOT NULL,
photo_id INT NOT NULL
);

CREATE TABLE photos (
id INT AUTO_INCREMENT PRIMARY KEY,
`description` TEXT NOT NULL,
date DATETIME NOT NULL,
views INT NOT NULL DEFAULT 0
);

CREATE TABLE comments (
id INT AUTO_INCREMENT PRIMARY KEY,
comment VARCHAR(255) NOT NULL,
date DATETIME NOT NULL,
photo_id INT NOT NULL
);

ALTER table addresses
ADD CONSTRAINT `fk_addr_users`
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE likes 
ADD CONSTRAINT `fk_likes_photos`
FOREIGN KEY (photo_id) REFERENCES photos(id),
ADD CONSTRAINT `fk_likes_users`
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE users_photos
ADD CONSTRAINT `fk_usrph_users`
FOREIGN KEY (user_id) REFERENCES users(id),
ADD CONSTRAINT `fk_usrph_photos`
FOREIGN KEY (photo_id) REFERENCES photos(id);

ALTER TABLE comments
ADD CONSTRAINT `fk_comments_photos`
FOREIGN KEY (photo_id) REFERENCES photos(id);
--------------------------------------
INSERT INTO addresses (address, town, country, user_id)
SELECT u.username,u.`password`,u.ip,u.age FROM users AS u
WHERE u.gender = "M";

---------------------------------------
UPDATE addresses AS a
SET country = CASE
        WHEN country LIKE 'B%' THEN 'Blocked'
        WHEN country LIKE'T%' THEN 'Test'
        WHEN country LIKE'P%' THEN 'In Progress'
        ELSE country
    END;

-------------------------------------------------
DELETE FROM addresses WHERE id % 3 = 0;

---------------------------------------------------
SELECT `username`, `gender`, `age` FROM users 
ORDER BY age DESC,username;

--------------------------------------------------
SELECT p.id, p.`date`, `description`, COUNT(p.id) AS commentsCount
FROM photos AS p
JOIN comments AS c ON c.photo_id = p.id
GROUP BY p.id
ORDER BY commentsCount desc, p.id
LIMIT 5;

------------------------------------------------------------
SELECT CONCAT(u.id, " ",u.username) AS id_username, u.email
FROM users AS u
JOIN users_photos AS up ON u.id = up.user_id
WHERE up.user_id = up.photo_id
ORDER BY u.id;

----------------------------------------------------
SELECT p.id , COUNT(DISTINCT l.id) AS likes_count, COUNT(DISTINCT c.id) AS comments_count 
FROM photos AS p
LEFT JOIN likes AS l ON l.photo_id = p.id
LEFT JOIN  comments AS c ON c.photo_id = p.id
GROUP BY p.id
ORDER BY likes_count DESC, comments_count DESC, p.id;

---------------------------------------------------------
SELECT CONCAT(substring(description,1,30), '...') AS `summary`, `date`
FROM photos
WHERE day(date) = 10
ORDER BY `date` DESC;

-----------------------------------------------------------
delimiter ##
CREATE FUNCTION `udf_users_photos_count` (username VARCHAR (30))
RETURNS INTEGER 
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(user_id) FROM users_photos AS up
    JOIN users AS u ON u.id = up.user_id
	WHERE username =u.username);
END
##

delimiter ;

--------------------------------------------------------
DELIMITER ## 
CREATE PROCEDURE `udp_modify_user` (address VARCHAR(30), town VARCHAR(30))
BEGIN
	UPDATE users AS u 
    JOIN addresses AS a ON u.id = a.user_id
    SET age = age +10
    WHERE  address = a.address AND town = a.town;
END
##

CALL udp_modify_user ('97 Valley Edge Parkway', 'Divinópolis');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';
