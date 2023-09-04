# Overview#

-   The PARTITION clause in an aggregate expression can calculate the difference between the temperature on each day and the hottest day ever in the same city:

# Order of rows in a partition

-   To compare each temperature to the maximum temperature in the same city before that date, we need to add another element to our group. So far, we used the PARTITION clause to tell the databases how to group the data. Now, we want to provide order as well:

SELECT
\*,
MAX(temperature) OVER (
PARTITION BY city ORDER BY day
) AS hottest_day_so_far
FROM
temperatures
ORDER BY
city,
day;

-   To introduce order to the aggregate expression, we added the ORDER BY clause in addition to the PARTITION. The aggregate expression will now calculate the aggregate in that order. In our case, we sorted the results by day, so at every row, the aggregate will calculate the maximum temperature within the group, until that day.

-   If we execute the query and inspect the results, we can see that in LA for example, until the 2021-01-04 the hottest temperature was 22. On 2021-01-05, the temperature was 25, which is greater than the previous maximum, 22. On 2021-01-06 the temperature was 27, which remained the maximum temperature until the last day.

-   We use the result of the expression to calculate the difference between the temperature of each day and all past temperatures in the same city:

SELECT
\*,
temperature - MAX(temperature) OVER (
PARTITION BY city ORDER BY day
) AS diff_from_hottest_day_so_far
FROM
temperatures
ORDER BY
city,
day;

-   Another benefit to using only past data is stability. If we only look at past data, once we calculate a metric for a given day, we no longer have to update it. This is an important feature when planning ETL processes.

# Row frame

-   In the previous example, we saw how to control the order of rows in an aggregate expression group. We used the ORDER BY clause to calculate the hottest past temperature for each row, in each city.

-   At some point, our table can get pretty big, and we might want to restrict the look-back period. For example, what if we only want to get the hottest temperature in the past 3 days?

SELECT
\*,
MAX(temperature) OVER (
PARTITION BY city
ORDER BY day
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS hottest_day_last_3_days
FROM
temperatures
ORDER BY
city,
day;

-   To calculate the maximum temperature in each city in the past 3 days, we added a window frame clause to our aggregate expression. The frame defines how many rows before each row and how many rows after our current row, should be included in the calculation. Let’s break it down.

ROWS BETWEEN 2 PRECEDING

-   This part defines how many prior rows should be included. In our case, we want the last 2 rows.

AND CURRENT ROW

-   This part defines how we should handle the current row. In this case, we want to include the current row.

-   The aggregate expression will calculate the hottest temperature between the current rows and the two rows preceding it—a total of 3 rows.

-   If for example, we want to exclude the current row and look at the 3 prior rows instead, we can provide the following frame:

SELECT
\*,
MAX(temperature) OVER (
PARTITION BY city
ORDER BY day
ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
) AS hottest_day_last_3_days
FROM
temperatures
ORDER BY
city,
day;

-   Notice that the first row in each group is now NULL. The first row does not have any prior rows. Previously, when we included the current row in the frame, the result of the aggregate expression was the current day. Now that we exclude the current row, the group of values for the first row in the range is empty, and the result of the aggregate expression is NULL.

-   Frames are not restricted to past rows. We can define a frame that looks at the following rows as well. For example, we can calculate the hottest temperature for 3 days before and after each row:

SELECT
\*,
MAX(temperature) OVER (
PARTITION BY city
ORDER BY day
ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING
) AS hottest_3_days_before_and_after
FROM
temperatures
ORDER BY
city,
day;

# Range frame

-   Using RANGE we can define the frame using a logical condition rather than the number of rows.

RANGE BETWEEN '3 days' PRECEDING AND '1 days' PRECEDING
