-- Let’s start with a simple example. We’ll check if our table DigitalAssets has any account owned by the actor George Clooney. 
-- If yes, we print the list of all the actors from our Actors table. 
-- Granted, the query doesn’t make much sense but bear with me as we’ll see more useful applications of the EXISTS operator in later lessons. 
-- The query is shown below:

SELECT *

FROM Actors

WHERE EXISTS ( SELECT * 
            FROM DigitalAssets
            WHERE BINARY URL LIKE "%clooney%"); 


-- We add the NOT operator to the EXISTS clause and see the entire Actors table print out.

SELECT *

FROM Actors

WHERE NOT EXISTS ( SELECT * 
            FROM DigitalAssets
            WHERE BINARY URL LIKE "%clooney%");