-- Sampling with LIMIT

-- A simple way to fetch a random portion of a table is combining random with LIMIT:

WITH sample AS (
    SELECT *
    FROM users
    ORDER BY random() 
    LIMIT 10000
)
SELECT count(*) FROM sample;
 count
───────
 10000
(1 row)

-- Time: 205.643 ms

-- To sample 10,000 random rows from the table users we do the following:

-- 1 - Sort the table in a random order using random().
-- 2 - Take the first 10,000 rows using LIMIT 10000.

-- This method of sampling forces the database to sort the entire dataset, and then pick the first N rows. 
-- This method is fine for small datasets, but for very large datasets it can be very inefficient and might result in high memory consumption
--  and CPU usage

-- Using TABLESAMPLE

-- To sample a table, we use the TABLESAMPLE keyword in the FROM clause, and provide the sampling method and its arguments.

-- To use the SYSTEM sampling method to sample 10% of the table, we can use the following query:

WITH sample AS (
    SELECT *
    FROM users TABLESAMPLE SYSTEM(10)
)
SELECT count(*) FROM sample;

 count
───────
 95400
(1 row)

-- Time: 13.690 ms

-- The SYSTEM sampling method works by sampling blocks from the table. 
-- For example, if we sample 10% from a table that is stored in 10 blocks, the SYSTEM sampling method will read just one block and return the rows inside.

-- Notice that sampling 10% of the table using the SYSTEM sampling method is much quicker than the previous method using random and LIMIT-205ms
--  compared to just 13ms. The SYSTEM sampling method works at the storage level and so is very fast.

--  The BERNOULLI sampling method

-- Another sampling method is BERNOULLI. To sample 10% of the table using BERNOULLI, we can use the following query:

WITH sample AS (
    SELECT *
    FROM users TABLESAMPLE BERNOULLI(10)
)
SELECT count(*) FROM sample;

 count
────────
 100364
(1 row)

-- Time: 54.593 ms

-- Using the BERNOULLI sampling method we got 100,364 rows in 54ms. 
-- This method is faster than using random and LIMIT, but a bit slower than the SYSTEM sampling method.

-- Unlike the SYSTEM sampling method, which reads a sample of the table blocks, 
-- the BERNOULLI sampling method scans the entire table and picks random rows. 
-- This means BERNOULLI is slower than SYSTEM, but it produces more evenly distributed random results.

-- If we have a small data set and we can’t compromise the size of the sample, use random() and LIMIT.
-- If we have a large data set, start with BERNOULLI, and consider switching to SYSTEM only if the performance is too degraded.

