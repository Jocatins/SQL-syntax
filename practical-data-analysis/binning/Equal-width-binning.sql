-- Equal-width binning divides values into ranges of equal width. 
-- Unlike equal-height binning, where all buckets have roughly the same frequency, in equal-width binning, each bucket can have a different frequency.

-- Equal-width binning is often used to produce histogram

-- Equal-width binning using arithmetic

-- Given a table of student grades, we want to visualize the distribution of grades. 
-- We can divide the range of possible scores 1–100 into 10 equal-width buckets. 
-- To assign each value to a bucket, we divide it by the desired width of the bucket, 10:

SELECT 
  grade,
  (grade - 1) / 10 as bucket
FROM
  grades
ORDER BY
  grade;

-- To get a better sense of the buckets, we can summarize the results using the following query:


WITH grades_with_buckets AS (
  SELECT
    grade,
    (grade - 1) / 10 as bucket
  FROM
    grades
)
SELECT
  bucket,
  MIN(grade) AS min_gr,
  MAX(grade) AS max_gr,
  COUNT(*) AS grades
FROM
  grades_with_buckets
GROUP BY 
  bucket
ORDER BY
  bucket;
