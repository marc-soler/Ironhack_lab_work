USE sakila;
# 1. Write a query to display for each store its store ID, city and country.
SELECT 
    s.store_id AS store_id,
    c.city AS city,
    co.country AS country
FROM
    store AS s
        JOIN
    address AS a USING (address_id)
        JOIN
    city AS c USING (city_id)
        JOIN
    country AS co USING (country_id);

# 2. Write a query to display how much benefit amount, in dollars, each store brought in.
SELECT 
    s.store_id AS store,
    ROUND(SUM(p.amount), 2) AS benefit_amount
FROM
    store AS s
        JOIN
    staff AS st ON s.manager_staff_id = st.staff_id
        JOIN
    payment AS p USING (staff_id)
GROUP BY store;

# 3. What is the average running time of films by category?
SELECT 
    c.name AS category,
    CONCAT(FLOOR(AVG(length / 60)),
            'h ',
            ROUND(MOD(AVG(length), 60)),
            'm') AS avg_duration
FROM
    film AS f
        JOIN
    film_category AS fc USING (film_id)
        JOIN
    category AS c USING (category_id)
GROUP BY category;

# 4. Which film categories are longest on average?
SELECT 
    c.name AS category,
    CONCAT(FLOOR(AVG(length / 60)),
            'h ',
            ROUND(MOD(AVG(length), 60)),
            'm') AS avg_duration
FROM
    film AS f
        JOIN
    film_category AS fc USING (film_id)
        JOIN
    category AS c USING (category_id)
GROUP BY category
ORDER BY avg_duration DESC;

# 5. Display the most frequently rented movies in descending order.
SELECT 
    f.title AS film, COUNT(r.inventory_id) AS times_rented
FROM
    film AS f
        JOIN
    inventory AS i USING (film_id)
        JOIN
    rental AS r USING (inventory_id)
GROUP BY film
ORDER BY times_rented DESC;
