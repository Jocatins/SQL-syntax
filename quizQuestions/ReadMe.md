SQL Quiz

Q - Which query/queries will print the version of MySQL

SELECT VERSION();

SHOW VARIABLES LIKE "%version%"

Q - How can we get the current time and date in MYSQL?

SELECT NOW();

SELECT CURRENT_TIMESTAMP();

Q - Imagine you have a table that consists only of country names. You are asked to write a query that randomly selects ten countries. Identify the correct query from the following?

SELECT CountryName FROM Countries ORDER BY RAND() LIMIT 10;

Q - In what order are the various clauses evaluated from left to right?

FROM WHERE SELECT GROUP-BY HAVING ORDER-BY LIMIT

Q - What are partial indexes?

Partial indexes are also known as filtered indexes and include only a subset of rows of a table rather than the entire table. The rows are selected for indexing based on some specified condition.

Q - What is the difference between clustered and non-clustered index?

In case of clustered index, the table is itself stored on disk as an index, usually, as a B+ tree. Whereas, in the case of a non-clustered index, the table is stored in the order as the rows are inserted and any declared indexes exist as separate data-structures on the disk

Q - Consider we have two tables A and B. Table A has 10 rows and Table B has 13 rows. What will be the number of rows in the result set if we do a cross join (cartesian product) between the two tables?

130

Q - Does UNION operator include duplicates?

False

NB - NULL should always be tested for using IS NULL or IS NOT NULL.

Q - Which one of the following is a disadvantage of adding a foreign key constraint?

Adding a foreign slows down write queries as the database has to verify that each write operation honors the foreign key constraint.

Q - Under what condition does REPLACE behave exactly like INSERT?

When the table has no primary and unique index defined on it

Q - Why adding or dropping a column from a very large table may be a bad idea?

Adding or removing columns causes a table to be rebuilt and can be an expensive operation for a very large table.

Q - Which of the following is true about foreign keys?

An alternative to foreign key constraint is to enforce checks at the application layer and remove foreign key constraints at the database layer.

A table can define a foreign key relationship between its two columns as long as the two columns aren’t the same column.

Q - Which of the following is a disadvantage of defining foreign key constraints?

May slow down application as write operations require verifying foreign key constraints.

Foreign keys can come with an increase in size as MySQL requires an index to be defined on the foreign key.

Can a column which isn’t unique or the primary key in a parent act as a foreign key in a child table?

True

Q - Which statement is true about tables and views?

A table is an independent object and a view is a dependent object.

Q - Which of the following statements are true about the WITH CHECK OPTION clause?

The WITH CHECK OPTION clause prevents inserts of rows for which the WHERE clause in the select_statement is not true.

The WITH CHECK OPTION clause prevents updates to rows for which the WHERE clause is true but the update would cause it to be not true
