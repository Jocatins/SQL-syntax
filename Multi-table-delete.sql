--  Scenario

-- If you are confronted with a situation where you want to delete data from one table and also any related data from other tables, 
-- you can employ the multi-table delete queries.

-- Older Syntax
DELETE T1, T2

FROM T1, T2, T3

WHERE <condition>

-- Newer Syntax
-- Use the newer syntax as it reads better:

DELETE FROM T1, T2

USING T1, T2, T3

WHERE <condition>

-- Imagine we want to delete actors who have a Twitter account. 
-- At the same time, we also want to remove their Twitter account information from our DigitalAssets table. 
-- We can delete intended rows from both tables as follows:

DELETE Actors, DigitalAssets   -- Mention tables to delete rows from
FROM Actors   -- The inner join creates a derived table 
           -- with matching rows from both tables    
INNER JOIN DigitalAssets
ON Actors.Id = DigitalAssets.ActorId
WHERE AssetType = "Twitter";

-- The alternative and newer syntax appears below:

DELETE FROM Actors, DigitalAssets
USING Actors        
INNER JOIN DigitalAssets
ON Actors.Id = DigitalAssets.ActorId
WHERE AssetType = "Twitter";

-- say we want to remove Johnny Depp from the Actors table and all his accounts except for his Pinterest from the DigitalAssets table at the same time. 
-- We can write a multi-table delete statement as follows:

DELETE Actors, DigitalAssets   -- specify the tables to delete from

FROM Actors, DigitalAssets   -- reference tables

WHERE ActorId = Id   -- conditions to narrow down rows         
AND FirstName = "Johnny"
AND AssetType != "Pinterest";