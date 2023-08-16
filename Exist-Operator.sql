-- The EXISTS operator is usually used to test if a subquery returns any rows or none at all.

-- We’ll check if our table DigitalAssets has any account owned by the actor George Clooney. 
-- If yes, we print the list of all the actors from our Actors table.

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