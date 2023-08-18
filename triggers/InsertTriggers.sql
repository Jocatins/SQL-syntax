-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
CREATE TABLE NetWorthStats (
AverageNetWorth DECIMAL(10,4)
);
INSERT INTO NetWorthStats(AverageNetWorth) 
Values ((SELECT AVG(NetWorthInMillions) FROM Actors));

-- Query 2
DELIMITER **
CREATE TRIGGER BeforeActorsInsert
BEFORE INSERT ON Actors 
FOR EACH ROW
BEGIN
  DECLARE TotalWorth, RowsCount INT;
          
  SELECT SUM(NetWorthInMillions) INTO TotalWorth
  FROM Actors;
  SELECT COUNT(*) INTO RowsCount
  FROM Actors;
 
  UPDATE NetWorthStats
  SET AverageNetWorth = ((Totalworth + new.NetWorthInMillions) / (RowsCount+1));
END **
DELIMITER ;

-- Query 3
INSERT INTO Actors (FirstName, SecondName, DoB, Gender, MaritalStatus, NetWorthInMillions) 
VALUES ('Charlize', 'Theron', '1975-08-07', 'Female', 'Single', 130);
 
SELECT * FROM NetWorthStats;

-- Query 4
CREATE TABLE ActorsLog (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    ActorId INT NOT NULL,
    FirstName VARCHAR(20),    
    LastName VARCHAR(20),
    DateTime DATETIME DEFAULT NULL,
    Event VARCHAR(50) DEFAULT NULL
);

-- Query 5
CREATE TRIGGER AfterActorsInsert 
AFTER INSERT ON Actors
FOR EACH ROW 
INSERT INTO ActorsLog
SET ActorId = NEW.Id, 
    FirstName = New.FirstName, 
    LastName = NEW.SecondName, 
    DateTime = NOW(), 
    Event = 'INSERT';

-- Query 6
INSERT INTO Actors (FirstName, SecondName, DoB, Gender, MaritalStatus, NetWorthInMillions) 
VALUES ('Matt', 'Damon', '1970-10-08', 'Male', 'Married', 160);
 
SELECT * FROM ActorsLog;