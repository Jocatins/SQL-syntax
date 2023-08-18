-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
CREATE TABLE DigitalActivity (
RowID INT AUTO_INCREMENT PRIMARY KEY,
ActorID INT NOT NULL,
Detail VARCHAR(100) NOT NULL,
UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Query 2
DELIMITER **
 
CREATE TRIGGER BeforeDigitalAssetUpdate
BEFORE UPDATE
ON DigitalAssets 
FOR EACH ROW
BEGIN
 DECLARE errorMessage VARCHAR(255);
 
 IF NEW.LastUpdatedOn < OLD.LastUpdatedOn THEN
   SET errorMessage = CONCAT('The new value of LastUpatedOn column: ', 
     NEW.LastUpdatedOn,' cannot be less than the current value: ', 
     OLD.LastUpdatedOn);
 
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT = errorMessage;
 END IF;
 
 IF NEW.LastUpdatedOn != OLD.LastUpdatedOn THEN
   INSERT into DigitalActivity (ActorId, Detail)
   VALUES (New.ActorId, CONCAT('LastUpdate value for ',NEW.AssetType,
          ' is modified from ',OLD.LastUpdatedOn, ' to ', 
          NEW.LastUpdatedOn));   
 END IF;
END **
DELIMITER ;

-- Query 3
UPDATE DigitalAssets 
SET LastUpdatedOn = '2020-02-15 22:10:45'
WHERE ActorID = 2 AND Assettype = 'Website';
 
UPDATE DigitalAssets 
SET LastUpdatedOn = '2018-01-15 22:10:45'
WHERE ActorID = 5 AND AssetType = 'Pinterest';
 
SELECT * FROM DigitalActivity;

-- Query 4
DELIMITER **
CREATE TRIGGER AfterActorUpdate
AFTER UPDATE ON Actors 
FOR EACH ROW
BEGIN
   DECLARE TotalWorth, RowsCount INT;
   INSERT INTO ActorsLog
   SET ActorId = NEW.Id, FirstName = New.FirstName, LastName =  NEW.SecondName, DateTime = NOW(), Event = 'UPDATE';
 
  IF NEW.NetWorthInMillions != OLD.NetWorthInMillions THEN
    SELECT SUM(NetWorthInMillions) INTO TotalWorth
    FROM Actors;
    SELECT COUNT(*) INTO RowsCount
    FROM Actors;
 
    UPDATE NetWorthStats
    SET AverageNetWorth = ((Totalworth) / (RowsCount));
END IF;
END **
DELIMITER ;

-- Query 5
SELECT * FROM NetWorthStats;
 
UPDATE Actors
SET NetWorthInMillions = '100'
WHERE Id = 5;
 
SELECT * FROM NetWorthStats;
SELECT * FROM ActorsLog;

-- Query 6
UPDATE Actors
SET MaritalStatus = 'Single'
WHERE Id = 7;
 
SELECT * FROM NetWorthStats;
SELECT * FROM ActorsLog;