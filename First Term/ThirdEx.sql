USE sakila;

-- Class-06

-- Ex1

SELECT first_name,last_name
	FROM actor a1
WHERE EXISTS (SELECT *
					FROM actor a2 
					WHERE a1.last_name = a2.last_name
					AND a1.actor_id <> a2.actor_id)
ORDER BY last_name;

-- Ex 2

SELECT first_name,last_name
	FROM actor,film_actor f
WHERE EXISTS (SELECT *
					FROM film_actor
					WHERE f.film_id IS NULL);

-- Ex 3

SELECT last_name,first_name
	FROM customer
WHERE EXISTS (SELECT COUNT(inventory_id)
				FROM rental
				GROUP BY customer_id
				HAVING COUNT(inventory_id) = 1);

-- Ex 4

SELECT last_name,first_name
	FROM customer
WHERE EXISTS (SELECT COUNT(inventory_id)
				FROM rental
				GROUP BY customer_id
				HAVING COUNT(inventory_id) > 1);
			
-- Ex 5

SELECT last_name, first_name
	FROM actor
WHERE actor_id IN (SELECT actor_id
				FROM film_actor INNER JOIN film USING(film_id)
				WHERE film.title = 'BETRAYED REAR' OR film.title = 'CATCH AMISTAD');

-- Ex 6

SELECT last_name, first_name
	FROM actor
WHERE actor_id IN (SELECT actor_id
				FROM film_actor INNER JOIN film USING(film_id)
				WHERE film.title = 'BETRAYED REAR')
AND actor_id NOT IN (SELECT actor_id
					FROM film_actor INNER JOIN film using(film_id)
					WHERE film.title = 'CATCH AMISTAD');

-- Ex 7

SELECT last_name, first_name
	FROM actor a1
WHERE a1.actor_id IN (SELECT fa.actor_id 
					FROM film_actor fa
					WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title = 'BETRAYED REAR'))
AND a1.actor_id IN (SELECT fa.actor_id
					FROM film_actor fa
					WHERE fa.film_id IN (SELECT f.film_id FROM film f where f.title = 'CATCH AMISTAD'));
	
-- Ex 8

SELECT last_name, first_name
	FROM actor a1
WHERE a1.actor_id IN (SELECT fa.actor_id 
					FROM film_actor fa
					WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title <> 'BETRAYED REAR'))
AND a1.actor_id IN (SELECT fa.actor_id
					FROM film_actor fa
					WHERE fa.film_id IN (SELECT f.film_id FROM film f where f.title <> 'CATCH AMISTAD'));



