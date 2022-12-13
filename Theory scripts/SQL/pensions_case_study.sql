# 1. The total number of investments per fund and corresponding total amounts;
SELECT 
    COUNT(DISTINCT id) AS investments_per_fund,
    ROUND(SUM(amount), 2) AS total_amount
FROM
    investments
GROUP BY fund_id;

# 2. How many investments have an amount greater than 1000 between 2018-01-01 and 2020-01-01 with a fund price greater than 1.01;
-- Join between investments and fund prices
SELECT 
    *
FROM
    investments i
        JOIN
    fund_prices p ON i.fund_id = p.fund_id;
-- Amount greater than 1000 and specified dates
SELECT 
    COUNT(DISTINCT i.id) as investments
FROM
    investments i
        JOIN
    fund_prices p ON i.fund_id = p.fund_id
WHERE
    i.amount > 1000
        AND i.completed_on BETWEEN '2018-01-01' AND '2020/01/01'
        AND p.Amount > 1.01;

# 3. The last investment ID of the year per fund name;
-- Joining investments and fund names
SELECT
	*
FROM investments i
	JOIN
fund_list l ON i.fund_id = l.fund_id;
-- Grouping by fund name & 
SELECT 
	l.fund_name AS fund_name,
    LAST_VALUE(i.id) OVER(PARTITION BY EXTRACT(YEAR FROM i.completed_on)) AS last_investment
FROM
    investments i
        JOIN
    fund_list l ON i.fund_id = l.fund_id
GROUP BY l.fund_name;

# Retrieve table with the following columns: fund id | fund price | fund price on | previous price collected;
-- All from fund_prices table, we need to use LAG() window function
SELECT
	fund_id,
    Amount AS fund_price,
    fund_price_on,
    LAG(Amount, 1) OVER(PARTITION BY fund_id ORDER BY fund_price_on) AS previous_price
FROM fund_prices
GROUP BY fund_id
ORDER BY fund_price_on;