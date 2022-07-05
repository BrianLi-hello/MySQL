USE my_guitar_shop;

/*
Exercises

1. Write a SELECT statement that returns these columns:
The count of the number of orders in the Orders table

The sum of the tax_amount columns in the Orders table
*/

SELECT										
	COUNT(order_id) AS number_of_orders,		-- counting number of orders
    SUM(tax_amount) AS total_tax_amount			-- the sum of tax_amount column
FROM orders										-- from the Ordes table

/*
2. Write a SELECT statement that returns one row for each category that has products with these columns:
The category_name column from the Categories table

The count of the products in the Products table

The list price of the most expensive product in the Products table

Sort the result set so the category with the most products appears first.
*/

SELECT												
	c.category_name,
    COUNT(p.product_id) AS product_count,			-- returning product_count
    MAX(p.list_price) AS most_expensive_product		-- returning most expensive product
FROM categories c JOIN products p					-- inner join between categories and products
	ON c.category_id = p.category_id
GROUP BY c.category_name							-- grouping by the category_name
ORDER BY product_count DESC							-- sorting

/*
3. Write a SELECT statement that returns one row for each customer that has orders with these columns:
The email_address column from the Customers table

The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table

The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table

Sort the result set in descending sequence by the item price total for each customer.
*/

SELECT
	c.email_address,
    SUM(oi.item_price * oi.quantity) AS item_price_total,			-- returning item_price_total
    SUM(oi.discount_amount * oi.quantity) AS item_discount_total	-- returning item_discount_total
FROM customers c 
	JOIN orders o								-- inner join between Customers and Orders tables
		ON c.customer_id = o.customer_id
	JOIN order_items oi							-- inner join between Orders and Order_Items tables
		ON o.order_id = oi.order_id
GROUP BY c.email_address						-- grouping by customer email addresses
ORDER BY item_price_total DESC					-- sorting

/*
4. Write a SELECT statement that returns one row for each customer that has orders with these columns:
The email_address from the Customers table

A count of the number of orders

The total amount for each order (Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.)

Return only those rows where the customer has more than 1 order.

Sort the result set in descending sequence by the sum of the line item amounts.
*/

SELECT											-- selecting the correct columns
	c.email_address,
    COUNT(o.order_id) AS number_of_orders,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS sum_of_line_item_amounts
FROM customers c 
	JOIN orders o								-- inner join between Customers and Orders tables
		ON c.customer_id = o.customer_id
	JOIN order_items oi							-- inner join between Orders and Order_Items tables
		ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING number_of_orders > 1						-- returning rows where the customer has > 1 order
ORDER BY sum_of_line_item_amounts DESC			-- sorting

-- 5. Modify the solution to exercise 4 so it only counts and totals line items that have an item_price value that’s greater than 400.

SELECT											-- selecting the correct columns
	c.email_address,
    COUNT(o.order_id) AS number_of_orders,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS sum_of_line_item_amounts
FROM customers c 
	JOIN orders o								-- inner join between Customers and Orders tables
		ON c.customer_id = o.customer_id
	JOIN order_items oi							-- inner join between Orders and Order_Items tables
		ON o.order_id = oi.order_id
WHERE oi.item_price > 400						-- item_price's value > 400 ; modification
GROUP BY c.email_address
HAVING number_of_orders > 1						-- returning rows where the customer has > 1 order
ORDER BY sum_of_line_item_amounts DESC			-- sorting

/*
6. Write a SELECT statement that answers this question: What is the total amount ordered for each product? Return these columns:
The product name from the Products table

The total amount for each product in the Order_Items (Hint: You can calculate the total amount by subtracting the discount amount from the item price and then multiplying it by the quantity)

Use the WITH ROLLUP operator to include a row that gives the grand total.

Note: Once you add the WITH ROLLUP operator, you may need to use MySQL Workbench’s Execute SQL Script button instead of its Execute Current Statement button to execute this statement.
*/

SELECT
	p.product_name,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS total_amount
FROM products p JOIN order_items oi
	ON p.product_id = oi.product_id
GROUP BY p.product_name WITH ROLLUP

/*
7. Write a SELECT statement that answers this question: Which customers have ordered more than one product? Return these columns:
The email address from the Customers table

The count of distinct products from the customer’s orders
*/

SELECT										-- selecting the correct columns
	c.email_address, 
    COUNT(DISTINCT oi.product_id) AS number_of_distinct_products
FROM customers c 
	JOIN orders o							-- inner join between Customers and Orders table
		ON c.customer_id = o.customer_id
	JOIN order_items oi						-- inner join between Orders and Order_Items table
		ON o.order_id = oi.order_id
GROUP BY c.email_address					-- grouping by customer's email addresses
HAVING number_of_distinct_products > 1		-- sorted by which customers have ordered > 1 product
