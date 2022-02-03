# Simple 2 table join: 
# How many clients per district?
USE bank;
SELECT 
    d.A2 AS district_name,
    COUNT(c.client_id) AS num_clients,
    d.A4 AS population,
    ROUND(COUNT(c.client_id) / d.A4 * 100, 2) AS clients_population_ratio
FROM
    district AS d
        JOIN
    client AS c ON d.A1 = c.district_id
GROUP BY d.A2 , d.A4
ORDER BY clients_population_ratio DESC;

# Joining account and loan
SELECT 
    account_id, loan_id, amount, duration, frequency
FROM
    loan
        JOIN
    account USING (account_id); # using() is the shorthand version if keys match

# How many loans per district? Loan to account to district
SELECT 
    d.A2 AS district_name,
    COUNT(DISTINCT l.loan_id) AS num_loans,
    COUNT(a.account_id) AS num_accounts,
    SUM(l.amount) AS total_loan_amount
FROM
    loan AS l
        JOIN
    account AS a USING (account_id)
        JOIN
    district AS d ON d.A1 = a.district_id
GROUP BY d.A2
ORDER BY total_loan_amount DESC;

# Return all accounts that don't have loans:
SELECT 
    *
FROM
    loan
        RIGHT JOIN
    account USING (account_id)
WHERE
    loan_id IS NULL;

# 3.04 Activity 3 exercise 1:
SELECT 
    d.A2 AS District_name,
    COUNT(c.client_id) AS Number_of_customers
FROM
    client AS c
        JOIN
    district AS d ON d.A1 = c.district_id
GROUP BY d.A2
ORDER BY Number_of_customers DESC;

# 3.04 Activity 3 exercise 2:
SELECT 
    d.A3 AS Region_name,
    COUNT(c.client_id) AS Number_of_customers
FROM
    client AS c
        JOIN
    district AS d ON d.A1 = c.district_id
GROUP BY d.A3
ORDER BY Number_of_customers DESC;

# 3.04 Activity 3 exercise 3:
SELECT 
    d.A2 AS District_name,
    YEAR(a.date) AS Year,
    COUNT(a.account_id) AS Accounts_opened
FROM
    account AS a
        JOIN
    district AS d ON a.district_id = d.A1
GROUP BY District_name , year
ORDER BY District_name , year;

# Working with a bridge table - applying filter on OWNER:
# Number of people who own loans per loan status:
SELECT 
    l.status AS loan_status, COUNT(c.client_id) AS num_clients
FROM
    client AS c
        JOIN
    disp AS d USING (client_id)
        JOIN
    account AS a USING (account_id)
        JOIN
    loan AS l USING (account_id)
WHERE
    d.type = 'OWNER'
GROUP BY loan_status;

