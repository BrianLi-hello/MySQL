use my_guitar_shop;

/* 
Exercise 1:
Write a SELECT statement that joins the Categories table to the Products table and returns these columns: CategoryName, ProductName, ListPrice.
Sort the result set by CategoryName and then by ProductName in ascending order.
*/

SELECT 										-- selecting the columns
    p.product_name AS ProductName, 
    c.category_name AS CategoryName, 
    p.list_price AS ListPrice				-- column aliases
FROM
    products p JOIN categories c
		ON p.category_id = c.category_id	-- join condition
ORDER BY CategoryName, ListPrice			-- sorting

/* 
Exercise 2:
Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: FirstName, LastName, Line1, City, State, ZipCode.
Return one row for each address for the customer with an email address of allan.sherwood@yahoo.com.
*/

SELECT												-- selecting the columns
	c.first_name AS FirstName,
    c.last_name AS LastName,
    a.line1 AS Line1,
    a.city AS City,
    a.state AS State,
    a.zip_code AS ZipCode
FROM customers c JOIN addresses a					-- join statement
	ON c.customer_id = a.customer_id				-- join condition
WHERE c.email_address = "allan.sherwood@yahoo.com"	-- where clause

/* 
Exercise 3:
Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: FirstName, LastName, Line1, City, State, ZipCode.
Return one row for each customer, but only return addresses that are the shipping address for a customer.
*/

SELECT											-- selecting the columns
	c.first_name AS FirstName,
    c.last_name AS LastName,
    a.line1 AS Line1,
    a.city AS City,
    a.state	 AS State, 
    a.zip_code AS ZipCode
FROM customers c JOIN addresses a				-- join statement
	ON c.customer_id = a.customer_id			-- join condition
    AND c.billing_address_id = a.address_id		-- AND operator in the join condition

/* 
Exercise 4:
Write a SELECT statement that joins the Customers, Orders, OrderItems, and Products tables. This statement should return these columns: LastName, FirstName, OrderDate, ProductName, ItemPrice, DiscountAmount, and Quantity.
Use aliases for the tables.

Sort the final result set by LastName, OrderDate, and ProductName.
*/

SELECT											-- selecting the columns
	c.last_name AS LastName,
    c.first_name AS FirstName,
    o.order_date AS OrderDate,
    p.product_name AS ProductName, 
    oi.item_price AS ItemPrice, 
    oi.discount_amount AS DiscountAmount,
    oi.quantity AS Quantity
FROM customers c								-- joining the 4 tables
	JOIN orders o								-- multiple join conditions
		ON c.customer_id = o.customer_id
	JOIN order_items oi
		ON o.order_id = oi.order_id
	JOIN products p
		ON oi.product_id = p.product_id
ORDER BY LastName, OrderDate, Quantity			-- sorting

/* 
Exercise 5:
Write a SELECT statement that returns the ProductName and ListPrice columns from the Products table.
Return one row for each product that has the same list price as another product. Hint: Use a self-join to check that the ProductID columns aren’t equal but the ListPrice column is equal.

Sort the result set by ProductName.
*/

SELECT p1.product_name, p1.list_price  	 -- selecting the correct columns
FROM products p1 JOIN products p2    	 -- self join
	ON p1.product_id != p2.product_id	 -- two join conditions
    AND p1.list_price = p2.list_price
ORDER BY p1.product_name				 -- sorting

/* 
Exercise 6:
Write a SELECT statement that returns these two columns:
CategoryName                 The CategoryName column from the Categories table

ProductID                    The ProductID column from the Products table

Return one row for each category that has never been used. Hint: Use an outer join and only return rows where the ProductID column contains a null value.
*/

SELECT 
    c.category_name AS CategoryName, 
    p.product_id AS ProductID
FROM
    categories c LEFT JOIN products p 
		ON c.category_id = p.category_id
WHERE
    p.product_id IS NULL

/* 
Exercise 7:
Use the UNION operator to generate a result set consisting of three columns from the Orders table:
ShipStatus              A calculated column that contains a value of SHIPPED or NOT SHIPPED

OrderID                 The OrderID column

OrderDate              The OrderDate column

If the order has a value in the ShipDate column, the ShipStatus column should contain a value of SHIPPED. Otherwise, it should contain a value of NOT SHIPPED.

Sort the final result set by OrderDate.
*/

	SELECT 										-- first select statement for SHIPPED
		'SHIPPED' AS ShipStatus, 
		order_id AS OrderID,
		order_date AS OrderDate
	FROM orders
	WHERE ship_date IS NOT NULL 
UNION 											-- union operator to connect select statements
	SELECT 										-- second select statement for NOT SHIPPED
		'NOT SHIPPED' AS ShipStatus, 
        order_id AS OrderID,
        order_date AS OrderDate
	FROM orders
	WHERE ship_date IS NULL
ORDER BY OrderDate DESC;						-- sorting
