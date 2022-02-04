# CREATE OR REPLACE VIEW bad_clients AS
    SELECT 
        l.status AS status,
        DATE_FORMAT(CONVERT( a.date , DATE), '%M, %Y') AS M_Y,
        COUNT(DISTINCT a.account_id) AS num_accounts,
        COUNT(DISTINCT d.client_id) AS num_clients,
        ROUND(SUM(t.amount)) AS moved_amount,
        COUNT(DISTINCT t.trans_id) AS num_trans
    FROM
        trans AS t
            JOIN
        account AS a USING (account_id)
            JOIN
        disp AS d USING (account_id)
            JOIN
        loan AS l USING (account_id)
    WHERE
        d.type = 'OWNER'
    GROUP BY l.status , M_Y;

select * from bad_clients;

SELECT 
        l.status AS status,
        DATE_FORMAT(CONVERT( t.date , DATE), '%M, %Y') AS M_Y,
        COUNT(DISTINCT a.account_id) AS num_accounts,
        COUNT(DISTINCT d.client_id) AS num_clients,
        ROUND(SUM(t.amount)) AS moved_amount,
        COUNT(DISTINCT t.trans_id) AS num_trans
    FROM
        trans AS t
            JOIN
        account AS a USING (account_id)
            JOIN
        disp AS d USING (account_id)
            JOIN
        loan AS l USING (account_id)
    WHERE
        d.type = 'OWNER'
    GROUP BY l.status , M_Y;

# View - for each trans and account, year and month - user activity
CREATE OR REPLACE VIEW user_activity AS
    SELECT 
        account_id,
        DATE_FORMAT(CONVERT( date , DATE), '%m') AS activity_month,
        DATE_FORMAT(CONVERT( date , DATE), '%y') AS activity_year
    FROM
        trans;
        
# View - Then,for each month, unique account holders who did something - monthly_active_users
CREATE OR REPLACE VIEW monthly_active_users AS
    SELECT 
        activity_month,
        activity_year,
        COUNT(DISTINCT account_id) AS active_users
    FROM
        user_activity
    GROUP BY activity_month , activity_year
    ORDER BY activity_year , activity_month;

# View - Use lag() to add to the View - monthly active users with prev
CREATE OR REPLACE VIEW monthly_active_users_lag AS 
	SELECT *, 
    LAG(active_users, 1) OVER() AS prev_month 
    FROM 
		monthly_active_users;

# Modify to include % change MoM
CREATE OR REPLACE VIEW monthly_active_users_lag AS 
	SELECT *, 
    LAG(active_users, 1) OVER() AS prev_month,
    CEILING(active_users - LAG(active_users, 1) OVER()) as client_change,
    ROUND((active_users - LAG(active_users, 1) OVER()) / LAG(active_users, 1) OVER() * 100, 2) as percentage_change
    FROM 
		monthly_active_users;
