-- We can count the number of rows in a table using the COUNT function.

SELECT COUNT(*) FROM Actors;

-- Using the SUM function, we can add up the numeric values of a column

SELECT SUM(NetworthInMillions) FROM Actors;

-- We can use the AVG function to calculate the average net worth of actors as follows:

SELECT AVG(NetWorthInMillions) FROM Actors;

-- We can find the actor with the least net worth as follows:

SELECT MIN(NetWorthInMillions) FROM Actors;

-- Similarly, we can find the actor with the most net worth as follows:

-- Similarly, we can find the actor with the most net worth as follows:

SELECT MAX(NetWorthInMillions) FROM Actors;

-- We can find the income disparity among actors using the standard deviation function STD or STDDEV as follows:

SELECT STDDEV(NetWorthInMillions) FROM Actors;