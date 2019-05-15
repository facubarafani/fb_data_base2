SELECT f.title, f.special_features, f.rating
FROM film f
WHERE f.rating LIKE '%PG-13%';

SELECT DISTINCT f.title,s.first_name,s.last_name
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN store st ON i.store_id = st.store_id
INNER JOIN staff s ON st.store_id = s.store_id
WHERE i.store_id = 2;

SELECT DISTINCT f1.title, f2.title, f1.rating
FROM film f1, film f2
WHERE f1.rating =f2.rating;

SELECT c.first_name,c.last_name
FROM customer c
WHERE EXISTS (SELECT COUNT(customer_id)
				FROM rental r
				GROUP BY customer_id
				HAVING COUNT(customer_id) = 1
				);
SELECT a.first_name,a.last_name
FROM actor a,film f
WHERE actor_id IN (SELECT actor_id
					FROM film_actor fa
					WHERE fa.film_id = f.film_id
					AND f.title = 'BETRAYED REAR' OR 'CATCH AMISTAD');
					
SELECT a.first_name,a.last_name
FROM actor a,film f
WHERE actor_id IN (SELECT actor_id
					FROM film_actor fa
					WHERE fa.film_id = f.film_id
					AND f.title = 'BETRAYED REAR')
AND actor_id NOT IN (SELECT actor_id
					FROM film_actor fa
					WHERE fa.film_id = f.film_id
					AND f.title = 'CATCH AMISTAD');

SELECT co.country_id,co.country, COUNT(*) as 'qty_cities'
FROM city ct, country co
WHERE co.country_id = ct.country_id
GROUP BY co.country_id,co.country
HAVING qty_cities > 10
ORDER BY qty_cities DESC;

SELECT c.first_name, c.last_name, a.address FROM customer c, address a WHERE c.address_id = a.address_id;

SELECT c.customer_id,COUNT(*) FROM rental r, customer c WHERE c.customer_id = r.customer_id GROUP BY c.customer_id;			
				
SELECT c.customer_id,SUM(p.amount) FROM payment p, customer c WHERE c.customer_id = p.customer_id GROUP BY c.customer_id;

SELECT c.first_name, c.last_name,
(SELECT a.address FROM address a WHERE c.address_id = a.address_id) AS 'address',
(SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id) AS 'rental_qty',
(SELECT SUM(p.amount) FROM payment p WHERE c.customer_id = p.customer_id) AS 'total_spent'
FROM customer c
ORDER BY total_spent DESC;

SELECT c.name, AVG(length) AS 'avg_length'
	FROM film f
	INNER JOIN film_category fc ON f.film_id = fc.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id
HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film)
ORDER BY avg_length DESC;

SELECT f.rating,SUM(p.amount)
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating;

SELECT a.first_name, a.last_name
FROM actor a, film_actor fa
WHERE a.actor_id = fa.actor_id
AND fa.actor_id IS NULL;

SELECT a1.first_name,a1.last_name
FROM actor a1
WHERE EXISTS(SELECT *
				FROM actor a2
				WHERE a1.last_name = a2.last_name
				AND a1.actor_id <> a2.actor_id)
ORDER BY last_name;





