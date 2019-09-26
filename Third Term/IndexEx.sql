-- Ex 1

RESET QUERY CACHE;

SELECT SQL_NO_CACHE *
	FROM address a
	INNER JOIN city USING(city_id)
	INNER JOIN country USING(country_id)
	WHERE a.postal_code IN (35200, 17886);
	
CREATE INDEX postalCode ON address(postal_code);

DROP INDEX postalCode ON address;

-- Ex 2

SELECT *
	FROM actor
	WHERE first_name LIKE '%PENELOPE%';

SELECT *
	FROM actor
	WHERE last_name LIKE '%ALLEN%';
	
-- Ex 3

SELECT description
	FROM film
	WHERE description LIKE '%Epic%'
	AND description LIKE '%a%';
	
CREATE FULLTEXT INDEX filmDescription ON film(description);

DROP INDEX filmDescription ON film;

SELECT description
	FROM film
	WHERE MATCH(description) AGAINST('Epic,a');