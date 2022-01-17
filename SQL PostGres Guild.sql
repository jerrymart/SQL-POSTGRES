
                   --CREATE TABLE
--https://www.postgresqltutorial.com/postgresql-create-table/
CREATE TABLE Customer_Table(
    First_Name VARCHAR,
	Last_Name VARCHAR,
	Age INT,
	Email_ID VARCHAR);

 

                    --INSERT 
                    --INSERT SINGLE COLUMN
--https://www.postgresqltutorial.com/postgresql-insert/

INSERT INTO customer_table (first_name,last_name,age,email_id)
VALUES('Jerry','Mart','500','jerryg@gmail.com');



--INSERT MULTIPLE COLUMN
--https://www.postgresqltutorial.com/postgresql-insert-multiple-rows/

INSERT INTO customer_table (first_name,last_name,age,email_id)
VALUES
      ('Legend','Harry','10','legendh@gmail.com'),
	  ('Vigo','Zaki','12','vigo@gmail.com'),
	  ('levitex','Sam','22','levit@gmail.com');



                              --COPY
--https://www.postgresqltutorial.com/import-csv-file-into-posgresql-table/

--COPY File Into Exixting DB Table
COPY customer_table(first_name, last_name, email_id,age)
FROM 'C:\Program Files\PostgreSQL\14\data\_jerryCopyData\copy.csv'
DELIMITER ','
CSV HEADER;

--Withot Specifying columns
--copy2.sv file has no column names
COPY customer_table
FROM 'C:\Program Files\PostgreSQL\14\data\_jerryCopyData\copy2.csv'
DELIMITER ','
CSV HEADER;

--Copy Text File
COPY customer_table
FROM 'C:\Program Files\PostgreSQL\14\data\_jerryCopyData\copytext.txt'
DELIMITER ',';

--This can easily be done using pgadmin GUI
--https://www.postgresqltutorial.com/import-csv-file-into-posgresql-table/



--**********************************************************
--*****  SELECT, SELECT DISTINCT, WHERE, LIKE 
--**********************************************************
--https://www.postgresqltutorial.com/postgresql-select/
--SELECT All Column
SELECT * FROM customer_table;

--SELECT Multiple Column
SELECT first_name, last_name FROM customer_table;

--DISTINCT
--https://www.postgresqltutorial.com/postgresql-select-distinct/
SELECT DISTINCT first_name FROM customer_table;

SELECT DISTINCT * FROM customer_table;


--WHERE

--https://www.postgresqltutorial.com/postgresql-where/
/*
WHERE is sused with thses operators: 
=	          Equal
>	          Greater than
<	          Less than
>=	          Greater than or equal
<=	          Less than or equal
<> or !=	  Not equal
AND	          Logical operator AND
OR	          Logical operator OR
IN	          Return true if a value matches any value in a list
BETWEEN	      Return true if a value is between a range of values
LIKE	      Return true if a value matches a pattern
IS NULL	      Return true if a value is NULL
NOT	          Negate the result of other operators
NOT IN
NOT NULL
*/

SELECT first_name FROM customer_table
WHERE age > 20;

SELECT DISTINCT first_name FROM customer_table
WHERE age != 20;


--WHERE WITH: OR
SELECT DISTINCT first_name,last_name FROM customer_table
WHERE age >= 50
OR age <= 25;


--WHERE WITH: BETWEEN
SELECT first_name FROM customer_table
WHERE age BETWEEN 28 AND 40;

--WHERE WITH: NOT
SELECT first_name,age FROM customer_table
WHERE NOT age <30 ;

----WHERE WITH: LIKE
SELECT email_id FROM customer_table
WHERE first_name LIKE 'J%';

SELECT first_name, email_id FROM customer_table
WHERE first_name LIKE '%ex';

--WHERE WITH: NOT,LIKE,AND, %PATTERN%
SELECT first_name FROM customer_table
WHERE age <= 30
AND last_name NOT LIKE '%r%';

--WHERE WITH: LIKE,'_pattern%'
SELECT first_name FROM customer_table
WHERE first_name LIKE '_err%';

--WHERE WITH: LIKE, '%pattern_';
SELECT first_name FROM customer_table
WHERE first_name LIKE '%ran_';

--WHERE WITH: ILIKE, '%pattern';
SELECT first_name,last_name
FROM customer_table
WHERE first_name ILIKE 'LIN%'; --ILIKE is not cae sensitive

--WHERE WITH: NOT ILIKE, 'pattern%';
SELECT first_name,last_name
FROM customer_table
WHERE first_name NOT ILIKE 'LIN%';

--WHERE WITH: LIKE, 'pattern%';
SELECT first_name,last_name
FROM customer_table
WHERE first_name LIKE 'LIN%';


--*****************UPDATE***********
--**********************************
-- https://www.postgresqltutorial.com/postgresql-update/
--N:B: UPDATE is used with SET command always

--Syntax

UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;


SELECT * FROM customer_table

UPDATE customer_table
SET first_name = 'Dayo',
    last_name = 'Darion',
	email_id = 'dd@xyz.com'
WHERE email_id = 'dl@xyz.com' 

--Check
SELECT first_name,last_name FROM customer_table
WHERE first_name = 'Dayo';


