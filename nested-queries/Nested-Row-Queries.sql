-- Let’s say we want to find the list of all the actors whose latest update to any of their online accounts was on the day of their birthday. 
-- The date of birth for each actor is in the Actors table and the LastUpdatedOn column is in the DigitalAssets table. 
-- We can extract the birthday month and day using the MONTH() and DAY() functions on the DoB column and match them with the 
-- corresponding extracted values from the LastUpdatedOn column. 
-- Finally, we’ll also need to match the actor IDs in the two tables. 
-- The inner join query to get the results is as follows:

SELECT FirstName
FROM Actors
INNER JOIN DigitalAssets
ON Id=ActorId 
AND MONTH(DoB) = MONTH(LastUpdatedOn) 
AND DAY(DoB) = DAY(LastUpdatedOn);

-- Instead of the inner join we can also use a nested query. 
-- We’ll return three columns from the inner query, the day and month of the last update and the actor ID. 
-- The outer query will match on these three columns using the IN clause.

SELECT FirstName

FROM Actors 

WHERE (Id, MONTH(DoB), DAY(DoB))

IN ( SELECT ActorId, MONTH(LastUpdatedOn), DAY(LastUpdatedOn)
     FROM DigitalAssets);

-- To demonstrate using a nested query with the FROM clause, we’ll move onto a slightly harder query to answer. 
-- Say you are asked to find out which of her online accounts Kim Kardashian most recently updated. 
-- Let’s think about it for a minute: the two pieces of information we need are present in the two tables: 
-- Actors (name) and DigitalAssets (last update timestamp). First, let’s understand how we can find the latest updated account for an actor. 
-- If we know the ActorID, we can use the following query to list all the online accounts belonging to that actor along with their latest update times.

SELECT ActorId, AssetType, LastUpdatedOn FROM DigitalAssets;

-- The above query also retrieves us the actor IDs. If we could determine Kardashian’s actor ID from the output of the above query, 
-- we could use that in a WHERE clause and answer the original question, but we don’t. 
-- We’ll need to join the result of the above query with the actor table based on actor IDs to know which rows from the DigitalAssets table belong to Kardashian. 
-- So far, we have:

SELECT FirstName, AssetType, LastUpdatedOn 

FROM Actors 

INNER JOIN (SELECT ActorId, AssetType, LastUpdatedOn 
            FROM DigitalAssets) AS tbl 

ON ActorId = Id;

-- Note that we give an alias of tbl to the result set of the inner query. 
-- When the result of an inner query is used as a derived table, MySQL requires us to provide an alias for the table. 
-- This is a syntax requirement. If we skip aliasing the result set of the inner query, we’ll not be able to use it in the join clause. 
-- In order to narrow down the rows for Kardashian we’ll need to add a WHERE clause with the condition FirstName=“Kim”. 
-- Now we’ll have all the digital accounts belonging to Kardashian as follows:

SELECT FirstName, AssetType, LastUpdatedOn 

FROM Actors 

INNER JOIN (SELECT ActorId, AssetType, LastUpdatedOn 
            FROM DigitalAssets) AS tbl 

ON ActorId = Id

WHERE FirstName = "Kim";

-- The last piece is to order the rows by LastUpdatedOn to get the latest updated online account for Kardashian.

SELECT FirstName, AssetType, LastUpdatedOn 

FROM Actors 

INNER JOIN (SELECT ActorId, AssetType, LastUpdatedOn 
            FROM DigitalAssets) AS tbl 

ON ActorId = Id

WHERE FirstName = "Kim"

ORDER BY LastUpdatedOn DESC LIMIT 1;

-- The astute reader would realize that in the FROM clause we could have just as well used the DigitalAssets table instead of plugging in a nested query. 
-- Sure, we could, but the intent here is to demonstrate how nested queries can be used with the FROM clause, so in that sense, 
-- it is a slightly contrived example.