# 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT 
    COUNT(*) as copies
FROM
    inventory
WHERE
    film_id = (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'HUNCHBACK IMPOSSIBLE');

# 2. List all films whose length is longer than the average of all the films.
SELECT 
    title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length) AS avg_length
        FROM
            film);

# 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'ALONE TRIP'));

# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT 
    *
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id = (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));

# 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT 
    first_name, last_name, email
FROM
    customer
WHERE
    address_id IN (SELECT 
            address_id
        FROM
            address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    city
                WHERE
                    country_id IN (SELECT 
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'Canada')));

# 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
# Code below works assuming all actor_id's are unique and data is well inputed.
SELECT 
    *
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_actor
        WHERE
            actor_id = (SELECT 
                    actor_id
                FROM
                    film_actor
                GROUP BY actor_id
                ORDER BY COUNT(DISTINCT film_id) DESC
                LIMIT 1));

# 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            inventory
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    rental
                WHERE
                    customer_id = (SELECT 
                            customer_id
                        FROM
                            payment
                        GROUP BY customer_id
                        ORDER BY SUM(amount) DESC
                        LIMIT 1)));

# OR
SELECT 
    title
FROM
    film AS f
        JOIN
    inventory AS i USING (film_id)
        JOIN
    rental AS r USING (inventory_id)
WHERE
    r.customer_id = (SELECT 
            customer_id
        FROM
            payment
        GROUP BY customer_id
        ORDER BY SUM(amount) DESC
        LIMIT 1);

# 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT 
    customer_id AS client_id, SUM(amount) AS total_amount_spent
FROM
    payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT 
        AVG(sub1.amount_per_client)
    FROM
        (SELECT 
            customer_id, SUM(amount) AS amount_per_client
        FROM
            payment
        GROUP BY customer_id) AS sub1)
ORDER BY total_amount_spent DESC;
