-- ORDER BY

-- Suppose we want to print the names of all the actors sorted in alphabetical order. We can do so using the following query:

SELECT * FROM Actors ORDER BY FirstName;

-- We can also print the rows in descending order as the following query demonstrates

SELECT * FROM Actors ORDER BY FirstName DESC;


-- We can also specify more than one sort key

SELECT * FROM Actors ORDER BY NetWorthInMillions, FirstName;


-- We can also control the ascending or descending order we desire for each sort key

SELECT * FROM Actors ORDER BY NetWorthInMillions DESC, FirstName ASC;

-- MySQL ignores case when comparing strings in the ORDER BY clause, which implies strings “Kim”, “kIm” and “kim” are treated equally.
--  If we want ASCII comparison we need to specify the BINARY keyword before the sort key.
--   To demonstrate the effect of the BINARY keyword, execute the following query and observe the results:

SELECT * FROM Actors ORDER BY BINARY FirstName;

-- The CAST function can also be used with the ORDER BY clause. 
-- The CAST function allows us to treat a column as a different type. 
-- For example, the Actors table can be sorted on the NetWorthInMillions as follows:

SELECT * FROM Actors ORDER BY NetWorthInMillions;

-- The NetWorthInMillions column is sorted numerically from smallest to largest. 
-- We can also sort the NetWorthInMillions column as if strings using the CAST function as follows:

SELECT * FROM Actors ORDER BY CAST(NetWorthInMillions AS CHAR);