-- Except for the primary key in our Actors table, every other column can have repeating values. 
-- For instance, the marital status is repeated amongst the Actors and if we wanted to see all the possible marital statuses in the table 
-- we could use the following query:

SELECT DISTINCT MaritalStatus from Actors;

-- The DISTINCT clause applies to all the selected columns in the output rows. 
-- For instance, if we add the column FirstName to the select query above, the result will consist of all the rows because each pair (MaritalStatus, FirstName) is unique.


SELECT DISTINCT MaritalStatus, FirstName from Actors;