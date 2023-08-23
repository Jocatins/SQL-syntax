-- Say we want to find the top three actors by net worth. We can execute the following query to get the desired result

SELECT FirstName, SecondName from Actors ORDER BY NetWorthInMillions DESC LIMIT 3;

-- Next, say we are required to retrieve the next 4 richest actors after the top three. 
-- We can do so by specifying the number of rows we want after the top three rows using the OFFSET keyword.

SELECT FirstName, SecondName from Actors ORDER BY NetWorthInMillions DESC LIMIT 4 OFFSET 3;

-- We can also use the alternative syntax as follows:

SELECT FirstName, SecondName from Actors ORDER BY NetWorthInMillions DESC LIMIT 3,4;

-- Note that we can specify as many rows as we would like to be retrieved, starting at the offset, we specify. 
-- For instance, we can ask for a thousand rows after the offset and we’ll be returned all the rows after the top three.

SELECT FirstName, SecondName from Actors ORDER BY NetWorthInMillions DESC LIMIT 1000 OFFSET 3;

-- The maximum number we can specify after the LIMIT keyword is 18446744073709551615, 
-- since that is the maximum value that can be stored in MySQL’s unsigned BIGINT variable type. 
-- Any value higher than that and MySQL will complain.

SELECT FirstName, SecondName from Actors ORDER BY NetWorthInMillions DESC LIMIT 18446744073709551616;