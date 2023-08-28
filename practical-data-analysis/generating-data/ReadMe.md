# The UNION ALL command

To combine the results of multiple queries we can use UNION ALL:

SELECT 1 AS id, 'haki' AS name
UNION ALL
SELECT 2, 'benita'

-   To use UNION ALL, it’s important to keep the types and the number of columns similar in all of the concatenated queries

# The VALUES LIST keyword

-   In the previous example, we wanted to generate a list of rows from known values. We used bare SELECT clauses and concatenated the results using UNION ALL. Generating data from a known list of values is very common, so SQL offers a quicker way of doing that, using the VALUES keyword:

SELECT \* FROM (
VALUES
(1, 'haki'),
(2, 'benita')
) AS t(id, name)

-   Using the VALUES keyword you can provide a list of rows, and then define names and types using a table alias list t(..). The t can be any name.

-   You might be familiar with the VALUES clause from the INSERT command:

INSERT INTO t VALUES (1, 'haki'), (s, 'benita');

-   Just like in an INSERT command, we can use the VALUES keyword to generate what’s called a “constants table.”

# The UNNEST function

-   To generate small sets of one-dimensional data, we can use a special PostgreSQL array function:

SELECT unnest(array[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) AS n

-   Using unnest is more restricting than VALUES because it can only produce a one dimensional table of the same data type.

# The GENERATE_SERIES function

Using unnest, we had to provide the function with an array of values. But what if we want to generate a data series?

PostgreSQL provides a table function called generate_series to do just that:

SELECT \* FROM generate_series(0, 5) AS t(n)

The function, generate_series accepts three arguments: start, stop, and step. In the example above, we did not specify a step, so the default 1 was used.

To set the names and the types of the output we once again used a table alias list as t(<col1>, <col2>, ...).

To generate a different series, we can provide a different step:

SELECT \* FROM generate_series(
0, -- start
10, -- stop
2 -- step
) AS t(n)

-   The function generate_series is not restricted just to integers, it can also be used for other types. One common examples is generating date ranges:

SELECT \*
FROM generate_series(
'2021-01-01 UTC'::timestamptz, -- start
'2021-01-02 UTC'::timestamptz, -- stop
interval '1 hour' -- step
) AS t(hh)

-   To generate a 24-hour range we provide generate_series with a start and end date, and set the step to a 1 hour interval. The step can be any valid interval, such as 1 minute, 5 minutes, or 2 hours. In this case, we want an hourly series so we use a 1 hour interval.

-   The output of the function depends on the input. If we provide integers, we get a range of integers. If we provide a timestamp, we get a range of timestamps

# The GENERATE_SERIES function with row numbers

The generate_series function is a table function. There is a little trick with table functions that allows us to include the row numbers in the output:

SELECT \*
FROM generate_series(
'2021-01-01'::timestamptz, -- start
'2021-01-02'::timestamptz, -- stop
interval '1 hour' -- step
) WITH ORDINALITY AS t(hh, n)

Using WITH ORDINALITY, the results now include another column with the row number. Using the table alias function t(...) we can provide these columns with names. In this case hh is for the timestamp, and n for the row number.
