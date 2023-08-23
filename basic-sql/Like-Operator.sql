-- The LIKE operator works only with string data types and allows us to retrieve rows based on pattern matching on a particular column.

-- Query 1
SELECT * from Actors WHERE FirstName LIKE "Jen%";

-- We can use the underscore character to match exactly one character. For instance, the expression LIKE "_enn%" will match the string "Jennifer”.
-- Query 2
SELECT * from Actors where FirstName LIKE "Jennifer%";

-- Query 3
SELECT * from Actors where FirstName LIKE "%";

-- Query 4
SELECT * from Actors WHERE FirstName LIKE "_enn%";

-- Query 5
SHOW DATABASES LIKE "M%";

-- Query 6
SHOW TABLES LIKE "A%";

-- The LIKE clause can also be used with the SHOW command. For example:

SHOW DATABASES LIKE "M%";