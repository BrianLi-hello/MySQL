use my_guitar_shop;

/* Chapter 5

How to insert, update, and delete data

Exercises

1. To test whether a table has been modified correctly as you do these exercises, you can write and run an appropriate SELECT statement.

Write an INSERT statement that adds this row to the Categories table:
category_name:            Brass

Code the INSERT statement so MySQL automatically generates the category_id column.
*/

INSERT INTO categories VALUES						-- insert statement
	(DEFAULT, 'Brass');								-- category_id is auto-incremented
													-- category_name will be Brass
SELECT *											-- select statement to show changes
FROM categories
WHERE category_id = 5 AND category_name = "Brass"

/*
2. Write an UPDATE statement that modifies the row you just added to the Categories table. 
This statement should change the product_name column to “Woodwinds”, and it should use the category_id column to identify the row.
*/ 

UPDATE categories										-- update statement
SET category_name = 'Woodwinds'							-- setting the category_name to Woodwinds
WHERE category_id = 5;									-- identifying the row with category_id

SELECT *												-- select statement to show changes
FROM categories
WHERE category_name = 'Woodwinds' AND category_id = 5

/*
3. Write a DELETE statement that deletes the row you added to the Categories table in exercise 1. 
This statement should use the category_id column to identify the row.
*/

DELETE FROM categories			-- deleting the inserted row in exercise 1
WHERE category_id = 5;			-- using the category_id to identify the row

SELECT *						-- select statement to show changes
FROM categories					-- inserted row is now deleted

/*
4. Write an INSERT statement that adds this row to the Products table:

product_id:                  The next automatically generated ID
category_id:                 4
product_code:              dgx_640
product_name:             Yamaha DGX 640 88-Key Digital Piano
description:                  Long description to come.
list_price:                     799.99
discount_percent:         0
date_added:                  Today’s date/time.

Use a column list for this statement.
*/

INSERT INTO products													-- insert statement
VALUES (DEFAULT, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano',	-- column list
	'Long description to come.', 799.99, 0, NOW());
    
SELECT *					-- select statement to show changes
FROM products
WHERE product_id = 11	

/*
5. Write an UPDATE statement that modifies the product you added in exercise 4. 
This statement should change the discount_percent column from 0% to 35%.
*/

UPDATE products						-- update statement
SET discount_percent = 35			-- changing the inserted row's discount_percent to 35%
WHERE product_id = 11;

SELECT *							-- select statement to show changes
FROM products
WHERE product_id = 11

/*
6. Write a DELETE statement that deletes the row that you added to the Categories table in exercise 1. 
When you execute this statement, it will produce an error since the category has related rows in the Products table. 
To fix that, precede the DELETE statement with another DELETE statement that deletes all products in this category. 
(Remember that to code two or more statements in a script, you must end each statement with a semicolon.)
*/

INSERT INTO categories VALUES		-- In exercise 3, the inserted row from exercise 1 is 
	(5, 'Brass');					-- already deleted, so I'm inserting a new row here

DELETE FROM products				-- preceding my deletion of the inserted row by 
where category_id = 5;				-- deleting the products with this category_id
							
DELETE FROM categories				-- deleting the inserted row
WHERE category_id = 5;

SELECT *							-- select statement to show changes
FROM categories