--**************DELETE,ALTER TABLE***************
--***********************************************
--https://www.postgresqltutorial.com/postgresql-delete/
--Syntax
DELETE FROM table_name
WHERE condition;

DELETE FROM links
WHERE id IN (6,5)
RETURNING *;

--Deleting all entries in table
DELETE FROM table_name



--**************ALTER TABLE *****************
--Typically, ALTER manipulates Columns with
--ADD,DROP,RENAME and column properties such as data types ,constraints,and setting default values
--It also RENAME table

--PostgreSQL provides you with many actions:
--Add a column:https://www.postgresqltutorial.com/postgresql-add-column/
--Drop a column:https://www.postgresqltutorial.com/postgresql-drop-column/
--Change the data type of a column:https://www.postgresqltutorial.com/postgresql-change-column-type/
--Rename a column:https://www.postgresqltutorial.com/postgresql-rename-column/
--Set a default value for the column.
--Add a constraint to a column.:https://www.postgresqltutorial.com/postgresql-check-constraint/
--Rename a table :https://www.postgresqltutorial.com/postgresql-rename-table/

--Syntax
ALTER TABLE table_name 
ACTION;




--***********************************
-- IN,BETWEEN,LIKE Using with WHERE
--***********************************
--Recall WHERE must be used with IN,BETWEEN,LIKE
-- https://www.postgresqltutorial.com/postgresql-in/
--Using 'IN' is more scalable to using OR
/*

value IN (SELECT column_name FROM table_name);

--Using IN within subquery
--IN is used to perform subquery as seen below
===========================
SELECT
	customer_id,
	first_name,
FROM customer
WHERE customer_id IN (
		SELECT customer_id FROM rental
		WHERE CAST (return_date AS DATE) = '2005-05-27'
	)
ORDER BY customer_id;
*/
--======================================
SELECT * FROM customer;
SELECT *  FROM sales;
SELECT * FROM product;

SELECT * FROM sales
WHERE order_id IN ('CA-2014-115812', 'CA-2015-106320')
ORDER BY customer_id DESC;


SELECT * FROM sales
WHERE customer_id IN ('JL-15505', 'KW-16435')
ORDER BY order_date DESC;


--using customer
SELECT * FROM customer;

SELECT customer_name,city FROM customer
WHERE state IN('Kentucky', 'California')
ORDER BY state DESC;


--IN in subquerry example
SELECT customer_id,customer_name FROM customer
WHERE state IN (
	     SELECT state FROM customer
         WHERE state IN('Kentucky', 'California')
         ORDER BY customer_id DESC
      );



--********BETWEEN**********
--*************************

--https://www.postgresqltutorial.com/postgresql-between/
	 
SELECT customer_id,customer_name
FROM customer
WHERE age BETWEEN 18 AND 48;


-- ********* NOT BETWEEN **********
SELECT customer_id,customer_name
FROM customer
WHERE age NOT BETWEEN 18 AND 48;



--******** LIKE  **********
--https://www.postgresqltutorial.com/postgresql-like/
--Used for Patthern Matching

--custome_name begining with 'Jo'
SELECT * FROM customer
WHERE customer_name ILIKE 'Jo%';

--custome_name begining with 'Jo'
SELECT * FROM customer
WHERE customer_name NOT LIKE 'Jo%';


--Customer_name ending with 'en'
SELECT * FROM customer
WHERE customer_name LIKE '%en';

--Customer_name having 'od' in their name
SELECT * FROM customer
WHERE customer_name LIKE '%od%';

--customer_name starting with 'Bradl_y' and missing a single character
SELECT customer_name FROM customer
WHERE customer_name LIKE 'Bradl_y%';

--Customer_name with 10 characters
SELECT customer_name FROM customer
WHERE customer_name LIKE '__________'

--customer who has '%' in thier name
SELECT * FROM customer
WHERE customer_name LIKE 'G\%';



--************ ILIKE ******************
--It wroks exactly as LIKE but it is not case sensitive comparedto LIKE
--custome_name begining with 'Jo'
SELECT * FROM customer
WHERE customer_name ILIKE 'JOn%';



--**********ORDER BY ***************
--https://www.postgresqltutorial.com/postgresql-order-by/

--ORDER BY single column
SELECT state, city,LENGTH(city) len
FROM customer
ORDER BY len DESC;

--ORDER BY multiple column
SELECT state, city, LENGTH(city) len
FROM customer
ORDER BY state ASC, len DESC;


--ORDER BY NULL LAST, NULL FIRST
/*
SELECT num FROM sort_demo
ORDER BY num DESC NULLS LAST;
*/

/*
SELECT num FROM sort_demo 
ORDER BY num NULLS FIRST;
*/


                       --************* LIMIT ****************
-- https://www.postgresqltutorial.com/postgresql-limit/
/*
PostgreSQL LIMIT is an optional clause of the SELECT statement that constrains the number of rows returned by the query.
*/
--NOTE: Always use LIMIT with ORDER BY to get desired result. When used, it must come after ORDER BY , not before ORDER BY

--LIMIT
SELECT order_line,order_id FROM sales 
ORDER BY order_line
LIMIT 10;

