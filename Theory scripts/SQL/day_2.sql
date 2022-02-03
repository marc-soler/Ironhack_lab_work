# Continuing to query a single table:
USE bank;
SELECT 
    *
FROM
    trans
ORDER BY amount ASC, date DESC;

# LIKE % REGEX
SELECT 
    *
FROM
    district
WHERE
    A3 LIKE '%Bohem%';

# Top 10 - order by + limit:
SELECT 
    *
FROM
    district
ORDER BY A4 DESC
LIMIT 10;

# 3.03 Activity 1 exercise 1:
SELECT 
    *
FROM
    trans
WHERE
    date >= '930101' AND date <= '930115';

# 3.03 Activity 1 exercise 2:
SELECT 
    *
FROM
    district
WHERE
    A2 LIKE 'm%';

# 3.03 Activity 1 exercise 3:
SELECT 
    *
FROM
    district
WHERE
    A2 LIKE '%M';

# GROUP BY:
SELECT 
    status_description,
    COUNT(DISTINCT loan_id) AS number_loans,
    COUNT(DISTINCT account_id) AS number_accounts
FROM
    loan_statuses
GROUP BY status_description;

SELECT 
    bank_to,
    account_id,
    CEILING(AVG(amount)) AS avg_amnt,
    CEILING(SUM(amount)) AS total_amnt,
    MAX(amount) AS biggest,
    COUNT(*) AS nooforders
FROM
    bank.order
GROUP BY bank_to , account_id
ORDER BY biggest DESC;

# 3.03 Activity 2 exercise 1:
USE sakila;
SELECT 
    SUM(amount) AS Total_revenue
FROM
    payment;

# 3.03 Activity 2 exercise 2:
SELECT 
    customer_id, SUM(amount) AS Total_revenue
FROM
    payment
GROUP BY customer_id
ORDER BY Total_revenue DESC;

# 3.03 Activity 3:
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SELECT 
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    customer_id,
    SUM(amount) AS Total_revenue
FROM
    payment
GROUP BY payment_year , payment_month , customer_id
ORDER BY payment_year ASC , payment_month ASC;

# HAVING & window functions:
SELECT 
    customer_id, 
    SUM(amount) AS revenue, 
    dense_rank() over(order by SUM(amount) DESC) AS ranked_sales
FROM
    payment
WHERE
    customer_id <> '144'
GROUP BY customer_id
HAVING revenue > 100
#ORDER BY revenue DESC
limit 100;

# More window funtions:
USE bank;
SELECT 
	loan_id, 
    duration, 
    amount,
    status,
	AVG(amount) over(partition by duration) as avg_amnt,
    amount - AVG(amount) over(partition by duration) as diff,
    row_number() OVER(partition by status, duration order by status DESC) as row_no
FROM loan
ORDER by row_no, diff DESC;

SELECT 
    account_id, CONVERT( t.date , DATE) AS date_trans, amount,
    ceiling(SUM(amount) OVER(partition by account_id order by date)) as cumbalance
FROM
    bank.trans AS t
WHERE
    account_id < 10;

# 3.03 Activity 4 exercise 1:
USE sakila;
SELECT 
    rating, AVG(length) AS avg_length
FROM
    film
GROUP BY rating
ORDER BY avg_length DESC;

# 3.03 Activity 4 exercise 2:
SELECT 
    rating, title, length, 
    ROUND(AVG(length) over(partition by rating)) as 'mean_rating_length', 
    dense_rank() OVER(partition by rating order by length DESC) as 'ranking'
FROM
    film;

# REGEX for fuzzy matching REGEXP_LIKE | REGEXP
SELECT DISTINCT
    title
FROM
    film
WHERE
	title REGEXP '[XZ]';
# title REGEXP ('hea|per'); # OR clause
# where REGEXP '[xz]' contains all letters in the range between these letters
# where REGEXP '[^xz]' excludes all letters in the range between these letters
# where REGEXP_LIKE(title, '^P') starting with, same as REGEXP '^P'
# where REGEXP_LIKE(title, 'er$') ending with, same as REGEXP 'er$'
# where REGEXP_LIKE(title, 'phob') contains, same as REGEXP 'phob'
