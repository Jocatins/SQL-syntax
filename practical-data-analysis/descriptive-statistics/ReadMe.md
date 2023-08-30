A series is a one-dimensional list of values

-   For example, we can use the VALUES to produce a simple series:

SELECT \* FROM (VALUES (1), (2), (3)) AS t(n)

# Counting rows

-   The first thing we always want to know is how many rows are there. In SQL, we can answer this question with the aggregate function COUNT:

WITH series AS (
SELECT _ FROM (VALUES (1), (2), (3)) AS t(n)
)
SELECT
COUNT(_)
FROM
series;

# Minimum and maximum values

-   To find the range of values in a series using SQL, we can use the aggregate functions MIN and MAX:

WITH series AS (
SELECT \* FROM (VALUES (1), (2), (3)) AS t(n)
)
SELECT
MIN(n),
MAX(n)
FROM
series;

# Average and variance

-   Another useful descriptive statistic is the average value of the series:

WITH series AS (
SELECT \* FROM (VALUES (1), (2), (3)) AS t(n)
)
SELECT
AVG(n)
FROM
series;

-   We can calculate the variance and the standard deviation of the series:

WITH series AS (
SELECT \* FROM (VALUES (1), (2), (3)) AS t(n)
)
SELECT
AVG(n),
VARIANCE(n),
STDDEV(n)
FROM
series;

-   The variance gives us a sense of the distribution of the data around the mean. A small variance means the data is distributed close to the mean.

# Median

An alternative measure that is considered more robust than a mean, is a median.

A median is a value that occurs exactly in the middle of a dataset that is arranged in ascending order. To calculate the median in SQL, we use the percentile_cont function.

The percentile_cont function is an ordered-set aggregate function—it operates with respect to some order. The order is determined by the WITHIN GROUP (ORDER BY column) clause. To calculate the median of a series we can use percentile_cont:

WITH series AS (
SELECT \* FROM (VALUES (1), (2), (3)) AS t(n)
)
SELECT
percentile_cont(0.5) WITHIN GROUP (ORDER BY n)
FROM
series;

<!-- Now, we'll add the extreme value to the series to check how the median and the average change: -->

SELECT
avg(n),
percentile_cont(0.5) WITHIN GROUP (ORDER BY n) AS median
FROM (
VALUES (1), (2), (3), (4), (1000)
) AS t(n);

The median will be 3

-   To calculate the discrete percentile in PostgreSQL, we can use the percentile_disc function. To demonstrate the difference between continuous and discrete percentile, consider the following example:

SELECT
percentile_cont(0.5) WITHIN GROUP (ORDER BY n) AS median_continuous,
percentile_disc(0.5) WITHIN GROUP (ORDER BY n) AS median_discrete
FROM
(VALUES (1), (2), (3), (4)) AS t(n);

    the median_continuous, --> 2.5
    the median_discrete,   -- > 2

-   The continuous 0.5 percentile is 2.5. This value does not exist in the series. The discrete 0.5 percentile however is 2, which is not exactly in the middle, but it is the first value in the series, which fulfills the definition of a median value.

# Percentiles

The median, however, is just a special case of the 50% percentile. Using the same functions, we can also calculate other percentiles.

SELECT
percentile_disc(0.25) WITHIN GROUP (ORDER BY n) AS percentile_25
FROM
(VALUES (1), (2), (3), (4)) AS t(n);

-   We can also use the percentile functions to calculate the minimum and the maximum values in the series:

SELECT
min(n),
max(n),
percentile_disc(array[0, 1]) WITHIN GROUP (ORDER BY n) AS percentiles
FROM
(VALUES (1), (2), (3), (4)) AS t(n);

Output

min max percentiles
1 4 {1,4}

# Most frequent value

-   We now know that values can repeat themselves, so we want to know what is the most common value. For that, we can use the MODE function:

SELECT
MODE() WITHIN GROUP (ORDER BY fruit) AS most_common_fruit
FROM (
VALUES ('orange'), ('apple'), ('banana'), ('apple')
) AS t(fruit);

# Handling missing values

Most database engines use the special value NULL to represent missing values:

let’s see how the function COUNT treats missing values:

SELECT
COUNT(\*) AS count_rows,
COUNT(fruit) AS count_fruit
FROM (
VALUES ('orange'), ('apple'), ('banana'), ('apple'), (null), (null)
) AS t(fruit);
