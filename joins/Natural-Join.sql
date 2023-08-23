-- The NATURAL JOIN performs an inner join of the participating tables essentially without the user having to specify the matching columns.
--  An example is as follows:

SELECT FirstName, SecondName, AssetType, URL

FROM Actors 

NATURAL JOIN DigitalAssets;

-- The same result can be achieved using the inner join as follows:

SELECT FirstName, SecondName, AssetType, URL
 
FROM Actors 

INNER JOIN DigitalAssets;


-- We’ll execute the above query again, 
-- but we’ll alter the column name for the DigitalAssets table from ActorID to ID so that it matches the column name in the Actors table.

-- Alter the column name
ALTER TABLE DigitalAssets CHANGE ActorId Id INT;
-- rerun the previous query
SELECT FirstName, SecondName, AssetType, URL

FROM Actors 

NATURAL JOIN DigitalAssets;

-- You can observe from the results that the server matched the columns with the same name in both the tables and
--  we get results equivalent to the following inner join query:

SELECT FirstName, SecondName, AssetType, URL
 
FROM Actors 

INNER JOIN DigitalAssets USING (Id);

-- We can also ask for natural left and right joins. As an example, we show a natural left join below:

SELECT FirstName, SecondName, AssetType, URL

FROM Actors 

NATURAL LEFT OUTER JOIN DigitalAssets;