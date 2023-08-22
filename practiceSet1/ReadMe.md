# Practice Set

-   Write a query that prints the top three movies by box office collection?

select \* from Movies order by CollectionInMillions desc limit 3;

-   Can you write a query to determine if any two actors share the same second name?

-   Solution
    Whenever you hear yourself thinking in terms of picking up a row from a table and comparing it to another row from the same table or another table, you are looking for a join. Without further ado, we’ll perform an inner join of the Actors table.

SELECT \* FROM Movies a
INNER JOIN Movies b;

-   Since we are joining on the table itself, we have to specify aliases a and b to refer to the table and its copy to avoid ambiguity. This is what we wanted. Now we’ll apply our criteria or check to narrow down to rows we want.

-   We don’t want each row to compare to itself so our condition can be a.Id != b.Id.

-   The other condition is to find those actors that have matching second names. We can specify that as a.SecondName = b.SecondName.

SELECT concat(a.FirstName," ",b.SecondName)
FROM Actors a
INNER JOIN Actors b
ON a.SecondName = b.SecondName
WHERE a.ID != b.ID;

We are able to print the names of the actors with same second names, however, each name is printed twice.
The final piece we need is to add the _DISTINCT_ clause so that all names are printed only once.

SELECT DISTINCT concat(a.FirstName," ",b.SecondName)
AS Actors_With_Shared_SecondNames
FROM Actors a
INNER JOIN Actors b
ON a.SecondName = b.SecondName
WHERE a.Id != b.Id;

-   Write a query to count the number of actors who share the same second name. Print the second name along with the count?

Let’s _GROUP BY_ second name first and see what we get:

SELECT b.SecondName
FROM Actors a
INNER JOIN Actors b
ON a.SecondName = b.SecondName
WHERE a.Id != b.Id
GROUP BY b.SecondName;

_GROUP BY_ returns one row per group

SELECT a.SecondName AS Actors_With_Shared_SecondNames,
COUNT(DISTINCT a.Id) AS Count
FROM Actors a
INNER JOIN Actors b
ON a.SecondName = b.SecondName
WHERE a.Id != b.Id
group by a.SecondName;

-   Write a query to display all those actors who have acted in at least one movie.

The data we are interested in resides in the two tables Cast and Actors. If we join the two tables, we’ll get all the actors that have at least one movie to their name. We can then grab the names of the actors from the joined tables and print them. There’s a caveat though; we may print an actor’s name if the actor has multiple movies, therefore, we must use the _DISTINCT_ clause. The query is shown below:

SELECT DISTINCT CONCAT(FirstName, " ", SecondName)
AS Actors_Acted_In_AtLeast_aMovie
FROM Actors INNER JOIN Cast ON Id = ActorId;

-   As a corollary to the previous question, can you find the different ways of listing those aspiring actors who haven’t acted in any movie yet?

One of the easiest ways to answer this query is to take IDs of the actors from the previous query and minus those IDs from the entire set of Actors. The remaining IDs will be of actors who don’t have a film to their name yet. The query is shown below:

SELECT Id, CONCAT(FirstName, " ", "SecondName") AS Actors_With_No_Movies
FROM Actors
WHERE Id NOT IN (Select Id From Actors Inner Join Cast On Id = ActorId);

-   Yet another way is to use a LEFT JOIN the two tables, with Actor as the left argument and the Cast table as the right argument. Let’s see the result of a left join between the two tables.

Select \* from Actors
Left Join Cast
on Id = ActorId

-   You can observe from the joined table that the MovieID column is NULL for those actors who haven’t been part of any movie. Thus, we can use the condition MovieID = NULL in our join query to identify aspiring actors. The query is shown below:

Select \* from Actors
Left Join Cast
on Id = ActorId
Where MovieId IS NULL;
