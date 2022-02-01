# 1. Select all the actors with the first name "Scarlett".
SELECT 
    *
FROM
    actor
WHERE
    first_name = 'Scarlett';

# 2. How many films (movies) are available for rent and how many films have been rented?
# available for rent and rented
SELECT 
    COUNT(DISTINCT inventory.inventory_id),
    COUNT(DISTINCT rental.rental_id)
FROM
    inventory,
    rental;

# 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration, MIN(length) AS min_duration
FROM
    film;

# 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT 
    CONCAT(FLOOR(AVG(length / 60)),
            'h, ',
            ROUND(MOD(AVG(length), 60)),
            'm') AS avg_duration
FROM
    film;

# 5. How many distinct (different) actors' last names are there?
SELECT 
    COUNT(DISTINCT last_name)
FROM
    actor;

# 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM
    rental;

# 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT 
    *,
    MONTH(rental_date) AS month,
    DAYOFWEEK(rental_date) AS weekday
FROM
    rental
LIMIT 20;

# 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT 
    *,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1 , 2, 3, 4, 5) THEN 'workday'
        WHEN DAYOFWEEK(rental_date) IN (6 , 7) THEN 'weekend'
    END AS day_type
FROM
    rental;

# 9. How many rentals were in the last month of activity?
SELECT 
    COUNT(rental_id)
FROM
    rental
WHERE
    rental_date >= '2006-02-14' - INTERVAL 1 MONTH;

