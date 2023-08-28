# Question 1

-   Write a query to display all those movie titles whose budget is greater than the average budget of all the movies.

This question also requires flexing MySQL’s aggregation capabilities. First we’ll write a query to calculate the average budget for all the films as follows:

SELECT AVG(BudgetInMillions)
FROM Movies;

Now, we can plug the above query as a sub-query and list all the movies whose budget was greater than the average budget across all movies.

SELECT Name
FROM Movies
WHERE BudgetInMillions > (SELECT AVG(BudgetInMillions)
FROM Movies);

# Question 2

-   Find all those actors who don’t have any digital media presence using a right join statement.

The Actors table has the ID column which is the same as the ActorID column of the DigitalAssets table. In a right join, the table on the right side of the join has all the rows included which don’t satisfy the join criteria. In this case, we want to include all the actors that don’t have their ID present in the DigitalAssets table, so we need to place the Actors table on the right of the RIGHT JOIN clause.

SELECT \* FROM DigitalAssets
RIGHT JOIN Actors
ON Id = ActorId;

-   The result set of the above query sets NULL for columns from DigitalAssets table for those rows from the Actors table that don’t have a corresponding entry in the DigitalAssets table. We can predicate on the column URL being NULL to identify those actors who don’t have a social media presence.

SELECT CONCAT(FirstName, " ", SecondName)
AS Actors_With_No_Online_Presence
FROM DigitalAssets
RIGHT JOIN Actors
ON Id = ActorId
WHERE URL IS NULL;

# Question 3

-   Can you rewrite the previous query without a join and using EXISTS operator?

-   We can grab all the actor IDs that exist in the DigitalAssets table and then select those actors from the Actors table whose ID doesn’t appear in the result set of the subquery.

SELECT CONCAT(FirstName, " ", SecondName)
FROM Actors
WHERE NOT EXISTS (SELECT ActorId
FROM DigitalAssets
WHERE ActorId = Id);

# Question 4

-   Write a query to print the name of the fifth highest grossing movie at the box office.

-   It’s trivial to print the list of Movies sorted by how much they made at the box office in descending fashion as follows:

SELECT Name, CollectionInMillions
FROM Movies
ORDER BY CollectionInMillions DESC;

-   To print the 5th highest grossing movie, we need to leverage the OFFSET and LIMIT clauses. OFFSET allows us to print results starting from a specific row in the sorted result set. We’ll want to print the row immediately after the first 4 rows, which will be the fifth row in the sorted result and the 5th highest grossing movie. Finally, we’ll use the LIMIT clause set to 1 to print only one row. The final query is shown below:

SELECT Name,
CollectionInMillions AS Collection_In_Millions
FROM Movies
ORDER BY CollectionInMillions DESC
LIMIT 1 OFFSET 4;

-   Alternative syntax would be:

SELECT Name,
CollectionInMillions AS Collection_In_Millions
FROM Movies
ORDER BY CollectionInMillions DESC
LIMIT 4, 1;

# Question 5

-   Find those movies, whose cast latest activity on social media occurred between the span of 5 days before and 5 days after the release date.

-   This question is an example of a complex query. We are asked to find the names of those movies whose cast’s latest activity on their digital assets was around the same time when the movie was released. We store the last time an actor updated any of his digital accounts in the DigitalAssets table whereas the release date of the movie is in the Movies table. We’ll need to connect all information from the DigitalAssets table to the Movies using the Cast table step by step. Let’s see how we can do that:

-   First, we’ll retrieve the latest times for all the actors when they made updates to their online accounts along with their IDs.

SELECT LastUpdatedOn, Id
FROM Actors
INNER JOIN DigitalAssets
ON ActorId = Id;

-   Next, we’ll join the result of the previous step with the Cast table based on the actor ID. The result of this step will be another derived table whose each row will consist of a movie ID, an actor that was part of the movie, and time of their latest online activity.

SELECT \*

FROM Cast

INNER JOIN (SELECT LastUpdatedOn, Id
FROM Actors
INNER JOIN DigitalAssets
ON ActorId = Id) AS tbl

ON tbl.Id = ActorId;

-   In the third step we can join the derived table of the second step with the Movies table based on the movie ID. The derived table resulting from this joining will have the movie name, movie release date, an actor participating in that movie, and the latest time of that actor’s online activity. By now we have all the necessary columns we need to compare.

SELECT \*

FROM Movies AS m

INNER JOIN (SELECT \*

         FROM Cast

         INNER JOIN (SELECT LastUpdatedOn, Id
                     FROM Actors
                     INNER JOIN DigitalAssets
                     ON ActorId = Id) AS tbl1
         ON tbl1.Id = ActorId) AS tbl2

ON tbl2.MovieId = m.Id;

-   In the fourth step we’ll add a WHERE clause and set the LastUpdatedColumn to be between the plus/minus 5 days from the date of the movie release. Also, remember that two actors cast in the same movie could have posted about their upcoming movie, but we want to print the name of the movie only once, therefore, we also add the DISTINCT clause.

SELECT DISTINCT Name

AS Actors_Posting_Online_Within_Five_Days_Of_Movie_Release

FROM Movies AS m

INNER JOIN (SELECT \*

         FROM Cast

         INNER JOIN (SELECT LastUpdatedOn, Id
                     FROM Actors
                     INNER JOIN DigitalAssets
                     ON ActorId = Id) AS tbl1
         ON tbl1.Id = ActorId) AS tbl2

ON tbl2.MovieId = m.Id

WHERE ADDDATE(ReleaseDate, INTERVAL -5 Day) <= LastUpdatedOn

AND ADDDATE(ReleaseDate, INTERVAL +5 Day) >= LastUpdatedOn;
