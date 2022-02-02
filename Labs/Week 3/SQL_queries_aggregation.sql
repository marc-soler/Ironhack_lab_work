# 1. Using the rental table, find out how many rentals were processed by each employee.
SELECT 
    staff_id, COUNT(rental_id) AS rentals_processed
FROM
    rental
GROUP BY staff_id;

# 2. Using the film table, find out how many films were released.
SELECT 
    COUNT(film_id)
FROM
    film;

# 3. Using the film table, find out how many films there are of each rating. Sort the results in descending order of the number of films.
SELECT 
    rating, COUNT(film_id) AS films_count
FROM
    film
GROUP BY rating
ORDER BY films_count DESC;

# 4. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT 
    rating, ROUND(AVG(length), 2) AS avg_length
FROM
    film
GROUP BY rating
HAVING avg_length > 120;


