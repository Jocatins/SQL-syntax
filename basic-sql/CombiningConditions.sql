-- We can use the AND operator to query for actors whose
-- first name starts with the letter ‘B’ or any character thereafter and whose net worth is greater than 200 million dollars.

SELECT * FROM Actors WHERE FirstName > "B" AND NetWorthInMillions > 200;

-- We can use the OR operator to match rows that satisfy at least one of several conditions specified in the WHERE clause.
-- We can now query for actors whose first name starts with the letter B or any character thereafter or has a net worth of 200 million dollars or greater

SELECT * FROM Actors WHERE FirstName > "B" OR NetWorthInMillions > 200;

-- We can also combine the AND and the OR operators. Consider the following query:

SELECT * FROM Actors WHERE (FirstName > 'B' AND FirstName < 'J') OR (SecondName >'I' AND SecondName < 'K');

-- NOT is a unary operator that negates a boolean statement

SELECT * FROM Actors WHERE NOT(FirstName > "B" OR NetWorthInMillions > 200);

-- The above query returns all the actors with a net worth not equal to 200 million dollars. 
-- However, if we put parentheses as follows around the NOT operator, the result is an empty set:

SELECT * FROM Actors WHERE (NOT NetWorthInMillions) = 200;

-- MySQL supports exclusive OR through the XOR operator. Exclusive OR returns true when one of the two conditions is true. 
-- If both conditions are true, or both are false, the result of the XOR operations is false. 
-- If we XOR the conditions from the previous query, we are returned four rows. 
-- The rows satisfy either of the conditions but not both. 
-- All the other rows in the table either fail or satisfy both conditions and aren’t included in the result set.

SELECT * FROM Actors WHERE FirstName > "B" XOR NetWorthInMillions > 200;