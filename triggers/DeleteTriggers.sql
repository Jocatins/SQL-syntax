-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
CREATE TABLE ActorsArchive (
       RowId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
       DeletedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
AS (SELECT * FROM Actors WHERE 1=2);

-- Query 2
DELIMITER **
CREATE TRIGGER BeforeActorsDelete
BEFORE DELETE
ON Actors
FOR EACH ROW
BEGIN
  INSERT INTO ActorsArchive 
         (Id, Firstname, SecondName, DoB, Gender, MaritalStatus, NetWorthInMillions)
  VALUES (OLD.Id, OLD.Firstname, OLD.SecondName, OLD.DoB, OLD.Gender, OLD.MaritalStatus, OLD.NetWorthInMillions);
END **
DELIMITER ;

-- Query 3
DELETE FROM Actors
WHERE NetWorthInMillions < 150;

-- Query 4
DELIMITER **
CREATE TRIGGER AfterActorsDelete
AFTER DELETE ON Actors 
FOR EACH ROW
BEGIN
   DECLARE TotalWorth, RowsCount INT;
   
   INSERT INTO ActorsLog
   SET ActorId = OLD.Id, FirstName = OLD.FirstName, LastName =  OLD.SecondName, DateTime = NOW(), Event = 'DELETE';
   SELECT SUM(NetWorthInMillions) INTO TotalWorth
   FROM Actors;
   SELECT COUNT(*) INTO RowsCount
   FROM Actors;
 
   UPDATE NetWorthStats
   SET AverageNetWorth = ((Totalworth) / (RowsCount));
END **
DELIMITER ;

-- Query 5
DELETE FROM Actors
WHERE Id = 13;
 
SELECT * FROM NetWorthStats;
SELECT * FROM ActorsLog;