CREATE DATABASE superstores;
USE Superstores;

-- 1.Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen.
SELECT Customer_Name AS 'Customer Name', Customer_Segment AS 'Customer Segment' FROM Cust_dimen; -- Q1

-- 2. Write a query to find all the details of the customer from the table cust_dimen order by desc.
SELECT * FROM cust_dimen ORDER BY Customer_Name DESC;

-- 3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.
SELECT Order_ID,Order_Date FROM orders_dimen WHERE Order_Priority = 'High';

-- 4. Find the total and the average sales (display total_sales and avg_sales)
SELECT ROUND(sum(sales))AS "TOTAL_SALES" ,ROUND(avg(SALES)) AS AVG_SALES FROM market_fact;

-- 5. Write a query to get the maximum and minimum sales from maket_fact table.
SELECT MAX(SALES) AS MAX_SALES, MIN(SALES) AS MIN_SALES FROM market_fact;

-- 6. Display the number of customers in each region in decreasing order of 
-- no_of_customers. The result should contain columns Region, no_of_customers.
SELECT Region, COUNT(CUST_ID) AS NO_OF_CUST FROM cust_dimen GROUP BY REGION ORDER BY NO_OF_CUST DESC;

-- 7. Find the region having maximum customers (display the region name and
-- max(no_of_customers)
SELECT Region, COUNT(CUST_ID) AS NO_OF_CUST 
FROM cust_dimen GROUP BY REGION HAVING NO_OF_CUST >= ALL 
(SELECT COUNT(CUST_ID) AS NO_OF_CUST FROM cust_dimen GROUP BY region );

-- 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’
-- and the number of tables purchased (display the customer name, no_of_tables purchased)
	SELECT cust_dimen.customer_name, COUNT(*) AS no_of_tables_purchased
	FROM cust_dimen  
	INNER JOIN  market_fact 
    ON cust_dimen.cust_id = market_fact.cust_id 
	WHERE cust_dimen.region = 'atlantic'
	AND market_fact.prod_id = ( SELECT prod_id FROM prod_dimen WHERE product_sub_category = 'tables')
	GROUP BY market_fact.cust_id, cust_dimen.customer_name;
    
-- 9. Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)
SELECT Customer_Name, count(Customer_Name) AS NO_OF_SMALL_BUSINESS FROM cust_dimen
 WHERE Province = 'ONTARIO' AND Customer_Segment='SMALL BUSINESS'GROUP BY Customer_Name;

-- 10. Find the number and id of products sold in decreasing order of products sold(display product id, no_of_products sold)
    SELECT prod_id AS product_id, COUNT(*) AS no_of_products_sold
	FROM market_fact
	GROUP BY prod_id
	ORDER BY no_of_products_sold DESC;

-- 11. Display product Id and product sub category whose produt category belongs to
-- Furniture and Technlogy. The result should contain columns product id, product sub category.
SELECT prod_id AS product_id,Product_Sub_Category FROM prod_dimen
 WHERE Product_Category ='FURNITURE' OR Product_Category = 'TECHNOLOGY' ;

-- 12. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
SELECT prod_dimen.Product_Category,ROUND(SUM(market_fact.Profit)) AS PROFIT
FROM prod_dimen 
INNER JOIN market_fact 
ON prod_dimen.Prod_id = market_fact.Prod_id 
group by Product_Category
ORDER BY Profit DESC;

-- 13. Display the product category, product sub-category and the profit within each subcategory in three columns.
SELECT prod_dimen.Product_Category,prod_dimen.Product_Sub_Category,ROUND(SUM(market_fact.Profit)) AS PROFIT
FROM prod_dimen
INNER JOIN market_fact
ON prod_dimen.Prod_id = market_fact.Prod_id
GROUP BY Product_Category,Product_Sub_Category ORDER BY PROFIT DESC;

-- 14. Display the order date, order quantity and the sales for the order.
SELECT orders_dimen.Order_Date,market_fact.order_quantity,market_fact.sales
FROM orders_dimen
INNER JOIN market_fact
ON orders_dimen.Ord_id=market_fact.Ord_id;

-- 15. Display the names of the customers whose name contains the i) Second letter as ‘R’ ii) Fourth letter as ‘D’
SELECT Customer_Name FROM cust_dimen WHERE Customer_Name LIKE '_R_D%';

-- 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.
SELECT  cust_dimen.cust_id,cust_dimen.customer_name,cust_dimen.region,market_fact.sales 
FROM cust_dimen 
INNER JOIN market_fact 
WHERE cust_dimen.cust_id=market_fact.cust_id 
AND market_fact.sales BETWEEN 1000 AND 5000;

-- 17. Write a SQL query to find the 3rd highest sales.
SELECT sales 
FROM market_fact 
ORDER BY sales DESC 
LIMIT 2, 1;

-- 18. Where is the least profitable product subcategory shipped the most? For the least
-- profitable product sub-category, display the region-wise no_of_shipments and the
-- profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)
-- →Note: You can hardcode the name of the least profitable product subcategory

 SELECT  c.region, COUNT(distinct s.ship_id) AS no_of_shipments, SUM(m.profit) AS profit_in_each_region
	FROM market_fact m
	INNER JOIN cust_dimen c ON m.cust_id = c.cust_id
	INNER JOIN shipping_dimen s ON m.ship_id = s.ship_id
	INNER JOIN prod_dimen p ON m.prod_id = p.prod_id
	WHERE p.product_sub_category IN 
    (SELECT p.product_sub_category 
    FROM market_fact m 
    INNER JOIN prod_dimen p 
    ON m.prod_id = p.prod_id 
    GROUP BY p.product_sub_category 
    HAVING SUM(m.profit) <= ALL(SELECT SUM(m.profit) AS profits
		FROM market_fact m
		INNER JOIN prod_dimen p ON m.prod_id = p.prod_id
		GROUP BY p.product_sub_category))
	GROUP BY c.region
	ORDER BY profit_in_each_region DESC;
