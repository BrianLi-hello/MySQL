USE my_guitar_shop;

/* 
Exercises

1. Write a SELECT statement that returns these columns from the Products table:
The list_price column

A column that uses the FORMAT function to return the list_price column with 1 digit to the right of the decimal point

A column that uses the CONVERT function to return the list_price column as an integer

A column that uses the CAST function to return the list_price column as an integer
*/ 

SELECT
	list_price,
    FORMAT(list_price, 1) AS formatted_list_price,
    CONVERT(list_price, SIGNED) AS list_price_as_integer,
    CAST(list_price AS SIGNED) AS list_price_as_integer
FROM products

/* 
2. Write a SELECT statement that returns these columns from the Products table:
The date_added column

A column that uses the CAST function to return the date_added column with its date only (year, month, and day)

A column that uses the CAST function to return the date_added column with just the year and the month

A column that uses the CAST function to return the date_added column with its full time only (hour, minutes, and seconds)
*/

SELECT
	date_added,
    CAST(date_added AS DATE) AS date_added_as_date_only,
    CAST(date_added AS CHAR(7)) AS date_added_with_year_and_month,
    CAST(date_added AS TIME) AS date_added_with_full_time
FROM products