-- It is possible to create triggers on a table whose action time and event are the same. 
-- Such triggers are fired in a sequence that is specified at the time of creation of the triggers. 
-- The FOLLOWS and PRECEDES keywords are used to define the sequence in which triggers associated with a table having the same action time and event execute.

-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
CREATE TABLE GenderSummary (
  TotalMales INT NOT NULL,
  TotalFemales INT NOT NULL
);
 
CREATE TABLE MaritalStatusSummary (
  TotalSingle INT NOT NULL,
  TotalMarried INT NOT NULL,
  TotalDivorced INT NOT NULL
);
 
CREATE TABLE ActorsTableLog (
  RowId INT AUTO_INCREMENT PRIMARY KEY,
  ActorId INT NOT NULL,
  Detail VARCHAR(100) NOT NULL,
  UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Query 2
INSERT INTO GenderSummary (TotalMales, TotalFemales) 
Values ((SELECT COUNT(Gender) FROM Actors WHERE Gender = 'Male'),
        (SELECT COUNT(Gender) FROM Actors WHERE Gender = 'Female'));
 
SELECT * FROM GenderSummary;
 
INSERT INTO MaritalStatusSummary (TotalSingle, TotalMarried, TotalDivorced) 
Values ((SELECT COUNT(MaritalStatus) FROM Actors WHERE MaritalStatus = 'Single'),
        (SELECT COUNT(MaritalStatus) FROM Actors WHERE MaritalStatus = 'Married'),
        (SELECT COUNT(MaritalStatus) FROM Actors WHERE MaritalStatus = 'Divorced'));
 
SELECT * FROM MaritalStatusSummary;

-- Query 3
DELIMITER **
CREATE TRIGGER UpdateGenderSummary
AFTER INSERT
ON Actors 
FOR EACH ROW
BEGIN
DECLARE count INT;
IF NEW.Gender = 'Male' THEN
    UPDATE GenderSummary
   SET TotalMales = TotalMales+1;
   INSERT INTO ActorsTableLog (ActorId, Detail) 
   VALUES (NEW.Id, 'TotalMales value of GenderSummary table changed.');
ELSE  
   UPDATE GenderSummary
   SET TotalFemales = TotalFemales+1;
   INSERT INTO ActorsTableLog (ActorId, Detail) 
   VALUES (NEW.Id, 'TotalFemales value of GenderSummary table changed.');
END IF;
END  **
DELIMITER ;

-- Query 4
DELIMITER **
CREATE TRIGGER UpdateMaritalStatusSummary
AFTER INSERT
ON Actors 
FOR EACH ROW
FOLLOWS UpdateGenderSummary
BEGIN
DECLARE count INT;
IF NEW.MaritalStatus = 'Single' THEN
    UPDATE MaritalStatusSummary
   SET TotalSingle = TotalSingle+1;
   INSERT INTO ActorsTableLog (ActorId, Detail) 
   VALUES (NEW.Id, 'TotalSingle value of MaritalStatusSummary table changed.');
ELSEIF  NEW.MaritalStatus = 'Married' THEN
    UPDATE MaritalStatusSummary
   SET TotalMarried = TotalMarried+1;
   INSERT INTO ActorsTableLog (ActorId, Detail) 
   VALUES (NEW.Id, 'TotalMarried value of MaritalStatusSummary table changed.');
ELSE
   UPDATE MaritalStatusSummary
   SET TotalDivorced = TotalDivorced+1;
   INSERT INTO ActorsTableLog (ActorId, Detail) 
   VALUES (NEW.Id, 'TotalDivorced value of MaritalStatusSummary table changed.');
END IF;
END  **
DELIMITER ;

-- Query 5
INSERT INTO Actors (FirstName, SecondName, DoB, Gender, MaritalStatus,  NetWorthInMillions) 
VALUES ('Tom', 'Hanks', '1956-07-09', 'Male', 'Married', 350);
SELECT * FROM ActorsTableLog;

-- Query 6
SHOW TRIGGERS;

-- Query 7
SELECT
    trigger_name,
    action_order
FROM
    information_schema.triggers
WHERE
    trigger_schema = 'MovieIndustry';