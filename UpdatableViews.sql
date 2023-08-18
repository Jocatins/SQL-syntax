-- Say we want to update the net worth of Brad Pitt to 250 million dollars. This can be done with the following query:


UPDATE ActorView 
SET 
NetWorthInMillions = 250 
WHERE 
Id =1;

-- To find out which views in the database are updatable we can query the views table in the information_schema database. 
-- This table has a column is_updatable that indicates the type of view. 
-- Execute the following query to find out the updatable views in the MovieIndustry database:

SELECT Table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'MovieIndustry';

DELETE FROM ActorView
WHERE Id = 11;