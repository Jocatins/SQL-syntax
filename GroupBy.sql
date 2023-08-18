-- The GROUP BY, as the name suggests, sorts rows together into groups


-- If we are asked to find the number of male and female actors, 
-- we can use group by gender to fulfill the query.

SELECT Gender, COUNT(*) FROM Actors GROUP BY Gender;

-- we can find the average net worth of actors according to their marital status as follows:

SELECT MaritalStatus, AVG(NetworthInMillions) FROM Actors GROUP BY MaritalStatus ORDER BY MaritalStatus ASC;