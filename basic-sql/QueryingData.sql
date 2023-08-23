-- the following SELECT statement to retrieve all the rows in the table with all the columns

SELECT * from Actors;

-- In this command, we’ll display the first name and second name columns. Execute the following command:

SELECT FirstName, SecondName from Actors;

Adding Where

SELECT FirstName, SecondName from Actors WHERE NetWorthInMillions > 500;


-- LIKE Operator


-- The LIKE operator works only with string data types and allows us to retrieve rows based on pattern matching on a particular column.

-- You can check if there is an actor with a name that has “Jen” as the prefix by executing the following query in the terminal.

SELECT * from Actors WHERE FirstName LIKE "Jen%";

-- The % symbol is a wildcard character that matches all strings

-- We can use the underscore character to match exactly one character

SELECT * from Actors WHERE FirstName LIKE "_enn%";


-- Combining Conditions

-- We can use the AND operator to query

SELECT * FROM Actors WHERE FirstName > "B" AND NetWorthInMillions > 200;

-- We can use the OR operator to match rows that satisfy at least one of several conditions specified in the WHERE clause.

SELECT * FROM Actors WHERE FirstName > "B" OR NetWorthInMillions > 200;

-- We can also combine the AND and the OR operators. Consider the following query:

SELECT * FROM Actors WHERE (FirstName > 'B' AND FirstName < 'J') OR (SecondName >'I' AND SecondName < 'K');

-- NOT is a unary operator that negates a boolean statement

SELECT * FROM Actors WHERE NOT NetWorthInMillions = 200;

-- MySQL supports exclusive OR through the XOR operator. Exclusive OR returns true when one of the two conditions is true. 
-- If both conditions are true, or both are false, the result of the XOR operations is false.

SELECT * FROM Actors WHERE FirstName > "B" XOR NetWorthInMillions > 200;