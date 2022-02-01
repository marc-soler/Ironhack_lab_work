SELECT 'Hello World';

SELECT 2 * 3;

SELECT DISTINCT
    type
FROM
    card;
    
SELECT DISTINCT
    A2 as district_name, A3 as region_name
FROM
    district as d
LIMIT 30;
    
SELECT 
    t.trans_id AS Transaction_id,
    t.account_id AS Account_id,
    t.date AS Dateoftrans,
    t.type AS Trans_Type
FROM
    trans as t;
    
SELECT 
    bc.type AS type_of_card, bc.issued AS issue_date
FROM
    card AS bc;

# Creating fields using queries: SELECT operator FROM x
SELECT 
    *, ROUND((amount - payments) / 1000, 2) AS balance_k
FROM
    loan
WHERE
    status != 'B'; # or <> 'B' or NOT IN ('B', 'D')

SELECT 
    *, ROUND((amount - payments) / 1000, 2) AS balance_k
FROM
    loan
WHERE
    status IN ('B' , 'D') # or <> 'B' or NOT IN ('B', 'D')
        AND payments > 8000
; 
# 3.02 Activity 1 exercise 1
SELECT 
    A2 AS district_name, A11 AS average_salary
FROM
    district
WHERE
    A11 > 10000;
# 3.02 Activity 1 exercise 2
SELECT 
    *
FROM
    loan
WHERE
    status ='B';
# 3.02 Activity 1 exercise 3
SELECT 
    *
FROM
    card
WHERE
    type = 'junior'
LIMIT 30;
# 3.02 Activity 1 exercise 4
SELECT 
    loan_id, account_id, amount - payments as debt
FROM
    loan
WHERE
    status = 'B';
# 3.02 Activity 1 exercise 5
SELECT
	A2 as district_name,
    ROUND(A4 * A10 / 100) as urban_population
FROM district;
# 3.02 Activity 1 exercise 6
SELECT 
    A2 AS district_name,
    ROUND((A4 * A10) / 100) AS urban_population
FROM
    district
WHERE
    A10 > 50;
# Big or bad loans
SELECT 
    *
FROM
    loan
WHERE
    status IN ('B' , 'D') OR amount > 250000;
# not and not
SELECT 
    *
FROM
    bank.order
WHERE
    NOT k_symbol = 'SIPO'
        AND NOT amount < 1000;
# max min floor ceiling round log sqrt
SELECT 
    MAX(amount), MIN(amount), ROUND(AVG(amount), 2)
FROM
    bank.order;
# string functions concat split strip upper lower rtrim ltrim
SELECT length('sian');
#order id + acc id concat
SELECT 
    *, CONCAT(order_id, account_id) AS reference
FROM
    bank.order;
# Longest str in a column
SELECT 
    MAX(LENGTH(A2))
FROM
    district;
SELECT 
    CONCAT(LEFT(A2, 4), RIGHT(A2, 4)) AS first_last
FROM
    district
WHERE
    LENGTH(A2) = 19;
# 3.02 Activity 2 exercise 1
SELECT 
    *
FROM
    card
WHERE
    type = 'junior' AND issued > 980000;
# 3.02 Activity 2 exercise 2
SELECT 
    *
FROM
    trans
WHERE
    type = 'VYDAJ' AND operation = 'VYBER'
LIMIT 10;
# 3.02 Activity 2 exercise 3
SELECT 
    amount - payments AS debt, loan_id, account_id
FROM
    loan
WHERE
    status = 'B' AND (amount - payments) > 1000;
# 3.02 Activity 2 exercise 4
SELECT 
    MIN(amount), MAX(amount)
FROM
    trans
WHERE
    NOT amount = 0;
# 3.02 Activity 2 exercise 5
SELECT 
    account_id,
    district_id,
    frequency,
    CONCAT(19, LEFT(date, 2)) AS Year
FROM
    bank.account;
# 3.02 Activity 2 exercise 5 with CASE
SELECT 
    account_id,
    district_id,
    frequency,
    CASE
        WHEN LEFT(date, 2) < 20 THEN CONCAT(20, LEFT(date, 2))
        ELSE CONCAT(19, LEFT(date, 2))
    END AS Year
FROM
    bank.account;
# CASE statements + NULL clause + creating a view
CREATE VIEW loan_statuses AS
    SELECT 
        loan_id,
        account_id,
        CASE
            WHEN status = 'A' THEN 'good - finished'
            WHEN status = 'B' THEN 'bad - unpaid'
            WHEN status = 'C' THEN 'good - running'
            ELSE 'default - running'
        END AS status_description
    FROM
        loan
    WHERE
        amount IS NOT NULL;
# CONVERT ... DATE_FORMAT() SUBSTRING_INDEX() to select a str inside a str
SELECT 
    *,
    DATE_FORMAT(CONVERT( a.date , DATE), '%d/%m/%Y') AS full_date
FROM
    account AS a;
# 3.02 Activity 3 exercise 1
SELECT 
    card_id,
    DATE_FORMAT(CONVERT( SUBSTRING_INDEX(issued, ' ', 1) , DATE),
            '%d/%m/%Y') AS First_year
FROM
    card
WHERE
    type = 'gold';
# 3.02 Activity 3 exercise 2
SELECT 
    MIN(DATE_FORMAT(CONVERT( SUBSTRING_INDEX(issued, ' ', 1) , DATE),
            '%Y'))
FROM
    card
WHERE
    type = 'gold';
# 3.02 Activity 3 exercise 3
SELECT 
    DATE_FORMAT(CONVERT( SUBSTRING_INDEX(issued, ' ', 1) , DATE),
            '%M %D,%Y') AS date_issued,
    DATE_FORMAT(CONVERT( SUBSTRING_INDEX(issued, ' ', 1) , DATE),
            '%d of %M of %Y') AS fecha_emision
FROM
    card;

