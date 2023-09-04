# Comparing Missing Values

-   Missing data in SQL is represented by the special value NULL. We already know that some functions, such as aggregate functions, handle NULL values differently. For example:

SELECT
COUNT(\*) AS count_rows,
COUNT(value) AS count_values
FROM (VALUES
(1),
(null)
) AS t(value);

Output
count_rows | 2
count_values | 1

the expression COUNT(value) ignored the NULL value in the column value, and the result was 1.

-   We can't use the equality comparison operator, =, to check if a certain value is NULL. To check if a value is NULL, we need to use the IS operator instead:

-   When we use the equality operator in the expression NULL = NULL, the result is not True, it is NULL. When we use the IS operator, the result of the expression NULL IS NULL is True.

# Using the IS DISTINCT FROM operator

-   Comparing nullable values and columns can be tricky. If we use the equality operator we may get NULL as a result. To safely compare NULL values for equality, SQL offers the IS DISTINCT FROM operator:

SELECT
a,
b,
a = b as equal,
a IS DISTINCT FROM b AS is_distinct_from
FROM (VALUES
(1, 1),
(1, 2),
(1, NULL),
(NULL, NULL)
) AS t(a, b);

-   The query illustrates the differences between the equality operator and IS DISTINCT FROM. When a and b are not NULL, the equality and IS DISTINCT FROM are returning the same result. However, when one or both values are NULL, the equality operator evaluates to NULL, but IS DISTINCT FROM returns the result as if we used IS.

<!-- Note: When comparing nullable columns, it's safer to use IS DISTINCT FROM or IS NOT DISTINCT FROM. -->

-   The IS DISTINCT FROM operator has an opposite operator IS NOT DISTINCT FROM:

SELECT
a,
b,
a IS NOT DISTINCT FROM b as is_not_distinct_from,
a IS DISTINCT FROM b AS is_distinct_from
FROM (VALUES
(1, 1),
(1, 2),
(1, NULL),
(NULL, NULL)
) AS t(a, b);
