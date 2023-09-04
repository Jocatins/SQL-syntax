-- Equal-height binning with the ntile function

-- Equal-height binning is very common, so PostgreSQL includes a special function to assign to groups at a given size.

-- To assign students to 3 groups, we can use the ntile function:

SELECT
  grade,
  ntile(3) OVER (ORDER BY grade) AS tile
FROM
  grades
ORDER BY
  tile;

--   The query uses the ordered-set window function ntile. It accepts the number of groups and assigns each row a group based on the order provided to ORDER BY.

-- To get a better sense of the tiles the function produced, we can summarize the results:

WITH grades_with_tiles AS (
  SELECT
    grade,
    ntile(3) OVER (ORDER BY grade) AS tile
  FROM
    grades
)
SELECT
  tile,
  MIN(grade) AS min_grade,
  MAX(grade) AS max_grade,
  COUNT(grade) AS students
FROM
  grades_with_tiles
GROUP BY
  1
ORDER BY 
  1;

--   The results are identical to the ones we got using the arithmetic approach. The main difference between using the arithmetic approach and the function ntile, is the input:

-- Using the ntile function, we provide the number of groups–-in our case 3.

-- Using the arithmetic approach, we provide the size of the group–-in our case 10.

-- Equal-height binning with repeating values

--  if we want to ensure students with the same grade are in the same group, we need to make a small adjustment to our approach.

-- To assign the same rank to students with similar grades, we can use one of the ranking functions, rank or dense_rank. 
-- The difference between the two is in how they handle duplicate values. 
-- The dense_rank function will produce consecutive ranks, while rank produces ranking with gaps:

-- In the arithmetic approach, we assign buckets based on rank. 
-- For the approach to work, we expect the highest rank to be the number of rows in the table. 
-- This is why for equal-height binning, the rank function is more appropriate.

-- To demonstrate, we adjust the arithmetic approach to use the rank function instead of row_number:

WITH grades_with_groups AS (
  SELECT
    grade,
    (rank() OVER (ORDER BY grade) - 1) / 10 AS group_
  FROM
    grades
)
SELECT
  group_,
  MIN(grade) AS min_grade,
  MAX(grade) AS max_grade,
  COUNT(grade) AS students
FROM
  grades_with_groups
GROUP BY
  1
ORDER BY 
  1;