--LIMIT with OFFSET 
SELECT order_line,order_id FROM sales 
ORDER BY order_line
LIMIT 10 OFFSET 3;


--************  AS *****************
--https://www.postgresqltutorial.com/postgresql-column-alias/

SELECT
    first_name || ' ' || last_name AS full_name
FROM
    customer;

--Note that in PostgreSQL, you use the || as the concatenating operator that concatenates one or more strings into a single string.
--This will join 'first_name' and 'last_name' under a single comlumn 'full_name'
-- Incase the new column name has space surround it like this 'full name'

SELECT  first_name, last_name AS surname
FROM customer;

--************************************************************
--  AGGREGATE FUNCTIONS: COUNT, SUM, AVG, MIN, MAX
--************************************************************
--NOTE: Ince you use any aggregate function, in SELECT statement and you also have one or more columns in the select statement
    --it is required that at least one of the columns in the SELECT statement that is not in any aggregate function must be used
    -- in a GROUP BY clause 
/*
https://www.postgresqltutorial.com/postgresql-aggregate-functions/

We often use the aggregate functions with the GROUP BY clause in the SELECT statement

You can use aggregate functions as expressions only in the following clauses:

 SELECT clause.
 HAVING clause.
*/

--COUNT
--https://www.postgresqltutorial.com/postgresql-count-function/

SELECT COUNT(order_line) AS "Number of Products Ordered",
COUNT(DISTINCT (order_id)) AS "Number of Orders"
FROM sales WHERE customer_id = 'CG-12520';


--SUM
--https://www.postgresqltutorial.com/postgresql-sum-function/
SELECT SUM(quantity) AS "Total Qauntity"
FROM sales 
WHERE product_id = 'FUR-TA-10000577';


--AVG
--https://www.postgresqltutorial.com/postgresql-avg-function/

--You can use the AVG() function in the SELECT and HAVING clauses.

SELECT AVG (age) AS "Average Customer Age"
FROM customer;

SELECT AVG(sales * 0.10) AS "Average Commission Value"
FROM sales;


--NOTE: Whenever GROUP BY is not used with Aggregate Functions, only single
-- column would be allowed in the any aggregate function

--Example
--This will not work since non  of customer_name, city are in Group BY 
--Cases like this either both customer_name, city belong to an Aggregte Functn or we use GROUP BY on any 
-- of the customer_name, city or any other clumn n the table
SELECT customer_name, city, AVG (age)::NUMERIC(10) AS "Average Customer Age" 
FROM customer 
--The above won't work

--Aggregate AVG with GROUP BY
SELECT customer_name, city, AVG (age)::NUMERIC(10) AS "Average Customer Age" 
FROM customer
GROUP BY customer_id;


--Aggregate AVG with GROUP BY, HAVING, ORDER BY
SELECT customer_name,customer_id, AVG (age)::NUMERIC(10,2) 
FROM customer
GROUP BY customer_id
HAVING  AVG (age) > 5
ORDER BY customer_id;

SELECT AVG(DISTINCT age)::numeric(10,2)
FROM customer;


--MIN
--https://www.postgresqltutorial.com/postgresql-min-function/
/*
Summary
Use the MIN() function to find the lowest value in a set of values.
Use the MIN() with GROUP BY clause to find the lowest value in a group of values.
Use the LEAST() function to find minimum values between columns.
*/

SELECT MIN(profit)
FROM sales;

--MIN() with GROUP BY, HAVING MIN,ORDER BY
SELECT product_id,	MIN(sales) minmum_sales
FROM sales
GROUP BY product_id
HAVING MIN(sales) < 90
ORDER BY product_id;

--Finding the smallest values from two or more columns
--In this case, you cannot use the MIN() function because the MIN() function is applied to rows, not columns. 
--To find the minimum value of two or more columns, you use the LEAST() function:
SELECT LEAST(sales, quantity, profit) AS lowest_rank
FROM sales;

--MAX function in subquery
SELECT * FROM sales
WHERE profit = ( SELECT MIN(profit) FROM sales
);

--MAX
--MAX works n similar way as MIN
----To find the minimum value of two or more columns, you use the GREATEST() function:
SELECT GREATEST(sales, quantity, profit) AS Greatest_val
FROM sales;

--MAX function in subquery
SELECT * FROM sales
WHERE profit = ( SELECT MAX(profit) FROM sales
);




--NOTE: FROM here on, I use the dvdrental database

--********************--GROUP BY ********************
/*
PostgreSQL evaluates the GROUP BY clause after the FROM and WHERE clauses 
and before the HAVING SELECT, DISTINCT, ORDER BY and LIMIT clauses.
*/
--https://www.postgresqltutorial.com/postgresql-group-by/

--GROUP BY without an aggregate function
SELECT customer_id
FROM payment
GROUP BY customer_id;


--GROUP BY with SUM()
SELECT customer_id,	SUM (amount)
FROM payment
GROUP BY customer_id;

