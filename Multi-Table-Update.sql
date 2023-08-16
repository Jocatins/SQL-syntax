-- We have an equivalent of updating multiple tables just as we can delete from multiple tables.

-- Syntax#
UPDATE T1, T2

SET col1 = newVal1, col2 = newVal2

WHERE <condition1>

-- Let’s say we want to write an update query that converts the FirstName and SecondName strings stored in the Actors table to upper case for those actors who are on Facebook, 
-- and at the same time we also want to convert the associated Facebook URL to uppercase. 
-- We can update rows in both the tables using a multi update query as follows:

UPDATE 
Actors INNER JOIN DigitalAssets 
ON Id = ActorId 
SET FirstName = UPPER(FirstName), SecondName = UPPER(SecondName), URL = UPPER(URL) 
WHERE AssetType = "Facebook";

-- Instead of using an inner join, we can write the same query using the WHERE clause as follows:

UPDATE  Actors, DigitalAssets
SET FirstName = UPPER(FirstName), SecondName = UPPER(SecondName), URL = UPPER(URL) 
WHERE AssetType = "Facebook"
AND ActorId = Id;