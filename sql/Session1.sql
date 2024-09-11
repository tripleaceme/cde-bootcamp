### Limits
/*
Try it yourself below by writing a query that limits the response to only the first 15 rows and includes
the date, account_id, and channel fields in the web_events table.
*/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

### Order by
/*
Order by clause will allow you sort by date. It must appear after From and before Limit. Order by goes from
A-Z,lowest to higest, earliest to latest. (ascending order)
*/
SELECT *
FROM demo.orders
ORDER BY occurred_at
LIMIT 1000;

/* DESC is used  for descending order */
SELECT *
FROM demo.orders
ORDER BY occurred_at DESC
LIMIT 1000;

/* Write a query that displays the order ID, account ID, and total dollar amount for all the
 orders, sorted first by the account ID (in ascending order), and then by the total dollar amount
 (in descending order).*/
SELECT order_id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

/* Now write a query that again displays order ID, account ID, and total dollar amount for each
order, but this time sorted first by total dollar amount (in descending order), and then by
account ID (in ascending order). */
SELECT order_id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

/* Pulls the first 5 rows and all columns from the orders table that have a dollar amount of
gloss_amt_usd greater than or equal to 1000 */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500 */
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/* Filter the accounts table to include the company name, website, and the primary point of contact
(primary_poc) just for the Exxon Mobil company in the accounts table*/
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

##Arithmetic operators
/* Here we divide the standard paper dollar amount by the total order amount to find the standard paper
percent for the order, and use the AS keyword to name this new column "std_percent */
SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
FROM orders
LIMIT 10;

/* Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard
 paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields*/
 SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
 FROM orders
 LIMIT 10;

/* Write a query that finds the percentage of revenue that comes from poster paper for each order. You will
need to use only the columns that end with _usd. (Try to do this without using the total column.) Display
the id and account_id fields also */
SELECT id, account_id,  poster_amt_usd/(standard_amt_usd+gross_amt_usd+poster_amt_usd) AS post_percent
FROM orders
LIMIT 10;

##Logical operators
/* Use the accounts table to find- */
/* All the companies whose names start with 'C' */
SELECT names
FROM accounts
WHERE names LIKE 'C%';

/* All companies whose names contain the string 'one' somewhere in the name */
SELECT names
FROM accounts
WHERE names LIKE '%one%';

/* All companies whose names end with 's' */
SELECT names
FROM accounts
WHERE names LIKE '%s';

/* Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and
Nordstrom */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* Use the web_events table to find all information regarding individuals who were contacted via the channel
of organic or adwords */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/* Use the accounts table to find the account name, primary poc, and sales rep id for all stores except
Walmart, Target, and Nordstrom */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');


/* Use the accounts table to find: */
/* All the companies whose names do not start with 'C' */
SELECT names
FROM accounts
WHERE names NOT LIKE 'C%';

/* All companies whose names do not contain the string 'one' somewhere in the name */
SELECT names
FROM accounts
WHERE names NOT LIKE '%one%';

/* All companies whose names do not end with 's' */
SELECT names
FROM accounts
WHERE names NOT LIKE '%s';

/* Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and
the gloss_qty is 0 */
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/* Using the accounts table, find all the companies whose names do not start with 'C' and end with 's' */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND names LIKE '%s';

/* When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not?
Figure out the answer to this important question by writing a query that displays the order date and
gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the
BETWEEN operator included the begin and end values or not */
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

/* You should notice that there are a number of rows in the output of this query where the gloss_qty values
are 24 or 29. So the answer to the question is that yes, the BETWEEN operator in SQL is inclusive; that is,
the endpoint values are included. So the BETWEEN statement in this query is equivalent to having written
"WHERE gloss_qty >= 24 AND gloss_qty <= 29." */

/* Use the web_events table to find all information regarding individuals who were contacted via the
organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest */
SELECT *
FROM web_events
WHERE channels IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'

ORDER BY occurred_at DESC;



/* Use the web_events table to find all information regarding individuals who were contacted via any method
except using organic or adwords methods. */



/* You will notice that using BETWEEN is tricky for dates! While BETWEEN is generally inclusive of
endpoints, it assumes the time is at 00:00:00 (i.e. midnight) for dates. This is the reason why we set the
right-side endpoint of the period at '2017-01-01' */



/* Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id
field in the resulting table */



/* Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or
poster_qty is over 1000 */



/* Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or
'Ana', but it doesn't contain 'eana' */




/*
        SQL JOINS
*/

/* Try pulling all the data from the accounts table, and all the data from the orders table */
SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;
/* Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the
primary_poc from the accounts table */
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty,
       accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.accounts_id = accounts.id;
/* Provide a table for all web_events associated with account name of Walmart. There should be three
columns. Be sure to include the primary_poc, time of the event, and the channel for each event.
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen */
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';



/* Provide a table that provides the region for each sales_rep along with their associated accounts. Your
final table should include three columns: the region name, the sales rep name, and the account name. Sort
the accounts alphabetically (A-Z) according to account name */