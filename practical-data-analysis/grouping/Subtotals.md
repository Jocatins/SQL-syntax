Another useful technique to analyze data is producing subtotals. Let’s add multiple aggregation levels in the same query.

Consider this query that counts the number of employees in each department and role:

SELECT
role,
department,
COUNT(\*) as employees
FROM
emp
GROUP BY
role,
department;

-   This query is helpful in answering questions like how many developers are in the R&D department, or how many managers are in the Sales department. However, if we want to get the number of employees in the R&D department across all roles, this query is not very useful. We would have to manually sum the rows from the results, or write another query to answer this specific question.

# The ROLLUP query

-   If we want to include the number of employees in each department across all roles, we need the results at a higher level than the query currently provides. The query aggregates combinations of department and role, but we want aggregates at the role level alone. For example, to get the number of all the employees in the R&D department, we can sum the results of the rows in the output for the R&D department. This is often called “rolling up.”

-   To include the number of employees in each department across all roles, we can instruct the database to roll up the results of this field:

SELECT
department,
role,
COUNT(\*) AS employees
FROM
emp
GROUP BY
department,
ROLLUP(role)
ORDER BY
1, 2;

-   To add a subtotal for each department, we tell the database to roll up the results of the role field.

-   If instead of getting the number of employees in each department we want the number of employees in each role across all departments, we can use the following query:

SELECT
department,
role,
COUNT(\*) AS employees
FROM
emp
GROUP BY
ROLLUP(department),
role
ORDER BY
1, 2;

# Grand total

-   So far, we used ROLLUP on just one field to include subtotals, but we can also roll up multiple fields and include the grand total:

SELECT
department,
role,
COUNT(\*) AS employees
FROM
emp
GROUP BY
ROLLUP(department, role)
ORDER BY
1, 2;

# Cube

-   Using ROLLUP we can produce all the subtotals by manually listing all possible column combinations, but there is an easier way to produce all possible combinations, using CUBE:

SELECT
department,
role,
COUNT(\*) AS employees
FROM
emp
GROUP BY
CUBE(role, department)
ORDER BY
1, 2;

    Using CUBE, the database generates all the possible subtotals:

# Grouping sets

-   Both CUBE and ROLLUP can be expressed using GROUPING SETS. For example, we can produce an output similar to CUBE using GROUPING SETS:

SELECT
department,
role,
COUNT(\*)
FROM
emp
GROUP BY GROUPING SETS (
(), -- <-- Grand total
(role), -- <-- Subtotal by role
(department), -- <-- Subtotal by department
(role, department) -- <-- No aggregation, the row itself
);

-   Using GROUPING SETS we can control which subtotals are included in the output. The query above generates all possible combinations, so it’s equivalent to CUBE.

# Identify the grouping level

-   When using ROLLUP, CUBE, or GROUPING SETS to include subtotals, it is sometimes necessary to identify what is the grouping level of each specific row. So far, we identified the subtotals by spotting rows with missing values, but there is a safer way, using the GROUPING function:

SELECT
department,
role,
COUNT(\*),
GROUPING(department) AS department_subtotal,
GROUPING(department, role) AS grand_total
FROM
emp
GROUP BY
ROLLUP(department),
role;

-   Using the GROUPING function we can identify what level of grouping each row includes.
