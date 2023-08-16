-- ORDER BY

-- Suppose we want to print the names of all the actors sorted in alphabetical order. We can do so using the following query:

SELECT * FROM Actors ORDER BY FirstName;

-- We can also print the rows in descending order as the following query demonstrates

SELECT * FROM Actors ORDER BY FirstName DESC;


-- We can also specify more than one sort key

SELECT * FROM Actors ORDER BY NetWorthInMillions, FirstName;


-- We can also control the ascending or descending order we desire for each sort key

SELECT * FROM Actors ORDER BY NetWorthInMillions DESC, FirstName ASC;