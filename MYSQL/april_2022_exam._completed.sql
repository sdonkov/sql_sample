create SCHEMA softuni_imdb;
USE softuni_imdb;

CREATE TABLE movies_additional_info(
id INT AUTO_INCREMENT PRIMARY KEY,
rating DECIMAL (10,2) NOT NULL,
runtime INT NOT NULL,
picture_url VARCHAR(80) NOT NULL,
budget DECIMAL (10,2),
release_date DATE NOT NULL,
has_subtitles TINYINT (1),
description TEXT
);

CREATE TABLE movies (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(70) NOT NULL UNIQUE,
country_id INT NOT NULL,
movie_info_id INT NOT NULL UNIQUE
);

CREATE TABLE genres_movies (
genre_id INT,
movie_id INT
);

CREATE TABLE genres (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE movies_actors(
movie_id INT,
actor_id INT
);

CREATE TABLE actors (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birthdate DATE NOT NULL,
height INT,
awards INT,
country_id INT NOT NULL
);

CREATE TABLE countries (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) UNIQUE NOT NULL,
continent VARCHAR(30) NOT NULL,
currency VARCHAR(5) NOT NULL
);

ALTER TABLE movies 
ADD CONSTRAINT `fk_movies_countries`
FOREIGN KEY (country_id) REFERENCES countries(id),
ADD CONSTRAINT `fk_movies_addinfo`
FOREIGN KEY (movie_info_id) REFERENCES movies_additional_info(id);

ALTER TABLE genres_movies
ADD CONSTRAINT `fk_genresmovies_genres`
FOREIGN KEY (genre_id) REFERENCES genres(id),
ADD CONSTRAINT `fk_genresmovies_movie`
FOREIGN KEY (movie_id) REFERENCES movies(id);

ALTER TABLE movies_actors
ADD CONSTRAINT `fk_moviesactors_movies`
FOREIGN KEY (movie_id) REFERENCES movies(id),
ADD CONSTRAINT `fk_moviesactors_actors`
FOREIGN KEY (actor_id) REFERENCES actors(id);

ALTER TABLE actors
ADD CONSTRAINT `fk_actors_contries`
FOREIGN KEY (country_id) REFERENCES countries(id);

-------------------------------------------------------
INSERT INTO actors (first_name, last_name ,birthdate, height, awards,country_id) 
SELECT REVERSE(first_name), REVERSE(last_name), DATE_ADD(birthdate, INTERVAL -2 DAY), height + 10, country_id, 3 FROM actors
WHERE id <= 10; 

-----------------------------------------------------------
UPDATE movies_additional_info 
SET runtime = runtime - 10
WHERE movies_additional_info.id >= 15 AND movies_additional_info.id <=25;

-------------------------------------------------------------

DELETE c FROM countries AS c 
LEFT JOIN movies AS m ON c.id = m.country_id
WHERE m.country_id IS NULL;

----------------------------------------------------------
SELECT id, name, continent, currency FROM countries 
order by currency desc, id;


--------------------------------------------------
SELECT m.id, m.title, i.runtime, i.budget, i.release_date
FROM movies_additional_info AS i
JOIN movies AS m ON m.movie_info_id = i.id
WHERE YEAR(i.release_date) >= 1996 AND year(i.release_date) <=1999
ORDER BY i.runtime ASC, i.id 
LIMIT 20;

----------------------------------------------------
SELECT CONCAT(first_name, " ", last_name) AS full_name, CONCAT(REVERSE(last_name), CHAR_LENGTH(last_name), "@cast.com") AS email,
(2022 - YEAR(birthdate)) AS age, height 
FROM actors AS a
LEFT JOIN movies_actors AS ma ON a.id = ma.actor_id
WHERE ma.actor_id IS NULL
ORDER BY height ASC;

-----------------------------------------------------
SELECT c.`name`, COUNT(m.country_id) AS `movies_count` FROM countries AS c
JOIN movies AS m ON c.id = m.country_id
GROUP BY m.country_id
HAVING `movies_count` >=7
ORDER BY c.`name` desc;

----------------------------------------------------
SELECT m.title, 
CASE 
	WHEN info.rating <= 4 THEN 'poor'
    WHEN info.rating <= 7 THEN 'good'
    WHEN info.rating > 7 THEN "excellent"
    END AS rating,
CASE 
	WHEN info.has_subtitles = 1 THEN 'english'
    WHEN info.has_subtitles = 0 THEN "-"
    END AS subtitles,
    info.budget 
FROM movies AS m 
JOIN movies_additional_info AS info ON  m.movie_info_id = info.id
ORDER BY info.budget DESC;


----------------------------------------------
DELIMITER ##
CREATE FUNCTION `udf_actor_history_movies_count` (full_name VARCHAR(50))
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(*) from actors AS a 
JOIN movies_actors AS ma ON ma.actor_id = a.id
JOIN movies AS m ON m.id = ma.movie_id
JOIN genres_movies AS gm ON m.id = gm.movie_id
WHERE gm.genre_id = 12 AND full_name = CONCAT(a.first_name, " ",a.last_name));
END
##
SELECT udf_actor_history_movies_count('Stephan Lundberg')  AS 'history_movies';
SELECT udf_actor_history_movies_count('Jared Di Batista')  AS 'history_movies';


delimiter ; 
-----------------------------------------------------------------
DELIMITER ##
CREATE PROCEDURE `udp_award_movie` (movie_title VARCHAR(50))

BEGIN
	UPDATE movies AS m
left JOIN movies_actors AS ma ON m.id = ma.movie_id
LEFT JOIN actors AS a ON ma.actor_id = a.id
SET a.awards = a.awards + 1 
WHERE movie_title = m.title;
END

##



CALL udp_award_movie('Tea For Two');


