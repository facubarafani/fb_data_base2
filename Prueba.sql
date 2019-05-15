SELECT film.title, language.name FROM film, `language` WHERE film.language_id = language.language_id AND film.`length` > 100 AND language.name = 'English'

SELECT first_name FROM customer
WHERE first_name LIKE '%_a'

-- PRACTICO

-- EJ1
SELECT title, AVG(length) as 'avg_length',a.first_name, a.last_name
FROM film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY f.film_id, a.first_name, a.last_name
HAVING AVG(`length`) < (SELECT AVG(`length`) FROM film)
ORDER BY avg_length;

-- EJ2

SELECT co.country, ct.city , a.address, a.district, a.postal_code
FROM address a
INNER JOIN city ct ON ct.city_id = a.city_id
INNER JOIN country co ON co.country_id = ct.country_id
WHERE co.country LIKE '%a'
AND ct.city LIKE 'E%'
ORDER BY co.country ASC ,ct.city ASC;

-- EJ3

SELECT c.name,f.title,l.name,f.rental_rate
FROM film f
INNER JOIN language l ON l.language_id = f.language_id
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Comedy' OR c.name = 'Animation' OR c.name = 'Children'
HAVING rental_rate < 3
ORDER BY c.name,f.title,rental_rate ASC;
				
				

