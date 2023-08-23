-- Aliases are like nicknames, a temporary name given to a table or a column to write expressive and readable queries. 
-- We can use aliases with columns, tables, and MySQL functions

SELECT FirstName AS PopularName from Actors;

-- We can also use aliases with MySQL functions. 
-- For instance, we use the concat function to print the full name for an actor as follows:

SELECT CONCAT(FirstName,' ', SecondName) AS FullName FROM Actors;

-- We can now sort the actors by their full names which are displayed by the concat function as follows:

SELECT CONCAT(FirstName,' ', SecondName) AS FullName FROM Actors ORDER BY FullName;

-- Without using the alias feature the same query would be written as follows:

SELECT CONCAT(FirstName,' ', SecondName) FROM Actors ORDER BY CONCAT(FirstName,' ', SecondName);

-- The above query is verbose compared to the one written using the alias.

-- Notably, aliases for columns can’t be used in the WHERE clause but aliases for table can

SELECT FirstName FROM Actors AS tbl WHERE tbl.FirstName='Brad' AND tbl.NetWorthInMillions > 200;

-- For some queries table aliases are inevitable. 
-- For instance, we can alias the Actors table twice to find out all the actors with the same net worth in a single query. 
-- Think of picking each row and comparing it with the rest of the rows in the table to find two rows with the same NetWorthInMillions column.
-- However, the caveat is that we want to skip the row when it tries to match with itself. 
-- The complete query is presented below:

SELECT t1.FirstName, t1.NetworthInMillions
FROM Actors AS t1,
Actors AS t2
WHERE t1.NetworthInMillions = t2.NetworthInMillions
AND t1.Id != t2.Id;