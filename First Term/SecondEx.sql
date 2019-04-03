-- USING SAKILA DB
USE sakila;
-- EX1

SELECT title,special_features FROM film
WHERE rating = 'PG-13';

-- EX2

SELECT DISTINCT length from film;

-- EX3

SELECT title,rental_rate,replacement_cost FROM film
WHERE replacement_cost BETWEEN 20 AND 24
ORDER BY replacement_cost asc;

-- EX4

SELECT title,category.name,rating
FROM film, film_category, category
WHERE film.film_id = film_category.film_id AND film.special_features = 'Behind the Scenes'
AND film_category.category_id = category.category_id;

-- EX5

SELECT first_name,last_name
FROM actor, film, film_actor
WHERE film.title = 'ZOOLANDER FICTION' AND film.film_id = film_actor.film_id
AND actor.actor_id = film_actor.actor_id;

-- EX6

SELECT address,city,country
FROM store, address, city, country
WHERE store.store_id = 1 AND store.address_id = address.address_id
AND address.city_id = city.city_id AND city.country_id = country.country_id;

-- EX7

SELECT f1.title,f2.title, f1.rating
FROM film f1, film f2
WHERE f1.rating = f2.rating AND f1.film_id <> f2.film_id;

-- EX8

SELECT DISTINCT title, staff.first_name, staff.last_name
FROM film,inventory,store,staff
WHERE store.store_id = 2 AND film.film_id = inventory.film_id
AND inventory.store_id = store.store_id AND store.store_id = staff.store_id;