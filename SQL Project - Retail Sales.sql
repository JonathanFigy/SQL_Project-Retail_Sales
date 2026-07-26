SELECT *
FROM sales_details;

-- Checking for Duplicates
-- Assigning Row Numbers for each column
SELECT transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit,
cogs, total_sale, ROW_NUMBER() OVER (PARTITION BY transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit,
	cogs, total_sale ORDER BY transactions_id) AS row_num
	FROM sales_details;

-- Subquery to identify duplicates
SELECT *
FROM (
	SELECT transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit,
	cogs, total_sale,ROW_NUMBER() OVER (PARTITION BY transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit,
	cogs, total_sale ORDER BY transactions_id) AS row_num
	FROM sales_details	
) duplicates
WHERE row_num > 1;

-- Identifying Null Values 
SELECT * FROM sales_details
WHERE transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Deleting Null Values
DELETE FROM sales_details
WHERE transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- How many sales are there in the dataset?
Select COUNT(*) AS total_sales
FROM sales_details;

-- How many unique customers are there?
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_details;

-- What are the different categories?
SELECT DISTINCT category AS category
FROM sales_details;


-- Data Analysis 

-- Q.1 Retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM sales_details
WHERE sale_date = '2022-11-05';

-- Q.2 Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM sales_details
WHERE category = 'Clothing' AND FORMAT(sale_date, 'yyyy-MM') = '2022-11' AND quantity > 3;

-- Q.3 Calculate the total sales and orders for each category.
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders   
FROM sales_details
GROUP BY category
ORDER BY total_sales DESC;

-- Q.4 Find the average age of customers who purchased items from the 'Beauty' category.
SELECT category, ROUND(AVG(age),2) AS avg_age
FROM sales_details
GROUP BY category
HAVING category = 'Beauty';

-- Q.5 Find all transactions where the total_sale is greater than 1000.
SELECT *
FROM sales_details
WHERE total_sale > 1000;

-- Q.6 Find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(*) AS total_transactions
FROM sales_details
GROUP BY category, gender
ORDER BY category;

-- Q.7 Calculate the average sale for each month. Find out the best selling month in each year
SELECT year,
       month,
       avg_sale
FROM 
(    
SELECT 
    YEAR(sale_date) as year,
    MONTH(sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY  YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as rn
FROM sales_details
GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t
WHERE rn = 1;

-- Q.8 Find the top 5 customers based on the highest total sales
SELECT TOP 5 customer_id, SUM(total_sale) as total_sales
FROM sales_details
GROUP BY customer_id
ORDER BY total_sales DESC;

-- Q.9 Find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM sales_details
GROUP BY category;

-- Q.10 Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH cte AS
(
SELECT *,
CASE WHEN DATEPART(HOUR,sale_time) < 12 THEN 'Morning'
     WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
     ELSE 'Evening'
END AS shift
FROM sales_details)

SELECT shift, COUNT(*) AS total_orders
FROM cte
GROUP BY shift
ORDER BY total_orders DESC;

Select *
From sales_details

-- Q11. Complete YoY sales analysis

WITH yearly_sales AS
(
Select YEAR(sale_date) AS year, SUM(total_sale) as total_sales
FROM sales_details
GROUP BY YEAR(sale_date)
)
Select *, LAG(total_sales) OVER(ORDER BY year) as prv_year_sales, 
CONCAT(COALESCE(CAST((total_sales -  LAG(total_sales) OVER(ORDER BY year))*100.0/LAG(total_sales) OVER(ORDER BY year) 
AS DECIMAL(10,2)), 0), '%')
AS yoy
FROM yearly_sales

-- Q12. Complete MoM sales analysis
WITH monthly_sales AS
(
SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, SUM(total_sale) as total_sales
FROM sales_details
GROUP BY YEAR(sale_date),  MONTH(sale_date)
)

SELECT *, LAG(total_sales) OVER(ORDER BY year, month) as prv_month_sales,
CONCAT(COALESCE(CAST((total_sales -  LAG(total_sales) OVER(ORDER BY year, month))*100.0/LAG(total_sales) OVER(ORDER BY year) 
AS DECIMAL(10,2)), 0), '%')
AS mom
FROM monthly_sales

-- Q13. Complete QoQ sales analysis
WITH quarterly_sales as
(
SELECT YEAR(sale_date) AS year, DATEPART(QUARTER, sale_date) AS quarter, SUM(total_sale) as total_sales
FROM sales_details
GROUP BY YEAR(sale_date), DATEPART(QUARTER, sale_date)
)
SELECT *, LAG(total_sales) OVER(PARTITION BY year ORDER BY year, quarter) as prv_quarter_sales,
CONCAT(COALESCE(CAST((total_sales -  LAG(total_sales) OVER(PARTITION BY year ORDER BY year, quarter))*100.0/LAG(total_sales) OVER(ORDER BY year) 
AS DECIMAL(10,2)), 0),'%')
AS qoq
FROM quarterly_sales