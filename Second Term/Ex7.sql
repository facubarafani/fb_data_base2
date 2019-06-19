-- EX1
-- Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.

SELECT CONCAT(c.last_name,', ',c.first_name) as 'full_name',a.address,ct.city
FROM customer c
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city ct ON ct.city_id = a.city_id
INNER JOIN country co ON co.country_id = ct.country_id
WHERE LOWER(co.country) = 'argentina';

-- EX 2
-- Write a query that shows the film title, language and rating. 

SELECT f.title, l.name, 
	CASE f.rating 
		WHEN 'G' THEN 'General Audiences'
		WHEN 'PG' THEN 'Parental Guidance Suggested'
		WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
		WHEN 'R' THEN 'Restricted'
		WHEN 'NC-17' THEN 'Adults Only'
		ELSE 'Does not exist'
END AS 'rating'
FROM film f
INNER JOIN `language` l ON f.language_id = l.language_id;

-- EX 3
-- Write a search query that shows all the films (title and release year) an actor was part of. Assume the actor comes from a text box introduced by hand from a web page. Make sure to "adjust" the input text to try to find the films as effectively as you think is possible. 

SELECT f.title, f.release_year, LOWER(CONCAT(a.last_name,' ',a.first_name)) AS 'actor'
FROM actor a
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
ORDER BY a.actor_id;

-- EX 4
-- Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. There should be returned column with two possible values 'Yes' and 'No'.

SELECT f.title, CONCAT(c.last_name,', ',c.first_name),
	CASE
		WHEN r.return_date IS NOT NULL THEN 'Yes'
		ELSE 'No'
END AS 'returned'
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN customer c ON r.customer_id = c.customer_id
WHERE LOWER(MONTHNAME(r.rental_date)) = 'may' OR LOWER(MONTHNAME(r.rental_date)) = 'june';



