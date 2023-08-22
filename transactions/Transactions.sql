-- Transactions allow you to batch together SQL statements as an indivisible set that either succeeds or has no effect on the database.

-- Syntax to Start & Commit a Transaction
START TRANSACTION;

** – SQL statements

COMMIT;

-- Syntax to Start & Rollback a Transaction
START TRANSACTION;

** – SQL statements

ROLLBACK;

-- we can explicitly start a transaction and then either proceed to commit it or roll it back. Consider the following sequence of commands:

START TRANSACTION;

UPDATE Actors 
SET Id = 100 
WHERE FirstName = "Brad";

COMMIT;

-- Now we’ll start a transaction but roll it back midway and observe the changes that don’t take place.

START TRANSACTION;

UPDATE Actors 
SET Id = 200 
WHERE FirstName = "Tom";

ROLLBACK;

-- LOCKING

-- Irrespective of whether transactions are supported or not, the database system has to implement some sort of a locking mechanism to protect tables from
--  being modified by multiple users at the same time. 
--  There are various levels of sophistication built into database engines on how to handle concurrent users. 
--  For instance, in the case of MyISAM, the entire table gets locked, while InnoDB provides granular locking at the row level. 
--  You can view all the available types of storage engines on your version of MySQL as follows:

SHOW ENGINES;

-- EXPLAIN

-- The EXPLAIN statement is sort of a dry-run of your query or the blueprint/plan of how the server plans to execute your query. 
-- Generally, when complicated queries exhibit performance degradation, we can use the EXPLAIN statement to seek and identify bottlenecks.

-- Note that EXPLAIN and DESCRIBE are synonyms, however, as a convention EXPLAIN is used with queries whereas DESCRIBE is with structures.

-- Syntax#
EXPLAIN <SQL Statement>;

EXPLAIN SELECT * FROM Actors;

DESCRIBE SELECT Id FROM Actors;

-- FOREIGN KEYS

-- A foreign key can be a column or a group of columns in a table that link to a column or a group of columns in another table. 
-- In this case, the Actors table is the referenced table and called the parent table, whereas, the referencing table DigitalAssets is called the child table.

-- Example Syntax
CREATE TABLE childTable (

col1 <dataType>,

col2 <dataType>,

CONSTRAINT fkConstraint

FOREIGN KEY (col2)

REFERENCES parentTable(referencedCol);

-- We can declare a column as a foreign key in a child table only if the column has an index defined on it,
--  i.e., the column is defined as a primary key, unique or key column in the parent table.

ALTER TABLE DigitalAssets
ADD FOREIGN KEY (ActorId)
REFERENCES Actors(Id);