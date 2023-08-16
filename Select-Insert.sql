-- MySQL provides us the facility to insert several rows from another table into an existing table using a combination of select and insert statements.

-- Syntax to Insert in an Existing Table#
INSERT INTO table1 (col1, col2)

SELECT col3, col4

FROM table2;

-- Syntax to Insert in a New Table
CREATE TABLE newTable (col1 <datatype>, <col2>)

SELECT col3, col4

FROM table2;

-- We can populate data into a table from another table using INSERT and SELECT in a single query. 
-- Say, we want to create a table of all the second names of actors. We’ll create a table as follows:

CREATE TABLE Names (name VARCHAR(20),
                 PRIMARY KEY(name));

--   Now we can insert using INSERT and SELECT in a single statement as follows:               

INSERT INTO Names(name) 
SELECT SecondName FROM Actors;

-- We can do both tasks in one shot. Consider the following query:

CREATE TABLE MyTempTable SELECT * FROM Actors;

-- We can also create a copy of an existing table without the data using the LIKE operator. For instance:

CREATE TABLE CopyOfActors LIKE Actors;