-- We can use the UPDATE statement to change the value of a column for a row or multiple rows.

UPDATE Actors SET NetWorthInMillions=1;

-- We can use LIMIT and ORDER BY in conjunction to restrict the effects of the update statement.

UPDATE Actors SET NetWorthInMillions=5 ORDER BY FirstName LIMIT 3;

-- Lastly, we can update multiple columns in an UPDATE statement. 
-- Say we want to give all the actors fifty million dollars and make them single, we can do so in a single UPDATE statement.

UPDATE Actors SET NetWorthInMillions=50, MaritalStatus="Single";