-- It may come as a surprise, but we can also join a table with itself. 
-- However, we need to use aliases as the INNER JOIN clause requires the two tables to be unique.

SELECT * FROM Actors a INNER JOIN Actors b;

-- We can use the USING clause to specify the column to join the two tables on. For example:

SELECT * FROM Actors a INNER JOIN Actors b USING(FirstName);