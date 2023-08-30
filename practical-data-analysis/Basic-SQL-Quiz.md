1 - Which of the following SQL clauses can be used to filter the results of an aggregate function (such as MAX / MIN / SUM / COUNT)?

The HAVING clause is executed after GROUP BY, and therefore can be used to filter the results of aggregate expressions

2- Are common table expressions evaluated the same way as subqueries?
Yes, unless MATERIALIZED is used in the common table expression.

Common table expressions are not materialized by default, similar to subqueries. However, when MATERIALIZED, the CTE will act as an optimization fence, and the CTE will be evaluated separately from the main query.

3- What would be the result of the following SQL?
The SQL will fail.

The number of columns in all queries used in UNION ALL must be the same. The first query in this case has 3 columns, and the second query just 2.

4 - Which of the following SQL commands will produce a random integer between 5 and 10 (inclusive)?
SELECT 5 + floor(random() \* 6)

The expression floor(random() \* 6) will produce numbers between 0 and 5. Adding 5, and the result will be in the range of 5 to 10.

5 - Which of the following queries produce an evenly distributed random integer between 0 and 9?

SELECT floor(random() \* 10)

SELECT ceil(random() \* 10) - 1

6 - Which of the following sampling methods will produce exactly 100 rows from a table with 1000 rows?

ORDER BY random() LIMIT 100

7 - Which sampling method is considered the fastest?

The SYSTEM sampling method works by sampling blocks from the table. This is why it is considered the fastest sampling method.

8 -
Given a users table with 100 rows, how many rows will the following query return?

SELECT COUNT(\*)
FROM users TABLESAMPLE BERNOULLI(5) REPEATABLE (1010)
WHERE id NOT IN (
SELECT id
FROM users TABLESAMPLE BERNOULLI(30) REPEATABLE (1010)
);

Both the inner and the outer query use the same seed value (1010). The sample of the outer query is therefore guaranteed to be contained within the sample of the inner query. This is why the query will return no results.
