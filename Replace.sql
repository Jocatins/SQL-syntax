-- REPLACE is much like the INSERT statement with one key difference: 
-- we can’t insert a row if a table already contains a row with the same primary key. 
-- However, REPLACE allows us the convenience of adding a row with the same primary key as an existing row in the table. 
-- Under the hood, REPLACE deletes the row and then adds the new row thereby maintaining the primary key constraint at all times. 
-- Sure, we can also use the UPDATE clause to achieve the same effect. 
-- However, REPLACE can be useful in automated scripts where it is not known ahead of time if a particular table already contains a particular primary key. 
-- If it doesn’t, the replacement behaves like an insertion, otherwise, it deletes and writes in the new row with the same primary key.

-- SYNTAX
REPLACE INTO table (col1, col2, … coln)

VALUES (val1, val2, … valn)

WHERE <condition>

-- a simple example, where we want to replace the actor with the ID equal to 3 in the Actors table.

 REPLACE INTO
Actors (Id, FirstName, SecondName,DoB, Gender, MaritalStatus, NetworthInMillions)
VALUES (3, "George", "Clooney", "1961-05-06","Male", "Married", 500.00);

-- Now we’ll repeat the previous query but only provide the value for the primary key column and observe the outcome.

REPLACE INTO 
Actors (Id)
VALUES (3);