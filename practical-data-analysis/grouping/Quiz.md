1 - (True or False) The expression COUNT(CASE WHEN role = 'Developer' THEN 1 ELSE NULL END) is equivalent to COUNT(\*) FILTER (WHERE role = 'Developer').
True

Both expressions will count the number of rows where the role is Developer.

2 - (True or False) The expression COUNT(CASE WHEN role = 'Developer' THEN 1 ELSE NULL END) is equivalent to SUM(CASE WHEN role = 'Developer' THEN 1 ELSE 0 END).
True

Both expressions will count the number of rows where the role is Developer. The expression using COUNT uses the fact NULL values are ignored, while the expression using SUM uses 0 instead when the condition is not met.

3- (True or False) The ROLLUP and CUBE can be expressed using GROUPING SETS.
True

4 - (True or False) To identify the rows with the subtotal results produced by ROLLUP, CUBE, or GROUPING SETS, we need to look for rows with missing values (NULL).
False

To identify subtotals in query results it’s best to use the GROUPING function.
