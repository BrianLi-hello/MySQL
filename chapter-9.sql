USE my_guitar_shop;

/* 
Exercises

1. Write a SELECT statement that returns these columns from the Products table:
The list_price column

The discount_percent column

A column named discount_amount that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result so it has 2 decimal digits
*/

SELECT
	list_price,
    discount_percent,
    ROUND(list_price * (discount_percent / 100), 2) AS discount_amount
FROM products

/* 2. Write a SELECT statement that returns these columns from the Orders table:
The order_date column

A column that uses the DATE_FORMAT function to return the four-digit year that’s stored in the order_date column

A column that uses the DATE_FORMAT function to return the order_date column in this format: Mon-DD-YYYY. In other words, use abbreviated months and separate each date component with dashes.

A column that uses the DATE_FORMAT function to return the order_date column with only the hours and minutes on a 12-hour clock with an am/pm indicator

A column that uses the DATE_FORMAT function to return the order_date column in this format: MM/DD/YY HH:SS. In other words, use two-digit months, days, and years and separate them by slashes. Use 2-digit hours and minutes on a 24-hour clock. And use leading zeros for all date/time components.
*/

SELECT 
	order_date,
    DATE_FORMAT(order_date, '%Y') AS order_date_year,			 -- formatting with just the year
    DATE_FORMAT(order_date, '%b-%d-%Y') AS order_date_format,  	 -- formatting in Mon-DD-YYYY
    DATE_FORMAT(order_date, '%h:%i %p') AS order_date_format_2,	 -- formatting with hours and minutes and AM/ PM
    DATE_FORMAT(order_date, '%m/%d/%y %H:%S') AS order_format_3	 -- formatting in MM/DD/YY HH:SS
FROM orders

/*
3. Write a SELECT statement that returns these columns from the Orders table:
The card_number column

The length of the card_number column

The last four digits of the card_number column

When you get that working right, add the columns that follow to the result set. This is more difficult because these columns require the use of functions within functions.

A column that displays the last four digits of the card_number column in this format: XXXX-XXXX-XXXX-1234. In other words, use Xs for the first 12 digits of the card number and actual numbers for the last four digits of the number.
*/

SELECT
	card_number,
    LENGTH(card_number) AS length_of_card_number,
    RIGHT(card_number, 4) AS card_number_last_four_digits,
    CONCAT(SUBSTRING(card_number, 1, 4), '-',						-- using CONCAT with SUBSTRING
		SUBSTRING(card_number, 5, 4), '-',
		SUBSTRING(card_number, 9, 4), '-',
        SUBSTRING(card_number, 13, 4)) AS card_number_formatted
FROM orders

/*
4. Write a SELECT statement that returns these columns from the Orders table:
The order_id column

The order_date column

A column named approx_ship_date that’s calculated by adding 2 days to the order_date column

The ship_date column

A column named days_to_ship that shows the number of days between the order date and the ship date

When you have this working, add a WHERE clause that retrieves just the orders for May 2015.
*/

SELECT
	order_id,
    order_date,
    DATE_ADD(order_date, INTERVAL 2 DAY) AS order_date_plus_two_days,
    ship_date,
    DATEDIFF(order_date, ship_date) AS days_between_order_date_and_ship_date
FROM orders
WHERE DATE_FORMAT(order_date, '%M %Y') = 'May 2015'
-- Another possibility for the WHERE clause: 
-- WHERE EXTRACT(MONTH FROM order_date) = 5 AND EXTRACT(YEAR FROM order_date) = 2015
-- There are no orders in May 2015