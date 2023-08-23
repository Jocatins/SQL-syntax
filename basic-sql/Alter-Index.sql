-- MySQL allows us to add a new index to an existing table. 
-- Say we find out that a lot of users of our application are searching actors by first name. 
-- We can speed up their queries by declaring an index on the first name column as follows:

ALTER TABLE Actors ADD INDEX nameIndex (FirstName);

-- If we want to create the index on the first name column but use only the first ten characters, the query would look like as follows:

ALTER TABLE Actors ADD INDEX nameIndexWithOnlyTenChars (FirstName(10));

-- We can also delete the index we just created as follows:

ALTER TABLE Actors DROP INDEX nameIndex;

-- As an example, we’ll create a temporary table Movies with just two columns, name and release date. 
-- Next, we’ll demonstrate how to delete the primary key and then declare the other column to be the primary key for the table.

1. CREATE TABLE Movies (Name VARCHAR(100), Released DATE, PRIMARY KEY (Name));

2. DESC Movies;

3. ALTER TABLE Movies DROP PRIMARY KEY;

4. ALTER TABLE Movies ADD PRIMARY KEY (Released);

-- We can also rename a table after creating it. In the snippet below, we rename the Actors table to ActorsTable as follows:

ALTER TABLE Actors RENAME ActorsTable;

-- We have already discussed dropping tables, but we can use a slightly improved query using the IF EXISTS clause.

DROP TABLE IF EXISTS ActorsTable;

-- We can delete multiple tables in a single statement by specifying a comma-separated list of table names to delete.

DROP TABLE IF EXISTS Table1, Table2, Table3
;
-- We can drop the entire database as follows:

DROP DATABASE IF EXISTS MovieIndustry;