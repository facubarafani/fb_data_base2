CREATE DATABASE IF NOT EXISTS imdb;
USE imdb;
CREATE TABLE film(
film_id INT NOT NULL AUTO_INCREMENT,
title VARCHAR(25),
description VARCHAR(50),
release_year YEAR NOT NULL,
CONSTRAINT pk_film PRIMARY KEY (film_id)
);

CREATE TABLE actor(
actor_id INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(25),
last_name VARCHAR(30),
CONSTRAINT pk_actor PRIMARY KEY (actor_id)
);

CREATE TABLE film_actor(
filmactor_id INT NOT NULL AUTO_INCREMENT,
film_id INT NOT NULL,
actor_id INT NOT NULL,
CONSTRAINT pk_filmactor PRIMARY KEY (filmactor_id)
);
ALTER TABLE film_actor ADD CONSTRAINT film_fk FOREIGN KEY (film_id) REFERENCES film(film_id);
ALTER TABLE film_actor ADD CONSTRAINT actor_fk FOREIGN KEY (actor_id) REFERENCES actor(actor_id);

ALTER TABLE actor ADD last_update DATE;
ALTER TABLE film ADD last_update DATE;

INSERT INTO actor(first_name,last_name) VALUES ('Tom','Hanks');
INSERT INTO film(title,description,release_year) VALUES ('Forrest Gump','Run Forrest run',1994);
INSERT INTO film_actor(film_id,actor_id) VALUES (1,1)

