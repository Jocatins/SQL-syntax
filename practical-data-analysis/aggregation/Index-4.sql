# Ranking

-   Ranking is an extremely common task. Ranking employees by performance, products by popularity, or students by score, are all different ways to use ranking.

# Row numbers

-   The most basic form of ranking is adding a row number to each row. In PostgreSQL, we can add row numbers in a specific sort order using the ROW_NUMBER window function:

SELECT
  *,
  ROW_NUMBER() OVER (PARTITION BY city ORDER BY temperature) AS rn
FROM
  temperatures
ORDER BY
  city,
  rn;
--  The window function, ROW_NUMBER, generates row numbers for each group of rows with the same city. To rank rows according to the temperature, we use ORDER BY temperature in ascending order. As a result, the coldest day in each city will be ranked number 1, and so on.

-- Rank

--  Let's try to write a similar query for just LA, but this time we'll rank the rows from hottest to coolest:

SELECT
  *,
  ROW_NUMBER() OVER (PARTITION BY city ORDER BY temperature desc) AS rn
FROM
  temperatures
WHERE
  city = 'LA'
ORDER BY
  rn;

--  To rank rows from hottest to coldest, we used ORDER BY temperature DESC to change the sort order to descending.

--   Notice that we now have two days with the same temperature 27. The first row is ranked 1 and the second is 2. This poses two problems:

--   The sort order is not deterministic: The sort order is not unique, so the query can produce results in an unpredictable order. In this case, we could have used ORDER BY temperature, day to make the sort order deterministic in cases where the temperature is the same.

--   The sort order is not clear. We have more than one row with the same temperature, so which of these should be ranked first?

--   Note: It is a good practice to use a unique sorting key when ranking rows to make sure the results are deterministic.

-- For the reasons above, PostgreSQL provides additional ranking functions. Consider the same query, but instead of using ROW_NUMBER, we use the window function RANK:

SELECT
  *,
  RANK() OVER (PARTITION BY city ORDER BY temperature desc) AS rn
FROM
  temperatures
WHERE
  city = 'LA'
ORDER BY
  rn;

--  The ranking is now different. Notice the first two rows. On both days the temperature is 27, and both rows are ranked 1.

-- The rows in the second group of days where the temperature is 25 are all ranked 3. The ranking is 3 because the first group of rows has two rows in it, so ranking 2 is skipped. In this context, the rankings we skipped are called "gaps."

-- Ranking without gaps

--   To produce a ranking without gaps, PostgreSQL provides the function DENSE_RANK:

SELECT
  *,
  DENSE_RANK() OVER (PARTITION BY city ORDER BY temperature desc) AS rn
FROM
  temperatures
WHERE
  city = 'LA'
ORDER BY
  rn;

--   The DENSE_RANK function also assigns the same ranking to similar values, but it will not have gaps in the ranking. Notice that the second group of days where the temperature is 25, are all ranked 2 and not 3.

--  Here is a query that demonstrates the differences between ROW_NUMBER, RANK, and DENSE_RANK:

SELECT
  *,
  ROW_NUMBER() OVER (PARTITION BY city ORDER BY temperature desc) AS row_number_,
  RANK() OVER (PARTITION BY city ORDER BY temperature desc) AS rank_,
  DENSE_RANK() OVER (PARTITION BY city ORDER BY temperature desc) AS dense_rank_
FROM
  temperatures
WHERE
  city = 'LA'
ORDER BY
  temperature DESC,
  day;
