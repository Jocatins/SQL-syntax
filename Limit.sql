-- Say we want to find the top three actors by net worth. We can execute the following query to get the desired result

SELECT FirstName, SecondName from Actors ORDER BY NetWorthInMillions DESC LIMIT 3;


