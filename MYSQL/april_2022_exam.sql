CREATE SCHEMA softuni_imdb;
USE softuni_imdb;

CREATE TABLE movies_additional_info(
id INT AUTO_INCREMENT PRIMARY KEY,
rating DECIMAL (10,2) NOT NULL,
runtime INT NOT NULL,
picture_url VARCHAR(80) NOT NULL,
budget DECIMAL (10,2),
release_date DATE NOT NULL,
has_subtittles TINYINT (1),
description TEXT
);

CREATE TABLE movies (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(20) NOT NULL,
country_id INT NOT NULL,
movie_info_id INT NOT NULL
);

CREATE TABLE genres_movies (
genre_id INT,
movie_id INT
);

CREATE TABLE genres (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
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
name VARCHAR(30) NOT NULL,
contitent VARCHAR(30) NOT NULL,
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



