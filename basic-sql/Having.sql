-- The HAVING clause allows us to filter groups.
-- The HAVING clause works on groups of rows whereas the WHERE clause works on individual rows.

-- We can filter on the group results so that we only see those groups whose net worth is either greater than 450 million or less than 250 million.

SELECT MaritalStatus, AVG(NetworthInMillions) AS NetWorth 
FROM Actors 
GROUP BY MaritalStatus 
HAVING NetWorth > 450 OR NetWorth < 250;

-- Usually, the HAVING clause is used with aggregate functions.
--  If you find yourself writing a HAVING clause that uses a column or expression that isn’t in the SELECT clause, 
--  it is likely you should be using the WHERE clause instead. 
--  For instance, consider the following query, which uses the marital status column in the HAVING clause.

SELECT MaritalStatus, AVG(NetworthInMillions) AS NetWorth 
FROM Actors 
GROUP BY MaritalStatus 
HAVING MaritalStatus='Married';