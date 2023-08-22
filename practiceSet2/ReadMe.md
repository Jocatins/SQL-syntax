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

-   Print a list of movies and the actor(s) who participated in each movie ordered by movie name.

-   Print the count of actors in each movie.

-   List the names of Producers who never produced a movie for Tom Cruise.
