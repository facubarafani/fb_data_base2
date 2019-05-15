-- EX 1

SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;

-- EX 2

SELECT f.title, i.inventory_id
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.inventory_id IS NULL;

-- EX 3

SELECT c.first_name, c.last_name, s.store_id, f.title
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN store s ON c.store_id = s.store_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
WHERE r.return_date IS NOT NULL
AND r.customer_id IS NOT NULL
ORDER BY s.store_id,c.last_name;

-- EX 4

SELECT s.store_id,CONCAT(co.country,', ',ct.city) AS store_info,CONCAT (st.last_name, ', ',st.first_name) as manager_info ,SUM(p.amount) as sales_per_store
FROM store s
INNER JOIN staff st ON st.staff_id = s.manager_staff_id
INNER JOIN address a ON a.address_id = s.address_id
INNER JOIN city ct ON ct.city_id = a.city_id
INNER JOIN country co ON ct.country_id = co.country_id
INNER JOIN customer c ON c.store_id= s.store_id
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN payment p ON p.rental_id = r.rental_id
GROUP BY s.store_id;

-- EX 5

SELECT a.actor_id,a.first_name, a.last_name, COUNT(*) as film_appearances
FROM actor a
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
GROUP BY a.actor_id
HAVING COUNT(a.actor_id) >= ALL(SELECT COUNT(a.actor_id)
								FROM actor a
								INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
								GROUP BY a.actor_id
								);
