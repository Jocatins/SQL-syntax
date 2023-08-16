-- MySQL allows us to change our mind about the entities we create and alter them. 
-- We can rename tables, add, remove, or rename columns, change type of an existing column, etc

-- say we want to rename the column FirstName to First_Name for the Actors table. 
-- We can do so as follows:

ALTER TABLE Actors CHANGE FirstName First_Name varchar(120);

-- We can use the MODIFY keyword if we wish to alter the type or the clauses for a column. 
-- For instance, we can specify the default value for the column First_Name to be the string “Anonymous” as follows:

ALTER TABLE Actors MODIFY First_Name varchar(20) DEFAULT "Anonymous";

-- we can change the column first name to have a varchar length of 300 as shown below:

ALTER TABLE Actors MODIFY First_Name varchar(300);


-- We can also add a column to an existing table. 
-- We can add a new column MiddleName to the Actors table using the following query:

ALTER TABLE Actors ADD MiddleName 
varchar(100);

-- We can also remove the newly added column using the DROP statement as follows:

ALTER TABLE Actors DROP MiddleName;

-- We can also control the position of the new column within the table using the FIRST or AFTER keyword.


ALTER TABLE Actors ADD MiddleName varchar(100) FIRST;
ALTER TABLE Actors ADD MiddleName varchar(100) AFTER DoB;


Alter Index

-- MySQL allows us to add a new index to an existing table

ALTER TABLE Actors ADD INDEX nameIndex (FirstName);


-- We can also delete the index we just created as follows:

ALTER TABLE Actors DROP INDEX nameIndex;

-- We can also rename a table after creating it

ALTER TABLE Actors RENAME ActorsTable;

-- We can use a slightly improved query using the IF EXISTS clause

DROP TABLE IF EXISTS ActorsTable;

-- We can delete multiple tables in a single statement by specifying a comma-separated list of table names to delete

DROP TABLE IF EXISTS Table1, Table2, Table3;

-- We can drop the entire database as follows:

DROP DATABASE IF EXISTS MovieIndustry;