--GROUP BY with SUM(), ORDER BY
SELECT customer_id, SUM (amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM (amount) DESC;

SELECT * FROM payment LIMIT 5;
SELECT * FROM customer LIMIT 5;


--GROUP BY clause with the JOIN clause
--Unlike the previous example, this query joins the payment table with the customer table and group customers by their names.
SELECT first_name || ' ' || last_name full_name, SUM (amount) amount
FROM payment
INNER JOIN customer USING (customer_id)  	
GROUP BY full_name
ORDER BY amount DESC LIMIT 10;	

--GROUP BY with COUNT() 
SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id;


--PostgreSQL GROUP BY with multiple columns
SELECT customer_id,staff_id,SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY customer_id;

--PostgreSQL GROUP BY clause with date column
SELECT DATE(payment_date) paid_date, SUM(amount) FROM payment
GROUP BY DATE(payment_date);


--******HAVING******
/*
The HAVING clause specifies a search condition for a Group or an AGGREGATE. 
The HAVING clause is often used with the GROUP BY clause to filter Group or AGGREGATE based on a specified condition.
*/
--PostgreSQL evaluates the HAVING clause after the FROM, WHERE, GROUP BY, and before the SELECT, DISTINCT, ORDER BY and LIMIT clauses.	
--In other words, the WHERE clause is applied to rows while the HAVING clause is applied to groups of rows.


--1) Using PostgreSQL HAVING clause with SUM
--The following statement adds the HAVING clause to select the only customers who have been spending more than 200
SELECT customer_id,	SUM (amount)
FROM payment
GROUP BY customer_id
HAVING SUM (amount) > 200;

--2) PostgreSQL HAVING clause with COUNT
--The following statement adds the HAVING clause to select the store that has more than 300 customers
SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT (customer_id) > 300;





--CONDITIONAL EXPRESSIONS & OPERATORS

/*
1.CASE
2.COALESCE
3.NULLIF
4.CAST
*/

SELECT * FROM film;

                                        --1.CASE

--1. CASE expression in the SELECT statement

--https://www.postgresqltutorial.com/postgresql-case/
--Works like IF/ELSE
--Check out the task in above url to interprete this code

/*
Suppose you want to label the films by their length based on the following logic:
If the lengh is less than 50 minutes, the film is short.
If the length is greater than 50 minutes and less than or equal to 120 minutes, the film is medium.
If the length is greater than 120 minutes, the film is long.
To apply this logic, you can use the CASE expression in the SELECT statement as follows:
*/
SELECT title,
       length,
       CASE
           WHEN length> 0
                AND length <= 50 THEN 'Short'
           WHEN length > 50
                AND length <= 120 THEN 'Medium'
           WHEN length> 120 THEN 'Long'
       END duration
FROM film
ORDER BY title;



--B) Using CASE with an aggregate function 
/*
Suppose that you want to assign price segments to films with the following logic:
If the rental rate is 0.99, the film is economic.
If the rental rate is 1.99, the film is mass.
If the rental rate is 4.99, the film is premium.
And you want to know the number of films that belong to economy, mass, and premium.
In this case, you can use the CASE expression to construct the query as follows:
*/

SELECT
	SUM (CASE
               WHEN rental_rate = 0.99 THEN 1
	       ELSE 0
	      END
	) AS "Economy",
	
	SUM (
		CASE
		WHEN rental_rate = 2.99 THEN 1
		ELSE 0
		END
	) AS "Mass",
	
	SUM (
		CASE
		WHEN rental_rate = 4.99 THEN 1
		ELSE 0
		END
	) AS "Premium"
FROM film;


--Simple PostgreSQL CASE expression
SELECT title,
       rating,
       CASE rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
       END rating_description
FROM film
ORDER BY title;



--Using simple PostgreSQL CASE expression with aggregate function
SELECT
       SUM(CASE rating
             WHEN 'G' THEN 1 
		     ELSE 0 
		   END) "General Audiences",
		   
       SUM(CASE rating
             WHEN 'PG' THEN 1 
		     ELSE 0 
		   END) "Parental Guidance Suggested",
		   
       SUM(CASE rating
             WHEN 'PG-13' THEN 1 
		     ELSE 0 
		   END) "Parents Strongly Cautioned",
		   
       SUM(CASE rating
             WHEN 'R' THEN 1 
		     ELSE 0 
		   END) "Restricted",
		   
       SUM(CASE rating
             WHEN 'NC-17' THEN 1 
		     ELSE 0 
		   END) "Adults Only"
FROM film;





--=============================================
-- INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN
--=============================================
--IMPORTANT: Watch out in examples below for [foreign table] and [primary table]

-- INNER JOIN
--https://www.postgresqltutorial.com/postgresql-inner-join/

-- 1) Using PostgreSQL INNER JOIN to join two tables

SELECT
	customer.customer_id,
	first_name,   --in customer
	last_name,    --in customer
	amount,       --in payment
	payment_date  --in payment

FROM customer --primary table
INNER JOIN payment --primary table
    ON payment.customer_id = customer.customer_id
ORDER BY payment_date;


--The following query returns the same result. However, it uses table aliases:
SELECT
	c.customer_id,
	first_name,
	last_name,
	email,
	amount,
	payment_date
FROM customer c --primary table
INNER JOIN payment p --primary table
    ON p.customer_id = c.customer_id
WHERE  c.customer_id = 2
ORDER BY payment_date;


