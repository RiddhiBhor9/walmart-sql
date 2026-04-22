create table sales(
    invoice_id VARCHAR(20),
    branch VARCHAR(10),
    city VARCHAR(50),
    category VARCHAR(50),
    unit_price VARCHAR(10),
    quantity VARCHAR(10),
    date VARCHAR(15),
    time VARCHAR(15),
    payment_method VARCHAR(20),
    rating VARCHAR(10),
    profit_margin VARCHAR(10)
);


-- Walmart Project Queries

SELECT * FROM sales;

-- DROP TABLE walmart;

-- DROP TABLE walmart;

-- 
SELECT COUNT(*) FROM sales;

SELECT 
	 payment_method,
	 COUNT(*)
FROM sales
GROUP BY payment_method

SELECT 
	COUNT(DISTINCT branch) 
FROM sales;

SELECT MIN(quantity) FROM sales;

-- Business Problems
--Q.1 Find different payment method and number of transactions, number of qty sold

SELECT
	payment_method,
	count(*) as no_payments,
	sum(quantity) as no_qty_sold
FROM sales
Group by payment_method
	
ALTER TABLE sales
ALTER COLUMN quantity TYPE INT
USING quantity::INT;


-- Project Question #2
-- Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING


select*
from
(	SELECT 
		branch,
		category,
		AVG(rating) as avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
	FROM sales
	GROUP BY 1, 2
)
WHERE rank = 1


-- Q.3 Identify the busiest day for each branch based on the number of transactions

select *
from
(select branch,
to_char(to_date(date,'da/mm/yy'),'day')as day_name,
count(*)as no_transactions,
rank()over(partition by branch order by COUNT(*)desc )as rank
from sales
group by 1,2
)
where rank =1


-- Q. 4 
-- Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.



SELECT 
	 payment_method,
	 -- COUNT(*) as no_payments,
	 SUM(quantity) as no_qty_sold
FROM sales
GROUP BY payment_method


-- Q.5
-- Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.

SELECT 
	city,
	category,
	MIN(rating) as min_rating,
	MAX(rating) as max_rating,
	AVG(rating) as avg_rating
FROM sales
GROUP BY 1, 2




-- Q.6
-- Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

WITH cte 
AS
(SELECT 
	branch,
	payment_method,
	COUNT(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM sales
GROUP BY 1, 2
)
SELECT *
FROM cte
WHERE rank = 1

--q7
select branch,
payment_method,
count(*)as total_trans
from sales
group by 1,2


-- Q.8
-- Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices

SELECT
branch,
	CASE 
		WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- 
-- #9 Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)

-- rdr == last_rev-cr_rev/ls_rev*100
SELECT * FROM sales LIMIT 5;
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'sales';
WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM sales
    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM sales
    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
    GROUP BY branch
)

SELECT 
    ls.branch,
    ls.revenue AS last_year_revenue,
    cs.revenue AS cr_year_revenue,
    ROUND(
        (ls.revenue - cs.revenue)::numeric / ls.revenue * 100, 
        2
    ) AS rev_dec_ratio
FROM revenue_2022 ls
JOIN revenue_2023 cs
    ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY rev_dec_ratio DESC
LIMIT 5;
SELECT * FROM sales LIMIT 1;