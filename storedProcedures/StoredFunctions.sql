-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
 
CREATE FUNCTION DigitalAssetCount(
    ID INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE ReturnMessage VARCHAR(50);
    DECLARE Number INT DEFAULT 0;
    SELECT COUNT(*) INTO Number FROM DigitalAssets WHERE ActorId = ID;
 
    IF Number = 0 THEN
        SET ReturnMessage = 'The Actor does not have any digital assets.';
    ELSE
        SET ReturnMessage = CONCAT('The Actor has ', Number, ' digital assets');
    END IF;
    
    -- return the customer level
    RETURN (ReturnMessage);
END**
DELIMITER ;

-- Query 2
SHOW FUNCTION STATUS;

-- Query 3
SHOW FUNCTION STATUS
WHERE db = 'MovieIndustry';

-- Query 4
SHOW FUNCTION STATUS 
LIKE '%Count%';

-- Query 5
SELECT Id, DigitalAssetCount(Id) AS Count
FROM Actors;

-- Query 6
DELIMITER **
CREATE PROCEDURE GetDigitalAssetCount(
    IN  ActorNo INT,  
    OUT Message VARCHAR(50))
BEGIN
    DECLARE Number INT DEFAULT 0;
    SET Number = ActorNo;    
    SET Message = DigitalAssetCount(Number);
END**
DELIMITER ;

-- Query 7
CALL GetDigitalAssetCount(10,@assetcount);
SELECT @assetcount;

-- Query 8
DELIMITER **
CREATE FUNCTION TimeSinceLastUpdate(
                ID INT,
                Asset VARCHAR(15)) 
RETURNS INT
NOT DETERMINISTIC
BEGIN
    DECLARE ElapsedTime INT;
    SELECT TIMESTAMPDIFF(SECOND, LastUpdatedOn, NOW())
    INTO ElapsedTime
    FROM DigitalAssets
    WHERE ActorID = ID AND AssetType = Asset;
    RETURN ElapsedTime;
END**
DELIMITER ;

-- Query 9
SELECT TimeSinceLastUpdate(1,'Instagram');

-- Query 10
SELECT routine_name
FROM information_schema.routines
WHERE routine_type = 'FUNCTION' AND routine_schema = 'MovieIndustry';

-- Query 11
DROP FUNCTION DigitalAssetCount;
DROP FUNCTION IF EXISTS DigitalAssetCount;
SHOW WARNINGS;