--Since both tables have the same customer_id column, you can use the USING syntax:
SELECT
	customer_id,
	first_name,
	last_name,
	amount,
	payment_date
FROM customer --primary table
INNER JOIN payment --primary table
    USING(customer_id)
ORDER BY payment_date;	



--==================================
-- JOIN Multiple Tables
---=================================

--Join customer,payent,staff table
SELECT
	customer.customer_id,
	customer.first_name customer_first_name,
	customer.last_name customer_last_name,
	staff.first_name staff_first_name,
	staff.last_name staff_last_name,
	payment.amount,
	payment.payment_date
FROM customer ----primary table
INNER JOIN payment --primary table
    ON payment.customer_id = customer.customer_id
INNER JOIN staff 
    ON payment.staff_id = staff.staff_id
ORDER BY payment_date;


--OR USING ALIAS Gives same result
SELECT
	c.customer_id,
	c.first_name customer_first_name,
	c.last_name customer_last_name,
	s.first_name staff_first_name,
	s.last_name staff_last_name,
	amount,
	payment_date
FROM
	customer c  --primary table
INNER JOIN payment p --primary table
    ON p.customer_id = c.customer_id
INNER JOIN staff s 
    ON p.staff_id = s.staff_id
ORDER BY payment_date;



--=============================
--LEFT JOIN i.e LEFT OUTER JOIN
--=============================

--NOTE:Always use LEFT JOIN over RIGHT JOIN
--They do exactly thesame thing in their outcome


--The following statement uses the LEFT JOIN clause to join film table with the inventorytable

SELECT
	film.film_id,
	film.title,
	inventory.inventory_id
FROM film --primary table 
LEFT JOIN inventory --primary table
    ON inventory.film_id = film.film_id
ORDER BY title;

--This not only return all common row in film and in inventory but also for every row present in film
--not present in inventory, it will insert NULL into all inventory columns in the new table


-- WHERE clause to find the films that are not in the inventory:
--It find rows where film_id are absent in inventory
SELECT
	film.film_id,
	film.title,
	inventory.inventory_id
FROM film --left  table
LEFT JOIN inventory --right table
   ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL
ORDER BY title;


--Usin ALIAS for thesame above
SELECT
	f.film_id,
	f.title,
	i.inventory_id
FROM
	film f ----left table
LEFT JOIN inventory i --right table
   ON i.film_id = f.film_id
WHERE i.film_id IS NULL
ORDER BY title;


--USING syntax
--If both tables have the same column name used in the ON clause, you can use the USING syntax like this:
SELECT
	f.film_id,
	f.title,
	i.inventory_id
FROM
	film f --left table
LEFT JOIN inventory i --right table
USING (film_id)

WHERE i.film_id IS NULL
ORDER BY title;



--NOTE:Always use LEFT JOIN over RIGHT JOIN
--They do exactly thesame thing in their outcome


--==============================
--     RIGHT JOIN
--==============================
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS film_reviews;

CREATE TABLE films(
   film_id SERIAL PRIMARY KEY,
   title varchar(255) NOT NULL
);

INSERT INTO films(title)
VALUES('Joker'),
      ('Avengers'),
      ('Parasite'),
	  ('Avarion'),
	  ('Drake');



CREATE TABLE film_reviews(
   review_id SERIAL PRIMARY KEY,
   film_id INT,
   review VARCHAR(255) NOT NULL	
);

INSERT INTO film_reviews(film_id, review)
VALUES(1, 'Awesome'),
      (2, 'Cool'),
      (3, 'Beautiful'),
	  (4, 'Excellent'),
	  (5, 'Glad'),
	  (6, 'Joy'),
	  (7, 'Smart'),
	  (8, 'Brilliant');



--NOTE:Always use LEFT JOIN over RIGHT JOIN
--They do exactly thesame thing in their outcome



--------------------RIGHT JOIN---------------------------
--RIGHT JOINreturns all the rows in right table and thos e rows present in both left and right table on 
-- it returns NULL in right table columns for rows present in left table but absent in right table

SELECT 
   film_reviews.film_id,
   film_reviews.review, 
   films.title
FROM films --RIGHT table
RIGHT JOIN film_reviews --left table
   ON film_reviews.film_id = films.film_id;


--RIGHT JOIN with WHERE
-- returns the (RIGHT table) film rows have film tittle NULL 
SELECT 
   film_reviews.film_id,
   film_reviews.review, 
   films.title
FROM films --RIGHT table
RIGHT JOIN film_reviews --left table
   ON film_reviews.film_id = films.film_id
WHERE films.title IS NULL;


--right join WITH USING
SELECT 
   film_reviews.film_id,
   film_reviews.review, 
   films.title
FROM films --RIGHT table
RIGHT JOIN film_reviews --left table
USING (film_id)


--EQUIVALENT RESULT WITH LEFT JOIN
SELECT 
   film_reviews.film_id,
   film_reviews.review, 
   films.title Right_table
FROM film_reviews  --LEFT table
LEFT JOIN films --Right table
USING (film_id)
WHERE films IS NULL;



--FULL OUTER JOIN
--https://www.postgresqltutorial.com/postgresql-full-outer-join/

