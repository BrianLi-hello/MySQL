USE my_guitar_shop;

/*
Exercises

1. Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. Instead, use a subquery in a WHERE clause that uses the IN keyword.
SELECT DISTINCT category_name

FROM categories c JOIN products p

  ON c.category_id = p.category_id

ORDER BY category_name
*/

-- SELECT statement using a subquery that uses the IN key in a WHERE clause
SELECT DISTINCT category_name
FROM categories
WHERE category_id IN
	(SELECT category_id		-- the subquery for category id
    FROM categories)
ORDER BY category_name;

/*
2. Write a SELECT statement that answers this question: Which products have a list price that’s greater than the average list price for all products?
Return the product_name and list_price columns for each product.

Sort the results by the list_price column in descending sequence.
*/

SELECT product_name, list_price
FROM products
WHERE list_price > ALL		-- subquery for a product's list price is greater than
	(						-- the average list price for all products
	SELECT AVG(list_price)
    FROM products
    )
ORDER BY list_price DESC	-- sorting

/*
3. Write a SELECT statement that returns the category_name column from the Categories table.
Return one row for each category that has never been assigned to any product in the Products table. To do that, use a subquery introduced with the NOT EXISTS operator.
*/

SELECT category_name
FROM categories c 
WHERE NOT EXISTS 
	(
	SELECT *
    FROM products p
    WHERE p.category_id = c.category_id
    )

/*
4. Write a SELECT statement that returns three columns: email_address, order_id, and the order total for each customer. To do this, you can group the result set by the email_address and order_id columns. In addition, you must calculate the order total from the columns in the Order_Items table.
Write a second SELECT statement that uses the first SELECT statement in its FROM clause. The main query should return two columns: the customer’s email address and the largest order for that customer. To do this, you can group the result set by the email_address.
*/

SELECT
	OrderTotal.email_address, order_id, max_order_total
FROM
(
	-- subquery to find the order total
    SELECT
		c.email_address,
		o.order_id,
        SUM((item_price - discount_amount) * quantity) AS order_total
	FROM customers c
		JOIN orders o
			ON c.customer_id = o.customer_id
		JOIN order_items oi
			ON o.order_id = oi.order_id
	GROUP BY c.email_address, o.order_id
) OrderTotal
		JOIN 
		(
			-- subquery to get the largest order for that customer
			SELECT
				email_address, MAX(order_total) AS max_order_total
			FROM
			(
				SELECT
					email_address,
                    o.order_id,
                    SUM((item_price - discount_amount) * quantity) AS order_total
				FROM customers c
					JOIN orders o
						ON c.customer_id = o.customer_id
					JOIN order_items oi
						ON o.order_id = oi.order_id
					GROUP BY c.email_address, o.order_id
			) CopyOfOrderTotal
			GROUP BY email_address
		) MaxOrderTotal
			-- grouping the two above tables
			ON OrderTotal.email_address = MaxOrderTotal.email_address AND
				OrderTotal.order_total = MaxOrderTotal.max_order_total

/*
5. Write a SELECT statement that returns the name and discount percent of each product that has a unique discount percent. In other words, don’t include products that have the same discount percent as another product.
Sort the results by the product_name column.
*/

SELECT product_name, discount_percent		-- selecting the correct columns
FROM products
WHERE discount_percent NOT IN
	(SELECT discount_percent				-- subquery for unique discount percentages
    FROM products
    GROUP BY discount_percent
    HAVING COUNT(discount_percent) > 1)
ORDER BY product_name;

SELECT * 
FROM products

-- 6. Use a correlated subquery to return one row per customer, representing the customer’s oldest order (the one with the earliest date). Each row should include these three columns: email_address, order_id, and order_date.

SELECT email_address, order_id, order_date
FROM customers c JOIN orders o			
	ON c.customer_id = o.customer_id		-- join condition for customer ID
WHERE order_date = 
	(SELECT MIN(order_date)					-- correlated subquery finding the customer's oldest order
    FROM orders
    WHERE customer_id = o.customer_id)

/*
7. Write an INSERT statement that adds this row to the Customers table:
email_address:             rick@raven.com
password:                     (empty string)
first_name:                   Rick
last_name:                   Raven

Use a column list for this statement.
*/

INSERT INTO customers (email_address, password, first_name, last_name) VALUES	-- inserting the row
	("rick@raven.com", "", "Rick", "Raven");

SELECT *					-- showing the inserted changes
FROM customers
WHERE customer_id = 9

-- 8. Write an UPDATE statement that modifies the Customers table. Change the password column to “secret” for the customer with an email address of rick@raven.com.

UPDATE customers							-- update statement
SET password = "secret" 
WHERE email_address = "rick@raven.com";

SELECT *									-- showing the updated changes
FROM customers
WHERE email_address = "rick@raven.com"

-- 9. Write an UPDATE statement that modifies the Customers table. Change the password column to “reset” for every customer in the table. If you get an error due to safe-update mode, you can add a LIMIT clause to update the first 100 rows of the table. (This should update all rows in the table.)

UPDATE customers			-- updating every customers' password to "reset"
SET password = "reset"
LIMIT 100;					-- limiting the update statement to affect the first 100 rows

SELECT * 					-- showing the updated changes
FROM customers

-- 10. Open the script named create_my_guitar_shop.sql that’s in the mgs_ex_starts directory. Then, run this script. That should restore the data that’s in the database.

-- Run the script in the MySQL Workbench or MySQL Command Line Client
SELECT *			-- showing that I've restored the data in the Customers table
FROM customers