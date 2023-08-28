-- Many times, inner join queries can be rewritten as nested queries. For instance, let’s say we want to find the Instagram page for Brad Pitt.
--  One way to glean this information is to use the following inner join query:

SELECT URL AS "Brad's Insta Page" 

FROM Actors 

INNER JOIN DigitalAssets 

WHERE AssetType = "Instagram" AND FirstName  ="Brad";

-- The above join query can be rewritten as a nested query as follows:

SELECT URL 

FROM DigitalAssets 

WHERE AssetType = "Instagram" AND 

ActorId = (SELECT Id 
           FROM Actors 
           WHERE FirstName = "Brad");



--  Let’s work with another example, say we are asked to return the actor who has most recently updated any of his or her online social accounts. 
--  Given the schema of our database we know the column LastUpdatedOn stores the timestamp of when an actor last performed an activity on their online account. 
--  We could use the MAX function to find the row with the most recent activity. 
--  Next, we’ll need to match the actor ID with the maximum value for the LastUpdatedOn column with a row with the same ID in the Actors table. 
--  This query can be written as an inner join query as follows:

SELECT FirstName 

FROM Actors 

INNER JOIN DigitalAssets 

ON ActorId = Id 

WHERE LastUpdatedOn = (SELECT MAX(LastUpdatedOn) 
    FROM DigitalAssets);