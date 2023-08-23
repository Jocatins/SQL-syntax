SELECT FirstName, SecondName, AssetType, URL

FROM Actors 

INNER JOIN DigitalAssets  

ON Actors.Id = DigitalAssets.ActorID;

-- If the two tables had the same column name for the actor’s ID then we could have used the alternative syntax with USING clause
--  to make the query slightly less verbose as shown below:

SELECT FirstName, SecondName, AssetType, URL 

FROM Actors 

INNER JOIN DigitalAssets 

USING(Id);

-- It’s not necessary to use the INNER JOIN clause to get an inner join between two tables. 
-- We can also use the WHERE clause to achieve the same effect as shown below:

SELECT FirstName, SecondName, AssetType, URL 
FROM Actors, DigitalAssets 
WHERE ActorId=Id;

-- We can also create a cartesian product between the two tables as we did in the self join section. 
-- We can use either the where or the inner join syntax. Both are shown below:

SELECT FirstName, SecondName, AssetType, URL 
FROM Actors, DigitalAssets;

-- Or

SELECT FirstName, SecondName, AssetType, URL 
FROM Actors 
INNER JOIN DigitalAssets;