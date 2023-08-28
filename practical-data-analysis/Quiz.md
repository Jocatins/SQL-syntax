 <!-- A date dimension is a table that stores dates and related attributes, which we can use to analyze data across different periods. -->

Produce a date dimension with the following requirements:

Daily date dimension for a period of 10 years, between 2015-01-01 until 2024-12-31.
The date dimension will include the following columns:
day: For example, ‘2021-05-17.’
month: Name of month. For example, “May.”
year: 4-digit year, such as “2021.”
quarter: The quarter number prefixed with “Q,” such as “Q2.”
day_of_week: The name of the day of the week, such as “Tuesday.”

-   Use generate_series to produce a list of dates as the basis for your query. Think about the value for the start, end date, and the step to produce an accurate range.
-   Use date formatting and date/time functions and operators to extract and format the date.

-   To produce a list of days in range use generate_series:

WITH days AS (
SELECT
day::date AS day
FROM
generate_series('2015-01-01', '2024-12-31', INTERVAL '1 days') AS t(day)
)
SELECT
day
FROM
days;

-   To extract the year from a date, you can use the EXTRACT function:

SELECT EXTRACT('year' FROM now());

-   To get the name of the month, you can use the date formatting TO_CHAR function:

SELECT TO_CHAR(now(), 'Month');

-   Here is a query to produce the date required date dimension:

WITH days AS (
SELECT
day::date AS day
FROM
generate_series('2015-01-01', '2024-12-31', INTERVAL '1 days') AS t(day)
)
SELECT
day,
to_char(day, 'Month') AS month,
date_part('year', day) AS year,
'Q' || date_part('quarter', day) AS quarter,
to_char(day, 'Day') AS day_of_week
FROM
days;

-   This query will produce a date dimension for 10 years.
