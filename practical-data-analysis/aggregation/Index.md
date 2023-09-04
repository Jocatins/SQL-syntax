# Simple aggregation

-   Let's say we want to produce a report showing the difference between each day, and the hottest day ever in the same city. Using MAX, we can find the maximum temperature in all cities, at all times:

SELECT
MAX(temperature)
FROM
temperatures
;

-   In the result, we get only one row—the hottest day in all cities at all times. To compare each day with the hottest day in the same city, we need to add the city to the GROUP BY clause:

SELECT
city,
MAX(temperature)
FROM
temperatures
GROUP BY
city;

-   Using GROUP BY we defined two groups—one for each distinct value in the column city. The database then calculated the maximum temperature for each group, and we got two rows in the result with the hottest temperature in each city.

-   At this point, we might consider using the aggregate result and the temperature at each row to calculate the difference, but if we try it, it will fail:

SELECT
city,
temperature - MAX(temperature) as diff_from_hottest
FROM
temperatures
GROUP BY
city;

-   The query failed because if we want to use the temperature and MAX(temperature) in the same expression, we must add temperature to the GROUP BY clause. However, if we do that, we won't be able to get the maximum temperature per city. Using GROUP BY we have expressions with both aggregate and non-aggregate.

-   Another approach is to join the results of the aggregate query to the temperature table:

WITH hottest AS (
SELECT
city,
MAX(temperature) as temperature
FROM
temperatures
GROUP BY
city
)
SELECT
t.\*,
h.temperature as hottest_temperature,
t.temperature - h.temperature AS diff_from_hottest
FROM
temperatures t
JOIN hottest h ON t.city = h.city
ORDER BY
t.city,
t.day
;

-   We first pre-calculated the hottest temperature in each city and stored it in a common table expression called hottest. We then joined the results to the temperatures tables based on the city and calculated the difference between the temperature and the hottest temperature in the diff_from_hottest column.

-   This type of analysis, where each value is compared to an aggregate of a larger group of values, is very common. In the next sections, we are going to use aggregate expressions to produce the same results more easily.

# Aggregate expression with partition

-   Using aggregate expressions, we can calculate an aggregate over a group of rows without reducing the number of rows. For example, to add a column with the highest temperature in each city, we can use the following aggregate expression:

SELECT
\*,
MAX(temperature) OVER (PARTITION BY city) AS max_temperature_at_city
FROM
temperatures;

-   The results now include a max_temperature_at_city column with the maximum temperature in each city.

-   Adding the OVER() keyword to the aggregate MAX function, turns it into an aggregate expression. The result of the aggregate MAX(temperature) OVER (PARTITION BY city) expression is the maximum temperature in each city.

-   We use the PARTITION clause to tell the database what groups to use to calculate the aggregate expression, exactly like in the GROUP BY clause. In this case, we want a group for each city, so we partition it by the city column.

-   To finish off our report, we can add an expression to calculate the difference between the temperature and the hottest temperature using our aggregate expression:

SELECT
\*,
temperature - MAX(temperature) OVER (PARTITION BY city) AS diff_from_hottest
FROM
temperatures;

# Multiple aggregate expressions

-   A single query can include multiple aggregate expressions for different groups. For example, we can have a single query with the hottest day in each city—the coldest day in each city, and the hottest and coldest day across all cities:

SELECT
\*,
MAX(temperature) OVER () AS max_temperature,
MIN(temperature) OVER () AS min_temperature,
MAX(temperature) OVER (PARTITION BY city) AS max_temperature_in_city,
MIN(temperature) OVER (PARTITION BY city) AS min_temperature_in_city
FROM
temperatures;
