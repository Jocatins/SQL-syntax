CREATE [OR REPLACE] VIEW view_name AS

select_statement

SHOW, DROP & RENAME Views

-- Syntax
SHOW FULL TABLES

{FROM | IN} db_name

WHERE table_type = ‘VIEW’

LIKE pattern;

DROP VIEW [IF EXISTS] view1, view2,…viewn;

RENAME TABLE old_name

TO new_name;

SHOW FULL TABLES
WHERE table_type = 'VIEW';

-- The LIKE operator can be used to shortlist views based on a word or pattern.

SHOW FULL TABLES
LIKE '%Actor%';


-- The information_schema database is a catalogue of all MYSQL databases and contains metadata such as database names, 
-- tables, privileges, and datatypes of columns, etc. 
-- A query against this database can also list all views of a particular database as follows:

SELECT table_name
FROM information_schema.TABLES
WHERE table_type = 'VIEW'
AND table_schema = 'MovieIndustry';

DROP VIEW IF EXISTS DigitalAssetCount, ActorAssets;

DROP VIEW DigitalAssetCount, ActorAssets;

-- To show how RENAME works, we will create a view as follows:

CREATE VIEW ActorAge AS
SELECT * 
FROM Actors 
WHERE TIMESTAMPDIFF(YEAR, DoB, CURDATE()) > 50; 

-- Next, we will change its name to ActorsOlderThan50.

RENAME TABLE ActorAge
TO ActorsOlderThan50;