-   To count the number of employees in each department, we can use the GROUP BY clause:

SELECT
department,
COUNT(\*) AS number_of_employees
FROM
emp
GROUP BY
department;

-   To get the number of employees in each department, we added the department column to the GROUP BY clause. This tells the database that we want to group the results by the value in the department column. To count the number of employees in each department, we add the aggregate expression COUNT(\*).

-   Using GROUP BY, we are not restricted to just one aggregate expression. For example, in addition to the number of employees, we can also add the maximum and average salary in each department:

SELECT
department,
COUNT(\*) AS number_of_employees,
MAX(salary) AS max_salary,
AVG(salary) AS average_salary
FROM
emp
GROUP BY
department;

-   The query above demonstrates how to compute multiple aggregate expressions in a single query.

-   So far, we grouped employees only by their department, but we can also produce the report at the department and the role level:

SELECT
department,
role,
COUNT(\*) AS number_of_employees,
MAX(salary) AS max_salary,
AVG(salary) AS average_salary
FROM
emp
GROUP BY
department,
role;

# Using aliases and column position

-   In the queries we have written so far, we repeated the columns and expressions from the SELECT clause in the GROUP BY clause. This can be tedious, so in PostgreSQL, we can use the position of the columns instead:

SELECT
department,
role,
COUNT(\*) AS number_of_employees,
MAX(salary) AS max_salary,
AVG(salary) AS average_salary
FROM
emp
GROUP BY
1, 2

-   Notice how instead of repeating the column names department and role, we simply reference their position in the SELECT clause: 1 and 2.

-   In addition to referencing columns by their position, we can also reference columns by their alias. For example, say we want to count the number of employees by their initial (the first letter of their name).

-   Here is an expression to get the first letter of each employee's name:

SELECT name, substring(name, 1, 1) AS initial FROM emp;

-   Now, if we want to group by the initial, we can repeat the expression in the GROUP BY clause:

SELECT
substring(name, 1, 1) AS initial,
COUNT(\*)
FROM
emp
GROUP BY
substring(name, 1, 1);

Repeating the expression is not ideal. If we change the expression in the SELECT clause, we need to remember to also change it in the GROUP BY clause. This is fragile, and can potentially lead to mistakes down the road.

One way to avoid repeating the expression is to reference the column position as we did before or reference the column by its alias, initial:

SELECT
substring(name, 1, 1) AS initial,
COUNT(\*)
FROM
emp
GROUP BY
initial;

-   We can now safely change the expression without worrying about the GROUP BY clause.

# Filtering by aggregate expressions

-   When producing aggregate reports, we sometimes want to filter the result of the aggregate. For example, finding all departments with more than 3 employees or finding roles that pay on average more than 8K:

SELECT
role,
AVG(salary) as average_salary_for_role
FROM
emp
GROUP BY
role;

-   The query above computes the average salary by role. We can see that managers make 9250 on average, and developers make 7625. But, we only want to get the roles where the average salary is more than 8000.

Recall the actual order of SQL execution:

-   FROM

-   WHERE

-   SELECT

-   GROUP BY

-   HAVING

-   ORDER

-   LIMIT

Notice that SELECT and GROUP BY are executed after the WHERE clause. To filter based on the result of an aggregate expression, we need to use the HAVING clause instead:

SELECT
role,
AVG(salary) as average_salary_for_role
FROM
emp
GROUP BY
role
HAVING
AVG(salary) > 8000;

When we use HAVING, we can apply conditions to the results of an aggregate expression. In this case, we used HAVING to only include the roles that make more than 8000 on average. However, unlike GROUP BY and ORDER BY, we can't use aliases in the HAVING clause.

# Conditional aggregates with CASE

There is a certain way in which aggregate functions handle missing values. Functions like COUNT ignore NULL values. This behavior can potentially cause problems, but in this case, we can use this behavior to get the results we want.

If we want to include aggregates on different subsets of the data based on some condition, we can use a CASE expression:

SELECT
COUNT(CASE WHEN role = 'Manager' THEN 1 ELSE NULL END) as managers,
COUNT(CASE WHEN role != 'Manager' THEN 1 ELSE NULL END) as non_managers
FROM
emp;

-   This uses the fact that aggregate functions such as COUNT ignore NULL values
-   The main benefit of this approach is that the database can do it without having to scan the table multiple times. This can have a noticeable impact on query performance if the table is big.

# Conditional aggregates with FILTER

Using CASE is flexible, but it can be a bit tedious. Applying conditions on aggregates is so useful, that PostgreSQL includes special syntax for it:

SELECT
COUNT(\*) FILTER (WHERE role = 'Manager') AS managers,
COUNT(\*) FILTER (WHERE role != 'Manager') AS non_managers
FROM
emp;

-   This query is using the FILTER keyword to apply a condition to the rows that will be processed by the aggregate function. This syntax achieves the same result, but it is shorter and more readable.

# Producing pivot tables

-   Pivot tables are a technique to reshape data, shifting columns to rows and vice versa.

-   To demonstrate when a pivot table is useful, let’s say we want to check how many employees in each role we have in every department. We can start with a query that counts the number of employees by department and role:

SELECT
department,
role,
COUNT(\*) as employees
FROM
emp
GROUP BY
department,
role
ORDER BY
1, 2;

-   A more convenient way to view this data is to have one axis of the table the department, and on the other axis, the role. To reshape the data to this form we can use conditional expressions. First, using CASE:

SELECT
role,
SUM(CASE department WHEN 'R&D' THEN 1 ELSE 0 END) as "R&D",
SUM(CASE department WHEN 'Sales' THEN 1 ELSE 0 END) as "Sales"
FROM
emp
GROUP BY
role;

-   To make this query shorter, we can replace the CASE expressions with FILTER:

SELECT
role,
COUNT(_) FILTER (WHERE department = 'R&D') as "R&D",
COUNT(_) FILTER (WHERE department = 'Sales') as "Sales"
FROM
emp
GROUP BY
role;

-   The main drawback of this approach is that we need to know the values of at least one axis in advance. In this case, we have to provide the values of all the departments to calculate the conditional aggregates.
