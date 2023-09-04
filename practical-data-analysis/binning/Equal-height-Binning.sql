-- Equal-height binning

-- Equal-height binning is used to create bins, or groups, with roughly the same number of objects. 
-- This type of binning is not very common for visualization, but it is useful for other purposes.

-- Given a table of student grades, say we want to divide the students into groups based on their grades. 
-- We want each group to have roughly the same number of students, and we want to group students of the same level, based on their grades.

-- First, let's get familiar with the grades table by producing descriptive data:

SELECT
  MIN(grade) AS min_grade,
  MAX(grade) AS max_grade,
  COUNT(grade) AS count_grade,
  COUNT(DISTINCT grade) AS distinct_grades
FROM
  grades;

--   We have 30 grades ranging from 24 to 100. There are only 25 distinct grades, meaning some students received similar grades.

-- To get started with equal-height binning we first need to determine how many buckets, or groups, we want to have. 
-- If, for example, we want to divide our 30 students into 3 groups, each group should have 10 students.

-- Equal-height binning using arithmetic

-- The first approach to equal-height binning is using simple arithmetic. 
-- To calculate the bucket for each grade, we rank students by their grades, divide the rank by the width of the bucket, and round down the result.

-- Fortunately for us, PostgreSQL implements integer division—dividing an integer by another integer truncates the result. 
-- Consider the following example:

SELECT 10 / 4 AS result;

-- The result of dividing 10 by 4 is 2.5. However, since both values are integers, the fraction part 0.5 is discarded and the result of the expression is 2.

-- Integer division can come in very handy in our case. If we rank the students based on their grades, 
-- we can divide the rank by the size of the group and get the group number.

-- To demonstrate this technique, we add a rank to each student based on their grade:

SELECT
  grade,
  row_number() OVER (ORDER BY grade) AS rn
FROM
  grades
ORDER BY 
  2;

--   We use the window function row_number to assign a row number to each student based on their grade. 
-- The student with the lowest grade (24) is ranked 1, and the student with the highest score (100) is ranked 30, the number of rows in the table.

-- Next, we divide the row number by 10, the size of the group, to get the group number for each student:

SELECT
  grade,
  row_number() OVER (ORDER BY grade) AS rn,
  (row_number() OVER (ORDER BY grade) - 1) / 10 AS grp
FROM
  grades
ORDER BY 
  2;

--   Both the rank and the size of the group are integers, so we got exactly 3 values: 0, 1, and 2.

-- Finally, we summarize to query to get a better sense of each group:

WITH grades_with_groups AS (
  SELECT
    grade,
    (row_number() OVER (ORDER BY grade) - 1) / 10 AS group_
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

--   The query shows we now have 3 groups, with 10 students in each group. The first group, for example, includes students with grades 24 until 68.
