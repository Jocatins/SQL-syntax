-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE GetMaritalStatus(
    IN  ActorId INT, 
    OUT ActorStatus  VARCHAR(30))
BEGIN
    DECLARE Status VARCHAR (15);

    SELECT MaritalStatus INTO Status
    FROM Actors
    WHERE Id = ActorId;

    IF Status LIKE 'Married' THEN
        SET ActorStatus = 'Actor is married';
    END IF;
END**
DELIMITER ;

-- Query 2
CALL GetMaritalStatus(1, @status);
SELECT @status;
CALL GetMaritalStatus(5, @status);
SELECT @status;

-- Query 3
DROP PROCEDURE GetMaritalStatus;
DELIMITER **
CREATE PROCEDURE GetMaritalStatus(
    IN  ActorId INT, 
    OUT ActorStatus  VARCHAR(30))
BEGIN
    DECLARE Status VARCHAR (15);

    SELECT MaritalStatus INTO Status
    FROM Actors
    WHERE Id = ActorId;

    IF Status LIKE 'Married' THEN
        SET ActorStatus = 'Actor is married';
    ELSE
        SET ActorStatus = 'Actor is not married';
    END IF;
END **
DELIMITER ;

-- Query 4
CALL GetMaritalStatus(1, @status);
SELECT @status;
CALL GetMaritalStatus(5, @status);
SELECT @status;

-- Query 5
DROP PROCEDURE GetMaritalStatus;
DELIMITER **
CREATE PROCEDURE GetMaritalStatus(
    IN  ActorId INT, 
    OUT ActorStatus  VARCHAR(30))
BEGIN
    DECLARE Status VARCHAR (15);

    SELECT MaritalStatus INTO Status
    FROM Actors
    WHERE Id = ActorId;

    IF Status LIKE 'Married' THEN
        SET ActorStatus = 'Actor is married';
    ELSEIF Status LIKE 'Single' THEN
        SET ActorStatus = 'Actor is single';
    ELSEIF Status LIKE 'Divorced' THEN
        SET ActorStatus = 'Actor is divorced';
    ELSE
        SET ActorStatus = 'Status not found';
    END IF;
END **
DELIMITER ;

--Query 6
CALL GetMaritalStatus(1, @status);
SELECT @status;
CALL GetMaritalStatus(5, @status);
SELECT @status;
CALL GetMaritalStatus(6, @status);
SELECT @status;

-- Query 7
DROP PROCEDURE GetMaritalStatus;
DELIMITER **
CREATE PROCEDURE GetMaritalStatus(
	IN  ActorId INT, 
	OUT ActorStatus VARCHAR(30))
BEGIN
    DECLARE Status VARCHAR (15);

    SELECT MaritalStatus INTO Status
    FROM Actors 
    WHERE Id = ActorId;

    CASE Status
        WHEN 'Married' THEN
            SET ActorStatus = 'Actor is married';
        WHEN 'Single' THEN
	        SET ActorStatus = 'Actor is single';
        WHEN 'Divorced' THEN
            SET ActorStatus = 'Actor is divorced';
        ELSE
            SET ActorStatus = 'Status not found';
    END CASE;
END**
DELIMITER ;

-- Query 8
CALL GetMaritalStatus(1, @status);
SELECT @status;
CALL GetMaritalStatus(5, @status);
SELECT @status;
CALL GetMaritalStatus(6, @status);
SELECT @status;

-- Query 9
DELIMITER **
CREATE PROCEDURE GetAgeBracket(
       IN ActorId INT,
       OUT AgeRange VARCHAR(30))
BEGIN
    DECLARE age INT DEFAULT 0;

    SELECT TIMESTAMPDIFF(YEAR, DoB, CURDATE())
	INTO age
	FROM Actors
    WHERE Id = ActorId;
    
    CASE 
        WHEN age < 20 THEN 
            SET AgeRange = 'Less than 20 years';
        WHEN age >= 20 AND age < 30 THEN
            SET AgeRange = '20+';
        WHEN age >= 30 AND age < 40 THEN
            SET AgeRange = '30+';
        WHEN age >= 40 AND age < 50 THEN
            SET AgeRange = '40+';
        WHEN age >= 50 AND age < 60 THEN
            SET AgeRange = '50+';
        WHEN age >= 60 THEN
            SET AgeRange = '60+';
        ELSE
            SET AgeRange = 'Age not found';
	END CASE;	
END**
DELIMITER ;

-- Query 10
CALL GetAgeBracket(1, @status);
SELECT @status;
CALL GetAgeBracket(5, @status);
SELECT @status;