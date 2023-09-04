-- Binning or bucketing

-- It is a technique used to divide a series of values into ranges for analysis or visualization.

-- For each range, we calculate the frequency—the number of values from the series that fit in this range. The ranges are often referred to as bins, buckets, or groups.

-- To demonstrate different binning techniques, we are going to use a table with student grades:

CREATE TABLE grades (
  grade INT
);

INSERT INTO grades (grade) VALUES
  (24),
  (41), (45),
  (54), (55), (56),
  (61), (65), (62), (68),
  (71), (72), (71), (71), (74), (76), (72), (77),
  (82), (84), (82), (88), (89), (81), (82), 
  (90), (91), (94), (92),
  (100)
;

SELECT * FROM grades;

-- Custom binning

-- Custom binning is common for categorical data or discrete data with predetermined ranges.

-- For example, let's classify our grades by the letter grades A–F using predetermined ranges:

SELECT
  CASE
    WHEN grade < 60 THEN 'F'
    WHEN grade < 70 THEN 'D'
    WHEN grade < 80 THEN 'C'
    WHEN grade < 90 THEN 'B'
    ELSE 'A'
  END AS letter_grade,
  COUNT(*)
FROM
  grades
GROUP BY
  letter_grade
ORDER BY
  letter_grade;

--   To assign the letter grade to each grade, we use a CASE expression to classify

--  Custom binning using percentiles

-- In the American grading system, the letter grades are not calculated by predetermined ranges. Instead, the letter grades are calculated using percentiles. 
-- In other words, the letter grade is determined for each student based on the grades of all the other students.

-- First, calculate the percent rank of each grade:

SELECT 
  grade,
  percent_rank() OVER (ORDER BY grade) as percent_grade
FROM 
  grades
ORDER BY
  1;

--   The query uses the ordered-set window function, percent_rank, to calculate the percentage of each grade relative to all other grades. 
--   Notice that the lowest grade 24 has the percentile rank 0, and the highest grade 100 has a percentile rank of 1.

-- Next, use the percentiles we calculated to assign letter grades:

WITH grades_with_percent_grade AS (
  SELECT 
    grades.*,
    percent_rank() OVER (ORDER BY grade) as percent_grade
  FROM 
    grades
)
SELECT
  CASE
    WHEN percent_grade < 0.6 THEN 'F'
    WHEN percent_grade < 0.7 THEN 'D'
    WHEN percent_grade < 0.8 THEN 'C'
    WHEN percent_grade < 0.9 THEN 'B'
    ELSE 'A'
  END AS letter_grade,
  COUNT(*)
FROM
  grades_with_percent_grade
GROUP BY
  letter_grade
ORDER BY
  letter_grade;