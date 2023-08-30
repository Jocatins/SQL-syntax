-- To generate random numbers PostgreSQL provides a random function. The function then returns a value between 0 and 1:
SELECT  random();

-- To generate values at different ranges, we can use random in an expression
SELECT random() * 100;

-- If we want to produce a random integer between 0 and 99, we can round the number down using the floor function:
SELECT floor(random() * 90) as n;

SELECT 10 + floor(random() * 90) as n;

-- Converting float to integer
-- There are two more functions we can use to convert a float to an integer.

-- floor: Round a float down to the closest integer, such as floor(1.6) = 1.
-- round: Round a float to the closest integer, such as round(1.6) = 2 and round(1.4) = 1.
-- ceil: Round a float up to the closest integer, such as ceil(1.4) = 2.

SELECT
  n,
  floor(n) as floor_,
  round(n) as round_,
  ceil(n) as ceil_
FROM (VALUES 
  (1.0),
  (1.2),
  (1.5),
  (1.7),
  (2.0)
) AS t(n)

-- Output

-- n	floor_	round_	ceil_
-- 1.0	1	1	1
-- 1.2	1	1	2
-- 1.5	1	2	2
-- 1.7	1	2	2
-- 2.0	2	2	2

-- Using what we’ve learned so far, we can use the random function to pick a random value from an array:

SELECT (array['red', 'green', 'blue'])[1 + floor(random() * 3)] AS color

-- So, how can we reproduce random results?

-- In PostgreSQL we can generate reproducible random data by setting the random seed, using the setseed function:

SELECT setseed(0.4050);
SELECT random() as n;