--Join everything in both tables.
--Combines LEFT and RIGHT JOIN together
--If a row is in table 1 and not in table 2, it makes it NULL at table 2 column in the new table nd vice vasa

DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;

CREATE TABLE departments (
	department_id serial PRIMARY KEY,
	department_name VARCHAR (255) NOT NULL
);

CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	employee_name VARCHAR (255),
	department_id INTEGER
);

INSERT INTO departments (department_name)
VALUES
	('Sales'),
	('Marketing'),
	('HR'),
	('IT'),
	('Production');

INSERT INTO employees (
	employee_name,
	department_id
)
VALUES
	('Bette Nicholson', 1),
	('Christian Gable', 1),
	('Joe Swank', 2),
	('Fred Costner', 3),
	('Sandra Kilmer', 4),
	('Julia Mcqueen', NULL);
	
	
	
SELECT * FROM departments;
SELECT * FROM employees;




--FULL OUTER JOIN

SELECT
	employee_name,
	department_name
FROM employees e
FULL OUTER JOIN departments d 
        ON d.department_id = e.department_id;	
	


--To find the department that does not have any employees, you use a WHERE clause as follows:
SELECT
	employee_name,
	department_name
FROM
	employees e
FULL OUTER JOIN departments d 
        ON d.department_id = e.department_id
WHERE
	employee_name IS NULL;



--To find the employee who does not belong to any department, 
--you check for the NULL of the department_name in the WHERE clause as the following statement:

SELECT
	employee_name,
	department_name
FROM
	employees e
FULL OUTER JOIN departments d ON d.department_id = e.department_id
WHERE
	department_name IS NULL;
	



--CROSS JOIN
--A CROSS JOIN clause allows you to produce a Cartesian Product of rows in two or more tables.
--https://www.postgresqltutorial.com/postgresql-cross-join/
--iT MAPS each row in Table 1 with every rows in Table 2


DROP TABLE IF EXISTS T1;
CREATE TABLE T1 (label CHAR(1) PRIMARY KEY);

DROP TABLE IF EXISTS T2;
CREATE TABLE T2 (score INT PRIMARY KEY);

INSERT INTO T1 (label)
VALUES
	('A'),
	('B');

INSERT INTO T2 (score)
VALUES
	(1),
	(2),
	(3);
	
SELECT * FROM T1,T2;

--OR USE THIS 
SELECT * FROM T1
CROSS JOIN T2;

--=========================
--UNION,INTERSECT,EXCEPT
--=========================

--https://www.postgresqltutorial.com/postgresql-union/

DROP TABLE IF EXISTS top_rated_films;
CREATE TABLE top_rated_films(
	title VARCHAR NOT NULL,
	release_year SMALLINT
);

DROP TABLE IF EXISTS most_popular_films;
CREATE TABLE most_popular_films(
	title VARCHAR NOT NULL,
	release_year SMALLINT
);

INSERT INTO 
   top_rated_films(title,release_year)
VALUES
   ('The Shawshank Redemption',1994),
   ('The Godfather',1972),
   ('12 Angry Men',1957);

INSERT INTO 
   most_popular_films(title,release_year)
VALUES
   ('An American Pickle',2020),
   ('The Godfather',1972),
   ('Greyhound',2020);
   
   


--UNION
--https://www.postgresqltutorial.com/postgresql-union/

--1) Simple PostgreSQL UNION example
SELECT * FROM top_rated_films
UNION
SELECT * FROM most_popular_films;

--2) PostgreSQL UNION ALL example
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films;

--3) PostgreSQL UNION ALL with ORDER BY
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films
ORDER BY title;



--INTERSECT Syntax
--https://www.postgresqltutorial.com/postgresql-intersect/
SELECT COLUM_Name
FROM A
INTERSECT
SELECT COLUM_Name
FROM B
ORDER BY sort_expression;

--INTERSECT operator examples
SELECT *
FROM most_popular_films 
INTERSECT
SELECT *
FROM top_rated_films;

	
--EXCEPT
--https://www.postgresqltutorial.com/postgresql-except/
--The EXCEPT operator returns distinct rows from the first (left) query that are not in the output of the second (right) query.
--Syntax
SELECT COLUM_Name
FROM A
EXCEPT 
SELECT COLUM_Name
FROM B;

--EXCEPT Example
SELECT * FROM top_rated_films
EXCEPT 
SELECT * FROM most_popular_films
ORDER BY title;



--SUBQUERY
--https://www.postgresqltutorial.com/postgresql-subquery/

--Subqueries can reside in the "WHERE", "FROM" , or "SELECT" clause.


/*
There are a few rules that subqueries must follow −

•Subqueries must be enclosed within parentheses.

•A subquery can have only one column in the SELECT clause, unless multiple
columns are in the main query for the subquery to compare its selected
columns.

•An ORDER BY command cannot be used in a subquery, although the main
query can use an ORDER BY. The GROUP BY command can be used to
perform the same function as the ORDER BY in a subquery.

•Subqueries that return more than one row can only be used with multiple
value operators such as the IN operator.

•The SELECT list cannot include any references to values that evaluate to a
BLOB, ARRAY, CLOB, or NCLOB.

•A subquery cannot be immediately enclosed in a set function.

•The BETWEEN operator cannot be used with a subquery. However, the
BETWEEN operator can be used within the subquery.

*/



