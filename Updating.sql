-- We can use the UPDATE statement to change the value of a column for a row or multiple rows.

UPDATE Actors SET NetWorthInMillions=1;

-- We can use LIMIT and ORDER BY in conjunction to restrict the effects of the update statement.

UPDATE Actors SET NetWorthInMillions=5 ORDER BY FirstName LIMIT 3;

UPDATE Actors SET NetWorthInMillions=50, MaritalStatus="Single";