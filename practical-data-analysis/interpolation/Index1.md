# Back Filling and Forward Filling

# Filling constant values

The most straightforward way to fill in missing data is to replace it with a constant value. To replace NULL values with a constant, we can use CASE:

SELECT
n,
v,
CASE WHEN v IS NULL THEN 'X' ELSE v END AS adjusted_value
FROM (VALUES
(1, 'A' ),
(2, 'B' ),
(3, null),
(4, 'D' ),
(5, null),
(6, null),
(7, 'G' )
) AS t(n, v);

-   The CASE expression returns the constant value X when the value in the column v is NULL.

-   Another way to replace NULL values with a constant value is to use the COALESCE function:

SELECT
n,
v,
COALESCE(v, 'X') AS adjusted_value
FROM (VALUES
(1, 'A' ),
(2, 'B' ),
(3, null),
(4, 'D' ),
(5, null),
(6, null),
(7, 'G' )
) AS t(n, v);

# Back filling

-   Filling missing data with a constant is not always an option. Sometimes, it makes more sense to replace missing data with the last known value.

-   For example, let's say we have a time series of temperatures with days and the temperature each day. In some of the rows, the temperature is missing, and we want to fill it with the last known temperature:

SELECT
t,
c,
COALESCE(c, LAG(c) OVER (ORDER BY t)) AS adjusted_c
FROM (VALUES
('2021-01-01'::date, 10),
('2021-01-02'::date, 12),
('2021-01-03'::date, null),
('2021-01-04'::date, 14),
('2021-01-05'::date, null),
('2021-01-06'::date, null),
('2021-01-07'::date, 18),
('2021-01-08'::date, 15)
) as t(t, c);

-   To find the last known temperature, we can use the window function LAG. We can see that using LAG works only as long as we only have one day of missing data. In these cases, LAG worked because the previous day had a value. However, when the data has more than one consecutive missing value, like on the 2021-01-06, LAG returns NULL.

Note: It's tempting to use LAG for back filling, but it will only work for single missing values. If we have more than one consecutive missing value, LAG will result in missing values.

-   Given that our time series can have more than one consecutive missing value, we can't use LAG. Instead, we can use a subquery:

WITH t AS (
SELECT \*
FROM (VALUES
('2021-01-01'::date, 10),
('2021-01-02'::date, 12),
('2021-01-03'::date, null),
('2021-01-04'::date, 14),
('2021-01-05'::date, null),
('2021-01-06'::date, null),
('2021-01-07'::date, 18),
('2021-01-08'::date, 15)
) as t(t, c)
)
SELECT
t,
c,
COALESCE(c, (
SELECT c
FROM t as t_inner
WHERE t_inner.t < t_outer.t
AND t_inner.c IS NOT NULL
ORDER BY t_inner.t DESC
LIMIT 1
)) AS adjusted_c
FROM
t AS t_outer;

-   For each row in the outer query, t_outer, the subquery looks for a previous row where the temperature is not NULL, and returns that temperature. We can use a subquery to fill in missing values even when there are multiple consecutive days without a temperature.

# Forward fill

Forward fill works very similarly to back filling, but the other way around. Instead of filling in missing data based on the last known value, we fill in missing data based on the next known data.

-   For example, instead of the last known temperature, we can fill in missing temperatures based on the next known temperature:

WITH t AS (
SELECT \*
FROM (VALUES
('2021-01-01'::date, 10),
('2021-01-02'::date, 12),
('2021-01-03'::date, null),
('2021-01-04'::date, 14),
('2021-01-05'::date, null),
('2021-01-06'::date, null),
('2021-01-07'::date, 18),
('2021-01-08'::date, 15)
) as t(t, c)
)
SELECT
t,
c,
COALESCE(c, (
SELECT c
FROM t as t_inner
WHERE t_inner.t > t_outer.t
AND t_inner.c IS NOT NULL
ORDER BY t_inner.t ASC
LIMIT 1
)) AS adjusted_c
FROM
t AS t_outer;

-   To adjust the subquery we used for back filling, all we had to do was to change the condition and the sort order.
