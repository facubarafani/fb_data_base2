-- SQL_ADMINISTRATION EXCERCICES

-- Create a user data_analyst
-- Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
-- Login with this user and try to create a table. Show the result of that operation.
-- Try to update a title of a film. Write the update script.
-- With root or any admin user revoke the UPDATE permission. Write the command
-- Login again with data_analyst and try again the update done in step 4. Show the result.

-- 1
USE mysql;
CREATE USER data_analyst@'%'
IDENTIFIED BY 'password';

-- 2

GRANT SELECT,UPDATE,DELETE ON sakila.* 
TO data_analyst@'%';

SHOW GRANTS FOR data_analyst@'%';

-- 3

CREATE TABLE test (
    test varchar(255)
);

-- RETURNED: SQL Error [1142] [42000]: CREATE command denied to user 'data_analyst'@'172.18.0.1' for table 'test'

-- 4

SELECT * FROM film;

UPDATE film
SET title = 'TEST'
WHERE title = 'ACADEMY DINOSAUR';

-- 5

REVOKE UPDATE ON sakila.* FROM data_analyst@'%';

-- RETURNED: SQL Error [1142] [42000]: UPDATE command denied to user 'data_analyst'@'172.18.0.1' for table 'film'