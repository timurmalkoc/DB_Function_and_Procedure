-- Q1 Create a Stored Procedure that will insert a new film into the film table with the following arguments: 
-- title, description, release_year, language_id, rental_duration, rental_rate, length, replace_cost, rating

SELECT title, description, release_year, language_id, rental_duration,
rental_rate, length, replacement_cost, rating FROM film

CREATE OR REPLACE PROCEDURE add_new_film(
	title varchar(255),
	description TEXT,
	release_year YEAR,
	language_id integer,
	rental_duration integer,
	rental_rate NUMERIC(4,2),
	length integer,
	replacement_cost NUMERIC(5,2),
	rating mpaa_rating)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, 
				rental_rate, length, replacement_cost, rating)
				VALUES(title,description,release_year,language_id,rental_duration,
				rental_rate, length, replacement_cost, rating);
END;
$$;


CALL add_new_film('Hobbit', 'The Hobbit is a series consisting of three high fantasy adventure films directed by Peter Jackson.',
                  '2012', 1, 4, 9.99, 474, 19.99, 'PG-13');


SELECT * FROM film
WHERE title = 'Hobbit';

-- Q2 Create a Stored Function that will take in a category_id and return the number of films in that category
CREATE OR REPLACE FUNCTION get_number_of_films(category integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
	DECLARE total integer;
BEGIN 
	SELECT count(film_id) INTO total  FROM film_category
		GROUP BY category_id 
		HAVING category_id = category;
	
	RETURN total;
END;
$$;

SELECT get_number_of_films(4);