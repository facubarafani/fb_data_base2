-- Ex 1

SELECT co.country_id, co.country, COUNT(*)
  FROM city ct, country co
 WHERE co.country_id = ct.country_id
GROUP BY co.country_id, co.country;

-- Ex 2

SELECT co.country_id, co.country, COUNT(*)
  FROM city ct, country co
 WHERE co.country_id = ct.country_id
GROUP BY co.country_id, co.country
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

-- Ex 3

SELECT c.first_name, c.last_name,
(SELECT a.address FROM address a WHERE a.address_id = c.address_id) AS 'address',
(SELECT COUNT(*) FROM rental r WHERE r.customer_id = c.customer_id) AS 'rental_qty',
(SELECT SUM(p.amount) from payment p WHERE p.customer_id = c.customer_id) AS 'total_spent'
FROM customer c
ORDER BY total_spent DESC;
	
	
-- Ex 4

SELECT c.name,AVG(length) as 'avg_length'
	FROM film f
	INNER JOIN film_category fc ON fc.film_id = f.film_id
	INNER JOIN category c ON c.category_id = fc.category_id
GROUP BY c.category_id
HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film)
ORDER BY avg_length DESC;

-- Ex 5

SELECT f.rating, SUM(amount)
	FROM film f
	INNER JOIN inventory i ON i.film_id = f.film_id
	INNER JOIN rental r ON r.inventory_id = i.inventory_id
	INNER JOIN payment p ON p.rental_id = r.inventory_id
GROUP BY f.rating;

							