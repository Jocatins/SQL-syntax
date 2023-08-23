-- Deleting Data

-- We’ll start with deleting just one row

DELETE FROM Actors WHERE FirstName="priyanka";

-- The delete statement will delete all the matching rows, which in the previous example is only one.

DELETE FROM Actors WHERE Gender="Male";

-- Next, suppose that out of the remaining female actors in our database, we want to delete the top three actresses by net worth. 
-- We can accomplish that by using the ORDER BY and LIMIT clauses.

DELETE FROM Actors ORDER BY NetWorthInMillions DESC LIMIT 3;

-- We can remove all the rows from a table using the following query:

DELETE FROM Actors;