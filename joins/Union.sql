-- As a contrived example, we’ll write a query that prints all the first names from the Actors table and all the URLs from the DigitalAssets table.

SELECT FirstName FROM Actors 

UNION 

SELECT URL FROM DigitalAssets;

-- A more realistic example would be a query where you are required to print the top two richest actors and the least two richest.

(SELECT CONCAT(FirstName, ' ', SecondName) AS "Actor Name" 
FROM Actors 
ORDER BY NetworthInMillions DESC 
LIMIT 2)

UNION

(SELECT CONCAT(FirstName, ' ', SecondName) AS "ThisAliasIsIgnored" 
FROM Actors 
ORDER BY NetworthInMillions ASC 
LIMIT 2);

-- The columns from the result sets should be of the same type or types that are compatible.

-- For instance, the following query will error out:

SELECT FirstName, Id FROM Actors 

UNION 

SELECT FirstName FROM Actors;

-- To make the above query work, we can insert a fake column or null as follows:

SELECT FirstName, Id FROM Actors 

UNION 

SELECT FirstName, null FROM Actors;