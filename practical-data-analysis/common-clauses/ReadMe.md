SELECT <expressions>
FROM <tables>
JOIN <to other table> ON <join condition>
WHERE <predicates>
GROUP BY <expressions>
HAVING <predicate>
ORDER BY <expressions>
LIMIT <number of rows>

# Here is a quick overview of each clause:

SELECT: It lists the columns and expressions to appear in the query result output.

In PostgreSQL only the SELECT clause is mandatory.

FROM: It lists the tables to get data from.

JOIN: It describes the relations between tables in the FROM clause.

A query can access data from multiple related tables. For example, a product table can have a category_id column referencing a category table. Using the JOIN clause, we can describe how these tables are related.

WHERE: It filters data based on a condition.

GROUP BY: It lists columns and expressions to categorize the results. This clause is only necessary if the output of the query is grouped. Otherwise, you can omit this clause.

HAVING: It filters results based on the result of an aggregation. To use this clause you must also use the GROUP BY clause.

ORDER BY: It lists columns and expressions to sort the results by.

LIMIT: It restricts the number of rows in the results.

# Order of execution

-   The SQL clauses described above are written in that particular order, but surprisingly enough, the database is not executing them in this order.

-   Instead, the database executes SQL queries in the following order:

FROM: It finds the tables to access and apply joins in the JOIN clause.
WHERE: It applies predicates and filters the results.
SELECT: It finds columns and evaluates expressions.
GROUP BY: It groups the data and calculates aggregates.
HAVING: It applies conditions on the calculated aggregates from the previous step.
ORDER BY: It’s ordering the result set.
LIMIT: It restricts the number of rows in the result.

-   Knowing the order in which the database executes SQL can be helpful for understanding and remembering what each clause does.
