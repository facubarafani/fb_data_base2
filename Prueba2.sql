-- Genere un reporte mostrando el nombre y apellido de cada cliente con la cantidad
de películas que alquiló y la cantidad de dinero que ha gastado.
Mostrar solo los clientes que hayan gastado entre 100 y 150 dolares.

SELECT c.first_name,c.last_name, COUNT(*) AS "num_rentals",SUM(p.amount) AS "total_spent"
FROM rental r
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN payment p ON p.rental_id = r.rental_id
GROUP BY c.customer_id
HAVING total_spent BETWEEN 100 AND 150
ORDER BY total_spent DESC;


-- Muestre un reporte de la cantidad de películas rentadas por país y por categoría de películas
Columnas a mostrar nombre del país, nombre la categoría y cantidad de películas alquiladas

SELECT co.country,COUNT(*) AS "total_rented",cat.name AS "category"
FROM category cat
INNER JOIN film_category fa ON fa.category_id = cat.category_id
INNER JOIN film f ON f.film_id = fa.film_id
INNER JOIN inventory i ON i.film_id = f.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city ct ON ct.city_id = a.city_id
INNER JOIN country co ON co.country_id = ct.country_id
GROUP BY co.country,cat.name;

-- Muestre la cantidad de películas que tienen los clientes alquiladas (es decir que todavía no se han devuelto) 
agrupadas por rating (G, PG, etc...)

SELECT f.rating,COUNT(c.customer_id) AS "total_rented"
FROM film f
INNER JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN customer c ON c.customer_id = r.customer_id
WHERE r.return_date IS NULL
GROUP BY f.rating
ORDER BY total_rented DESC;

-- Muestre los clientes y actores que compartan el apellido

Se deben mostrar todos los clientes, y cuando los actores compartan el apellido, mostrar esos actores. 
También mostrar la cantidad de películas en las que un actor determinado actuó.

SELECT DISTINCT c.last_name,c.first_name,a.last_name,a.first_name
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE c.last_name IN (SELECT DISTINCT a.last_name
								FROM actor a
								INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
								INNER JOIN film f ON f.film_id = fa.film_id
								INNER JOIN inventory i ON i.film_id = f.film_id
								INNER JOIN rental r ON r.inventory_id = i.inventory_id
								INNER JOIN customer c ON c.customer_id = r.customer_id
								WHERE a.last_name = c.last_name)
GROUP BY c.last_name;

SELECT c.last_name,c.first_name,a.last_name,a.first_name
FROM actor a
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
INNER JOIN inventory i ON i.film_id = f.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN customer c ON c.customer_id = r.customer_id
WHERE a.last_name = c.last_name
ORDER BY c.last_name;

SELECT c.last_name,c.first_name,a.last_name,a.first_name,COUNT(fa.film_id) AS "film_appearances"
FROM customer c
RIGHT JOIN actor a ON a.last_name = c.last_name
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
GROUP BY c.last_name,c.first_name,a.last_name,a.first_name;
