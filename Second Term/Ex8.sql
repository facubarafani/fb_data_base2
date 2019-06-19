-- EX 1
-- Create a view named list_of_customers, it should contain the following columns:
-- customer id,customer full name,address, zipcode, phone,city,country,status (when active column is 1 show it as 'active', otherwise is 'inactive'),store id

CREATE OR REPLACE VIEW list_of_customers AS
SELECT CONCAT(c.last_name,', ',c.first_name) AS 'full_name',a.address,a.postal_code,a.phone,ct.city,co.country, 
	CASE c.active
		WHEN 1 THEN 'active'
		WHEN 0 THEN 'inactive'
		ELSE 'No info'
END AS 'status'
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ct ON ct.city_id = a.city_id
INNER JOIN country co ON co.country_id = ct.country_id;

SELECT * FROM list_of_customers;

-- EX 2
-- Create a view named film_details, it should contain the following columns:
-- film id, title,description,category,price,length,rating,actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

CREATE OR REPLACE VIEW film_details AS
SELECT f.film_id,f.title,f.description,cat.name,f.length,f.rating,GROUP_CONCAT(CONCAT(a.last_name,' ',a.first_name)) AS 'actors_full_name'
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category cat ON cat.category_id = fc.category_id
GROUP BY f.film_id,cat.name;

SELECT * FROM film_details;

-- EX 3
-- Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT cat.name, SUM(p.amount) AS 'total_rentals'
FROM category cat
INNER JOIN film_category fc ON cat.category_id = fc.category_id
INNER JOIN film f ON f.film_id = fc.film_id
INNER JOIN inventory i ON i.film_id = f.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment p ON p.rental_id = r.rental_id
GROUP BY cat.name
ORDER BY total_rentals DESC;

SELECT * FROM sales_by_film_category;

-- EX 4
-- Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.

CREATE OR REPLACE VIEW actor_information AS
SELECT a.actor_id,a.first_name,a.last_name,COUNT(fa.film_id) AS 'total_appearances'
FROM actor a
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY total_appearances DESC;

SELECT * FROM actor_information;


