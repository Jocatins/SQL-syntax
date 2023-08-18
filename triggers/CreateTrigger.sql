-- Syntax#
CREATE TRIGGER trigger_name trigger_time trigger_event

ON table_name

FOR EACH ROW

trigger_body

DROP TRIGGER [IF EXISTS] [database_name.]trigger_name;

-- One of the basic uses of triggers is to validate the user input. 
-- Let’s create such a trigger on the Actors table. 
-- The purpose of our trigger is to check the value for NetWorthInMillions column before the record is inserted in the Actors table. 
-- In case the value is not specified, or if the user provides a non negative value by mistake, it will be set the value to zero. 
-- We will define the trigger NetWorthCheck as follows:

DELIMITER **
CREATE TRIGGER NetWorthCheck
BEFORE INSERT ON Actors
FOR EACH ROW 
 IF  NEW.NetWorthInMillions < 0 OR NEW.NetWorthInMillions IS NULL
THEN SET New.NetWorthInMillions = 0;
END IF;
**
DELIMITER ;

-- To display the triggers in a database SHOW TRIGGERS command is used.

SHOW TRIGGERS;

-- To delete the trigger, use the following statement:

DROP TRIGGER IF EXISTS NetWorthCheck;