--SUBQURY WITH WHERE
SELECT * FROM sales
WHERE customer_ID IN (SELECT DISTINCT customer_id FROM customer 
		            WHERE age >60);

--example 2 with dvdrentaldb
SELECT film_id,title,rental_rate FROM film
WHERE rental_rate > (SELECT AVG (rental_rate) FROM film);
 


 --PostgreSQL subquery with IN operator
--For example, to get films that have the returned date between 2005-05-29 and 2005-05-30, in dvdrentaldb
SELECT film_id,title FROM film
WHERE film_id IN (SELECT inventory.film_id FROM rental
		          INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
		          WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30');



--SUBQUERY with FROM
--COMBINE THE QUERRY
SELECT a.product_id, a.product_name, a.category, b.quantity
FROM product AS a

LEFT JOIN 
    --Subquery
	(SELECT product_id,SUM(quantity) AS quantity
	 FROM sales 
	 GROUP BY product_id ) AS b
USING(product_id)

ORDER BY b.quantity desc

--breaking this down
SELECT a.product_id, a.product_name, a.category --b.quantity
FROM product AS a

--Subquery
(SELECT product_id,SUM(quantity) AS quantity
FROM sales 
GROUP BY product_id ) -- AS b




--SUBQURY WITH SELECT
SELECT customer_id, order_line, 
       (SELECT customer_name FROM customer 
        WHERE sales.customer_id = customer.customer_id)
FROM sales
ORDER BY customer_id
 
 

SELECT film_id,title,rental_rate FROM film
WHERE rental_rate > (SELECT AVG (rental_rate) FROM film);



--PostgreSQL subquery with EXISTS operator
--https://www.postgresqltutorial.com/postgresql-exists/
SELECT first_name,last_name FROM customer
WHERE EXISTS (SELECT 1 FROM payment
		      WHERE payment.customer_id = customer.customer_id);



--=========================
--   VIEWS
--https://www.postgresqltutorial.com/postgresql-views/
--=========================
--Check the power point presentation and the url above for more

CREATE OR REPLACE VIEW logistics AS
	(SELECT a.order_line ,a.order_id,b.customer_name,b.city,b.state,b.country
	FROM sales AS a
	LEFT JOIN customer as b
	ON a.customer_id = b.customer_id
	ORDER BY a.order_line);
	
SELECT * from logistics;


--DROP VIEW
DROP VIEW viewname; 


--UPDATE VIEW
--If you update view, it will update the table .Do not update tables via view, not recommended.
UPDATE viewname
SET Column = US
WHERE Country = ‘United;


--============================
--   INDEX
--============================

--https://www.postgresqltutorial.com/postgresql-indexes/

CREATE INDEX mon_idx
ON month_values (MM);

DROP INDEX [IF EXISTS]
index_name
[ CASCADE | RESTRICT ];


--==================================================================================================
--String Functions
--LENGTH, UPPER LOWER, REPLACE, TRIM, LTRIM, RTRIM, CONCATENATION, SUBSTRING, LIST AGGREGATION
--==================================================================================================

--LENGTH
SELECT Customer_name , Length Customer_name ) as characters
FROM customer
WHERE age > 50;

--UPPER
SELECT UPPER(Customer_name ) as Advaced_Age
FROM customer WHERE age >=56

--LOWER
SELECT UPPER(Customer_name ) as Advaced_Age
FROM customer WHERE age >=56



--REPLACE

--syntax
--replace( string,from_substring , to_substring)

--Replace function is case sensitive.
SELECT Customer_name,country,
Replace(lower(country),'united states','US') AS country
FROM customer

SELECT Customer_name,country,
Replace(country,'United States','US') AS country
FROM customer

--Since REPLACE is case sensitive the first syntax with lower(country) is recommended



--TRIM,LTRIM & RTRIM
/*
TRIM function removes all specified characters either from the beginning or the end of a string
RTRIM function removes all specified characters from the right hand side of a string
LTRIM function removes all specified characters from the left hand side of a string

trim( [ leading | trailing | both ] [trim_character ] from string)

rtrim( string, trim_character)

ltrim( string, trim_character
*/


--trim begining
SELECT trim(leading ' ' from ' Start Tech Academy ');
SELECT ltrim (' Start Tech Academy ', ' ');

--trim end
SELECT trim(trailing ' ' from ' Start Tech Academy ');
SELECT rtrim (' Start Tech Academy ', ' ');

--trim both begining and end 
SELECT trim(both ' ' from ' Start Tech Academy ');
SELECT trim(' Start Tech Academy ');


--CONCAT
--string1 || string2 ||string_n

SELECT Customer_name,  city|| ' , '||state|| ' , '||country AS address
FROM customer;


