SELECT a.last_name,a.first_name
FROM actor a
WHERE EXISTS(SELECT a2.last_name
				FROM actor a2
				WHERE a2.last_name = a.last_name
				AND a2.actor_id <> a.actor_id
 				)
ORDER BY a.last_name;

SELECT a.last_name,a.first_name
FROM actor a
WHERE EXISTS (SELECT fa.actor_id
				FROM film_actor fa
				WHERE fa.film_id IS NULL
				);

SELECT c.last_name, c.first_name,COUNT(r.customer_id)
FROM rental r
INNER JOIN customer c ON c.customer_id = r.customer_id
WHERE EXISTS (SELECT r.customer_id,COUNT(*)
				FROM rental r
				GROUP BY r.customer_id
				HAVING COUNT(*) = 1
				)
GROUP BY c.customer_id;

SELECT c.last_name, c.first_name,COUNT(*) AS "num_rentals"
FROM rental r
INNER JOIN customer c ON c.customer_id = r.customer_id
WHERE EXISTS (SELECT r.customer_id,COUNT(*)
				FROM rental r
				GROUP BY r.customer_id
				HAVING COUNT(*) > 1
				)
GROUP BY c.customer_id;

SELECT DISTINCT a.actor_id,a.last_name,a.first_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id IN (SELECT fa.actor_id
						FROM film_actor fa
						INNER JOIN film f ON fa.film_id = f.film_id
						WHERE f.title = "BETRAYED REAR" OR f.title = "CATCH AMISTAD"
						);

SELECT DISTINCT a.actor_id,a.last_name,a.first_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id IN (SELECT fa.actor_id
						FROM film_actor fa
						INNER JOIN film f ON fa.film_id = f.film_id
						WHERE f.title = "BETRAYED REAR" AND f.title = "CATCH AMISTAD"
						);
					
SELECT DISTINCT a.actor_id,a.last_name,a.first_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id IN (SELECT fa.actor_id
						FROM film_actor fa
						INNER JOIN film f ON fa.film_id = f.film_id
						WHERE f.title = "BETRAYED REAR"
						)
AND a.actor_id NOT IN (SELECT fa.actor_id
						FROM film_actor fa
						INNER JOIN film f ON fa.film_id = f.film_id
						WHERE f.title = "CATCH AMISTAD"
						);

SELECT DISTINCT a.actor_id,a.last_name,a.first_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id NOT IN (SELECT fa.actor_id
						FROM film_actor fa
						INNER JOIN film f ON fa.film_id = f.film_id
						WHERE f.title = "BETRAYED REAR" AND f.title ="CATCH AMISTAD"
						);

SELECT a.actor_id,a.last_name,a.first_name, COUNT(*) as 'times'
FROM film_actor fa
INNER JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) >= ALL ( SELECT COUNT(fa.film_id)
						FROM film_actor fa
						GROUP BY fa.actor_id);


