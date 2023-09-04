-   In many types of analysis, it is often necessary to compare a row to the next or previous rows. For example, calculating the change in a stock price, calculating the increase or decrease of a certain measure, and so on. Window functions are a great fit for this type of analysis.

-   Given our temperature data set, say we want to find the temperature change on each day. To do that, for each day, we need to find the temperature of the previous day:

SELECT
t_outer.\*,
(
-- Find the last temperature in the same city
SELECT
temperature
FROM
temperatures t_inner  
 WHERE
-- Same city
t_inner.city = t_outer.city
-- Days prior to "outer" current date
AND t_inner.day < t_outer.day
ORDER BY
t_inner.day DESC
LIMIT
1
) previous_temperature
FROM
temperatures t_outer
ORDER BY
t_outer.city,
t_outer.day;

-   The query uses a subquery to find the previous temperature in each city on each day. The subquery finds all the temperatures in the same city in days prior to the current row in the outer query. It then sorts the results by the date in descending order and takes the first result. This is how we get the previous temperature in the same city, for each row.

-   Using a subquery in the SELECT clause is usually not the most efficient approach because it forces the database to execute the inner query for each row in the outer table. If the outer table is very large, this can be very resource consuming.

# The LAG function

-   We can use the LAG window function to find the previous temperature in the same city

SELECT
\*,
LAG(temperature) OVER (
PARTITION BY city
ORDER BY day
) as previous_temperature
FROM
temperatures
ORDER BY
city,
day;

-   This query now uses the window LAG function to get the previous temperature in the same city for each row. Just like the other aggregate expressions that we've seen, we used PARTITION by city to process rows in the same city, and ORDER BY day to determine the order rows in the group are evaluated.

-   The query is now much simpler and the database is able to execute it in a much more efficient way.

-   If we want to get the temperature difference between each day and the previous day, we can use the following expression:

SELECT
\*,
temperature - LAG(temperature) OVER (
PARTITION BY city
ORDER BY day
) as temperature_diff
FROM
temperatures
ORDER BY
city,
day;

-   To find the temperature difference, the query subtracts the previous temperature from the current temperature.

# The LEAD function

-   Another useful window function is LEAD. It works just like the LAG function, but it gets the next rows in the group instead of the previous rows.

-   Consider the following query to find the temperature the next day in the same city

SELECT
\*,
LEAD(temperature) OVER (
PARTITION BY city
ORDER BY day
) as next_day_temperature
FROM
temperatures
ORDER BY
city,
day;

# Previous and next offset

-   So far, we've used the LEAD and LAG functions to get the next and previous row. However, both functions have an optional argument to determine how many rows back or ahead to look. The default is 1, which is the previous or next row.

-   Consider the following example to find the temperature in the same city, last week:

SELECT
\*,
LAG(temperature, 7) OVER (
PARTITION BY city
ORDER BY day
) as temperature_last_week
FROM
temperatures
ORDER BY
city,
day;

-   The dataset only includes 8 rows for each city, but we can see that the last row, 2021-01-08 contains the temperature 7 days before that date, 2021-01-01.

-   Here is a fun fact, using negative offsets, we can implement the LAG function using the LEAD function and vice versa. Consider the following expressions to find the temperature of the previous day in each city:

SELECT
\*,

LAG(temperature, 1) OVER (
PARTITION BY city
ORDER BY day
) as previous_temperature_using_lag,

LEAD(temperature, -1) OVER (
PARTITION BY city
ORDER BY day
) as previous_temperature_using_lead_with_negavite_offset
FROM
temperatures
ORDER BY
city,
day;

# Handling missing values

-   When we use the LAG function to find previous rows, the first row in each group is always NULL. This is because the first row has no previous rows. If for some reason, we want to provide a default value, we can use the third argument to the LAG and LEAD functions:

SELECT
\*,
LAG(temperature, 1, 0) OVER (
PARTITION BY city
ORDER BY day
) as previous_temperature
FROM
temperatures
ORDER BY
city,
day;

-   We set a default value 0 using the third argument to the LAG function, and we can see it was used in the first row in each group.