--SUBSTRING
--SUBSTRING function allows you to extract a substring from a string
--Syntax
substring( string [from start_position ] [for length]

--Filter out customer_id begining with first 2 alpabet = 'AB'
SELECT Customer_id, Customer_name,
SUBSTRING(Customer_id FOR 2) AS cust_group
FROM customer
WHERE SUBSTRING(Customer_id FOR 2) = 'AB';

--Filter out the numeric part of customer_id
SELECT Customer_id,Customer_name,
SUBSTRING (Customer_id FROM 4 FOR 5) AS cust_number
FROM customer
WHERE SUBSTRING(Customer_id FOR 2) = 'AB';



--STRING AGGREGATOR
SELECT order_id, product_id FROM sales

--AGGREGATE all product_id grouping by order_id
SELECT order_id, 
STRING_AGG(product_id, ' , ')
FROM sales
GROUP BY order_id



--===========================
--MATHEMATICAL FUNCTIONS
--===========================

--CEIL & FLOOR
/*
CEIL function returns the smallest integer value that is greater than or equal to a number
FLOOR function returns the largest integer value that is equal to or less than a number.

Syntax

CEIL (number)
FLOOR (number)
*/

SELECT order_line, sales,CEIL(sales ), FLOOR(sales ) FROM sales
WHERE discount>0;


--RANDOM
/*
RANDOM( )
The random function will return a value between 0 (inclusive) and 1 (exclusive),
so value >= 0 and value < 1.

Random decimal between a range (a included and b excluded)
SELECT RANDOM()*(ba)+a

Random Integer between a range (both boundaries included)
SELECT FLOOR(RANDOM()*(b
a+1))+a;

*/


--SETSEED
/*
If we set the seed by calling the
setseed function, then the random function will return a repeatable sequence of
random numbers that is derived from the seed.
*/
SELECT SETSEED(0.5);
SELECT RANDOM();
SELECT RANDOM();

--ROUND
SELECT order_line,sales,ROUND(sales) FROM sales

--POWER
SELECT POWER(6, 2);

SELECT age, power(age,2) FROM customer OrDER BY age;



--CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP,AGE
/*
CURRENT_DATE function returns the current date.
CURRENT_TIME function returns the current time with the time zone.
CURRENT_TIMESTAMP function returns the current date and time with the time zone.

•The CURRENT_DATE function will return the current date as a 'YYYY MM DD' format.
•CURRENT_TIME function will return the current time of day as a 'HH:MM:SS.GMT+TZ '
•The CURRENT_TIMESTAMP function will return the current date as a 'YYYY MM DD HH:MM:SS.GMT+TZ '

*/






--=================================================================================================
--SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIME(1), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP(1),AGE
--=================================================================================================

--AGE
--AGE function returns the number of years, months, and days between two dates.

--Syntax
--age( [date1,] date2 )
--If date1 is NOT provided, current date will be used

SELECT age('2014 04 25 ', '2014 01 01');
			 
SELECT order_line , order_date , ship_date , age(ship_date , order_date ) as time_taken
FROM sales
ORDER BY time_taken DESC;



--EXTRACT
--https://www.postgresqltutorial.com/postgresql-extract/

--EXTRACT function extracts parts from a date

--Syntax: EXTRACT( ‘unit’ from ‘date’ )
SELECT EXTRACT(DAY FROM TIMESTAMP '2016-12-31 13:30:15');
SELECT EXTRACT(HOUR FROM TIMESTAMP '2016-12-31 13:30:15');
SELECT EXTRACT(MINUTE FROM TIMESTAMP '2016-12-31 13:30:15');


--EPOCH gives The number of seconds
SELECT EXTRACT(EPOCH FROM TIMESTAMP '2016-12-31 13:30:15');

SELECT order_line, EXTRACT(EPOCH FROM AGE(ship_date, order_date)) FROM sales;



--REGEX
--https://www.regular-expressions.info/email.html

SELECT * FROM customer 
WHERE customer_name ~*'^a+[a-z\s]+$';


SELECT * FROM customer 
WHERE customer_name ~* '^(a|b|c|d )+[a-z\s]+$';

SELECT * FROM customer 
WHERE customer_name ~* '^(a|b|c|d)[a-z]{3}\s[a-z]{4}$';

--Valid Email Address Matching
SELECT * FROM customer 
WHERE customer_name ~* '[a-z0-9\.\-\_]+@[a-z0-9\-]+\.[a-z]{2,5}'




--REGEX
--https://www.regular-expressions.info/email.html

--[~*] -> removes case sensitiveness
SELECT * FROM customer 
WHERE customer_name ~*'^a+[a-z\s]+$';


--customer starting with a|b|c|d folowed by any character between [a-z] permitted to repeat itself 
--folowed by space and another set characters strings [a-z\s] which is last name in this case
SELECT * FROM customer 
WHERE customer_name ~* '^(a|b|c|d )+[a-z\s]+$';

--customer starting with a|b|c|d folowed by any character between [a-z] permitted to repeat itself up to 3 times
--folowed by space and another set of 4 characters strings [a-z] which is last name in this case
SELECT * FROM customer 
WHERE customer_name ~* '^(a|b|c|d)[a-z]{3}\s[a-z]{4}$';

--Valid Email Address Matching AFTER DOT (.) ONLY 2-5 character are permitted
SELECT * FROM customer 
WHERE customer_name ~* '[a-z0-9\.\-\_]+@[a-z0-9\-]+\.[a-z]{2,5}'