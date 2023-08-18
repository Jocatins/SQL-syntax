-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE InsertDigitalAssets(
    IN Id INT,
    IN Asset VARCHAR (100),
    IN Type VARCHAR (25))
BEGIN
    DECLARE CONTINUE HANDLER FOR 1062
    BEGIN
    SELECT 'Duplicate key error occurred' AS Message;
    END;
 
    INSERT INTO DigitalAssets(URL, AssetType, ActorID) VALUES(Asset, Type, Id);
 
    SELECT COUNT(*) AS AssetsOfActor
    FROM DigitalAssets
    WHERE ActorId = Id;
END**
DELIMITER ;

-- Query 2
CALL InsertDigitalAssets(10, 'https://instagram.com/iamsrk','Instagram');
CALL InsertDigitalAssets(10, 'https://instagram.com/iamsrk','Instagram');

-- Query 3
DROP PROCEDURE InsertDigitalAssets;
DELIMITER **
CREATE PROCEDURE InsertDigitalAssets(
    IN Id INT,
    IN Asset VARCHAR (100),
    IN Type VARCHAR (25))
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
    SELECT 'Duplicate key error occurred' AS Message;
    END;
 
    INSERT INTO DigitalAssets(URL, AssetType, ActorID) VALUES(Asset, Type, Id);
 
    SELECT COUNT(*) AS AssetsOfActor
    FROM DigitalAssets
    WHERE ActorId = Id;
END**
DELIMITER ;
 
CALL InsertDigitalAssets(10, 'https://instagram.com/iamsrk','Instagram');

-- Query 4
CREATE PROCEDURE abc()
BEGIN END;

CREATE PROCEDURE abc()
BEGIN END;

-- Query 5
DELIMITER **
CREATE PROCEDURE HandlerScope( )
BEGIN
    BEGIN -- inner block
       DECLARE CONTINUE HANDLER FOR 1048 
        SELECT 'Value cannot be NULL' AS Message;
    END;
    INSERT INTO DigitalAssets(URL) VALUES (NULL);
END**
DELIMITER ;

CALL HandlerScope();

-- Query 6
DELIMITER **
CREATE PROCEDURE proc1()
BEGIN
   DECLARE CONTINUE HANDLER FOR 1048 
    SELECT 'Value cannot be NULL' AS Message;
   CALL proc2();    
END**
DELIMITER ;

DELIMITER **
CREATE PRoCEDURE proc2()
BEGIN
    INSERT INTO DigitalAssets(URL) VALUES (NULL);
END**
DELIMITER ;

CALL proc1();