-- If we use the LEFT JOIN instead, we’ll get a list of all the actors with or without digital presence. The query is shown below:

SELECT FirstName, SecondName, AssetType, URL

FROM Actors 

LEFT JOIN DigitalAssets  

ON Actors.Id = DigitalAssets.ActorID;

-- Interestingly, if we flip the order of the two tables in the query we get a different result:

SELECT FirstName, SecondName, AssetType, URL

FROM DigitalAssets 

LEFT JOIN Actors

ON Actors.Id = DigitalAssets.ActorID;

-- The RIGHT JOIN is very similar to the LEFT JOIN. 
-- The only difference is that in the case of the left join, 
-- the unmatched rows come from the table specified on the left of the LEFT JOIN clause whereas, in the case of right join, 
-- the unmatched rows come from the table specified on the right of the RIGHT JOIN clause. 
-- If we use right join in the first query of the lesson, we would not need to flip the tables as we did above.

SELECT FirstName, SecondName, AssetType, URL

FROM Actors 

RIGHT JOIN DigitalAssets  

ON Actors.Id = DigitalAssets.ActorID;