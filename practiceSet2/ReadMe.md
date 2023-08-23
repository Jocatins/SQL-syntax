# Practice Set 2

# Question 1

-   Write a query to display all those actors who have acted in 2 or more movies.

-   The names of the actors are in the Actors table and the number of movies an actor has appeared in is in the Cast table. If we join the two tables, we can get the name of actor and the ID of the movie that the actor has starred in. Let’s see how that looks like:

Select Id, FirstName, SecondName, MovieId
From Actors
Inner Join Cast
on Id = ActorId;

-   We can GROUP BY the result of the above query by ID of each actor so that all the movies that an actor has acted in, fall into the same group. Next, we simply count the rows in each group. So far, we have the following:

Select Id, Count(\*)
From Actors
Inner Join Cast
on Id = ActorId
Group By Id;

-   Now we’ll apply the restriction to only list those groups which have more than one row to fulfill the requirement to print names of only those actors who have acted in at least two movies.

Select Id, COUNT(\*) as MovieCount
From Actors
Inner Join Cast
On id=ActorId
Group By Id
Having MovieCount > 1;

-   The last piece is to print the actor’s name.

Select Id, FirstName, SecondName,
COUNT(\*) as MovieCount
From Actors Inner Join Cast
On id=ActorId
Group By Id
Having MovieCount > 1;

-   We can join the result of the above query with the Actors table based on the common actor ID column the two tables hold. From the joined result we can extract the actor name and the movie count columns.

SELECT CONCAT (FirstName, " ", SecondName)

AS Actor_Names,

Movie_Count

FROM Actors a

INNER JOIN (SELECT Id,
COUNT(\*) AS Movie_Count
FROM Actors
INNER JOIN Cast
ON Id = ActorId
GROUP BY Id
HAVING Movie_Count > 1) AS tbl

ON tbl.Id = a.Id;

# Question 2

-   Find the cast of movie Mr and Mrs. Smith without using joins.

We are given the name of the movie but not its ID. We’ll first need a query to extract the ID of the movie. If we were asked to find the cast of the movie Ocean’s 11, which has two entries in the Movies table since there have been two movies by the same name, we would need further information to narrow down to exactly one movie. In the case of, Mr. & Mrs. Smith we have only one entry and we can get the ID of the movie as follows:

Select Id
From Movies
Where Name="Mr & Mrs. Smith";

-   We can identify the cast of the movie by looking for rows in the Cast table that have the same value for the MovieID column as the ID of the movie Mr. & Mrs. Smith. We’ll use nested query to list the IDs of the cast as follows:

Select ActorId
From Cast
Where MovieId IN (Select Id From Movies Where Name="Mr & Mrs. Smith");

-   Once we have the actor IDs, we can find all the names of the actors from the Actors table by matching on the ID.

Select Concat(FirstName, " ", SecondName)
As "Cast of Mr and Mrs Smith"
From Actors
Where Id IN (Select ActorId From Cast Where MovieId IN (Select Id From Movies Where Name="Mr & Mrs. Smith"));

-   The solution we provided used nested queries, we could also have arrived at the same result using joins. The complete query with joins is as follows

SELECT CONCAT(FirstName, " ", SecondName)

AS "Cast Of Mr. & Mrs. Smith"

FROM Actors

INNER JOIN (SELECT ActorId
FROM Cast
INNER JOIN Movies
ON MovieId = Id
WHERE Name="Mr & Mrs. Smith") AS tbl

ON tbl.ActorId = Id;

-   Print a list of movies and the actor(s) who participated in each movie ordered by movie name.

-   The Cast table exactly does that; however, it lists integer IDs for actors and movies instead of actual names. We have to expand the IDs into names for both actors and movies. Let’s start by joining the Cast table with the Actors table on movie ID.

Select Name, ActorId From Movies Inner Join Cast On Id = MovieId;

-   Next, we can join the derived table from the above query with the Actors table based on actor ID and thus extract the actor name. Lastly, don’t forget to order the result by movie name.

SELECT tbl.Name AS Movie_Name,

CONCAT(FirstName, " ", SecondName) AS Actor_Name

FROM Actors

INNER JOIN (SELECT Name, ActorId
FROM Movies
INNER JOIN Cast
On Id = MovieId) AS tbl

ON tbl.ActorId = Id

ORDER BY tbl.Name ASC;

-   Print the count of actors in each movie.

The requirement to use count hints towards aggregation. In the previous query, we were able to print the pair of actor and movie names. The astute reader would immediately realize that if we GROUP BY the results by movie name from the previous query, all the actors who acted in that movie will fall into that bucket. We can then count the number of actors in each bucket/group and report that as the result. However, there’s one catch! If we group by movie name, then actors from two movies with the same name will all fall in one bucket and distort the counts. Therefore, we must GROUP BY movie ID.

SELECT tbl.Name, COUNT(\*)

FROM Actors

INNER JOIN (SELECT Name, ActorId, MovieId
FROM Movies
INNER JOIN Cast
On Id = MovieId) AS tbl

ON tbl.ActorId = Id

GROUP BY tbl.MovieId;

-   The above query gets us what we want but is convoluted and unnecessarily complex. Note that the information we require is available in the Cast and the \_\_Movies table. We don’t require the actor names in our final result, so we don’t need to join with the Actors table. We can GROUP BY the contents of the Movies table by movie ID and find the counts of actors for each movie as follows:

SELECT MovieId, COUNT(\*)
FROM Cast
GROUP BY MovieId;

-   Now we can join the derived table from the above query with the Movies table on the movie to infer the movie name. The query is shown as follows:

SELECT Name AS Movie_Name,

Actor_Count

FROM Movies

INNER JOIN (SELECT MovieId, COUNT(\*) AS Actor_Count
FROM Cast
GROUP BY MovieId) AS tbl

ON tbl.MovieID = Id;

-   List the names of Producers who never produced a movie for Tom Cruise.

-   Information about movie producers resides in the Movies table. We don’t know the ID of Tom Cruise on top of our head, so we’ll need to query the Actors table too. Finally, the Cast table will let us connect the various queries to find all producers who didn’t include Tom Cruise in the cast. Let’s start by first finding the ID of Tom Cruise.

SELECT Id
FROM Actors
WHERE FirstName = "Tom"
AND SecondName = "Cruise";

-   Using these IDs we can join on the Movies table and find all those producers who had Tom in their movies.

Select Distinct Producer
From Movies
Where Id IN (Select MovieId
From Cast
Where ActorId = (
select id from Actors where FirstName="tom"));

-   We may be tempted to add in the NOT IN in the outermost select clause to get all the producers who didn’t have Tom act in their movies and declare it as the final result, however, that is incorrect. The resulting query will be:

SELECT DISTINCT Producer
FROM Movies
WHERE Id NOT IN (SELECT MovieId
FROM Cast
WHERE ActorId = (SELECT Id
FROM Actors
WHERE FirstName = "Tom"
AND SecondName = "Cruise"));

-   But with the query Above, the producer who also produced for Tom will also appear here.

-   whereas we want only those producers who never worked with Tom. The fix is to find all those producers which have at least one movie with Tom, which we have already done, and then subtract these producers from the set of all the producers. The complete query appears below:

SELECT DISTINCT Producer
FROM Movies
WHERE Producer
NOT IN (SELECT Producer
FROM Movies
WHERE Id IN (SELECT MovieId
FROM Cast
WHERE ActorId = (SELECT Id
FROM Actors
WHERE FirstName = "Tom"
AND SecondName = "Cruise")));
