-- Views are virtual tables that are created as a result of a SELECT query. 
-- They offer a number of advantages such as showing only a subset of data that is meaningful to users or restricting the number of rows and columns shown for security reasons.

-- A view can be created from a single table, by joining two tables, or from another view.

-- The SELECT query specifies the columns in the view.

CREATE VIEW DigitalAssetCount AS 
SELECT ActorId, COUNT(AssetType) AS NumberOfAssets 
FROM DigitalAssets
GROUP BY ActorId;

-- To find out which entities in the above image are tables and which are views, the SHOW FULL TABLES command is used.

SHOW FULL TABLES;

-- A view can be created from multiple tables using JOIN. Let’s suppose we want to create a view of Actors who have Twitter accounts. 
-- This can be done by joining the Actors and DigitalAssets tables as follows:

CREATE VIEW ActorsTwitterAccounts AS
SELECT FirstName, SecondName, URL
FROM Actors
INNER JOIN DigitalAssets  
ON Actors.Id = DigitalAssets.ActorID 
WHERE AssetType = 'Twitter';

-- A view can also be created from another view. 
-- Let’s suppose we want to create a view, RichFemaleActors, based on the RichActors view we created in the last step.

CREATE VIEW RichFemaleActors AS
SELECT * FROM RichActors
WHERE Gender = 'Female';

-- In the previous examples, the SELECT statement specifies the columns of the view. 
-- We can explicitly define columns in a view by listing them in parentheses after the view name. 
-- Run the following query to create the ActorDetails view where we define a column, Age, that is based on the DoB column in the Actors table:

CREATE VIEW ActorDetails (ActorName, Age, MaritalStatus, NetWorthInMillions) AS
SELECT CONCAT(FirstName,' ',SecondName) AS ActorName, 
    TIMESTAMPDIFF(YEAR, DoB, CURDATE()) AS Age, 
    MaritalStatus, NetWorthInMillions 
FROM Actors;

-- The following query lists the actors from the view created above according to age:

SELECT ActorName, Age, NetWorthInMillions
 FROM ActorDetails
 ORDER BY Age DESC;