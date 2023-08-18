-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE AddActor(
        IN Name1 VARCHAR(20),
        IN Name2 VARCHAR(20), 
        IN Birthday DATE,
        IN networth INT )
BEGIN
    DECLARE age INT DEFAULT 0;
    SELECT TIMESTAMPDIFF (YEAR, Birthday, CURDATE())
    INTO age;
 
    IF(age < 1) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Incorrect DoB value. Age cannot be zero or less than zero';
    END IF;
    
    IF(networth < 1) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Incorrect NetWorth value. Net worth cannot be zero or less than zero';
    END IF;
    -- If all ok then INSERT a row in the Actors table
    INSERT INTO Actors (FirstName, SecondName, Dob, NetWorthInMillions) 
    VALUES(Name1, Name2, Birthday, networth);
END **
DELIMITER ;

-- Query 2
CALL AddActor('Jackson','Samuel','2020-12-21', 250);
CALL AddActor('Jackson','Samuel','1948-12-21', 0);

-- Query 3
DROP PROCEDURE AddActor;
DELIMITER **
CREATE PROCEDURE AddActor(
        IN Name1 VARCHAR(20),
        IN Name2 VARCHAR(20), 
        IN Birthday DATE,
        IN networth INT)
BEGIN
    DECLARE age INT DEFAULT 0;
    DECLARE InvalidValue CONDITION FOR SQLSTATE '45000';
 
    DECLARE CONTINUE HANDLER FOR InvalidValue 
    IF age < 1 THEN
        RESIGNAL;
    ELSEIF networth < 1 THEN
        RESIGNAL;
    END IF;
 
    SELECT TIMESTAMPDIFF (YEAR, Birthday, CURDATE())
    INTO age;
      
    IF age < 1 THEN
        SIGNAL InvalidValue;
    ELSEIF networth < 1 THEN
        SIGNAL InvalidValue;
    ELSE
        INSERT INTO Actors (FirstName, SecondName, Dob, NetWorthInMillions) 
        VALUES(Name1, Name2, Birthday, networth);
    END IF;
END **
DELIMITER ;

-- Query 4
CALL AddActor('Jackson','Samuel','2020-12-21', 250);
CALL AddActor('Jackson','Samuel','1948-12-21', 0);

-- Query 5
DROP PROCEDURE AddActor;
DELIMITER **
CREATE PROCEDURE AddActor(
        IN FirstName varchar(20),
        IN SecondName varchar(20), 
        IN DoB date,
        IN networth int )
BEGIN
    DECLARE age INT DEFAULT 0;
    DECLARE InvalidValue CONDITION FOR SQLSTATE '45000';
 
    DECLARE CONTINUE HANDLER FOR InvalidValue
        IF age < 1 THEN 
            RESIGNAL SET MESSAGE_TEXT = 'Incorrect DoB value. Age cannot be zero or less than zero';
        ELSEIF networth < 1 THEN 
            RESIGNAL SET MESSAGE_TEXT = 'Incorrect NetWorth value. Net worth cannot be zero or less than zero';
        END IF;
    
    SELECT TIMESTAMPDIFF (YEAR, DoB, CURDATE())
    INTO age;
 
    IF age < 1 THEN 
        SIGNAL InvalidValue;
    ELSEIF networth < 1 THEN 
        SIGNAL InvalidValue;
    ELSE
        INSERT INTO Actors (FirstName, SecondName, Dob, NetWorthInMillions) 
        VALUES(Name1, Name2, Birthday, networth);
    END IF;
END **
DELIMITER ;

-- Query 6
CALL AddActor('Jackson','Samuel','2020-12-21', 250);
CALL AddActor('Jackson','Samuel','1948-12-21', 0);
