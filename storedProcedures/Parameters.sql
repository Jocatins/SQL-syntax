-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE GetActorsByNetWorth(IN NetWorth INT )
BEGIN
	SELECT * FROM Actors
	WHERE NetWorthInMillions >= NetWorth;
END **
DELIMITER ;

-- Query 2
CALL GetActorsByNetWorth(500);
CALL GetActorsByNetWorth(750);

-- Query 3
CALL GetActorsByNetWorth();

-- Query 4
DELIMITER **
CREATE PROCEDURE GetActorCountByNetWorth (
	IN  NetWorth INT,
	OUT ActorCount INT)
BEGIN
	SELECT COUNT(*) INTO ActorCount
	FROM Actors
	WHERE NetWorthInMillions >= NetWorth;
END**
DELIMITER ;

-- Query 5
CALL GetActorCountByNetWorth(500, @ActorCount);
SELECT @ActorCount;

-- Query 6
DELIMITER **
CREATE PROCEDURE IncreaseInNetWorth(
	INOUT Increase INT,
	IN ActorId INT )
BEGIN
	DECLARE OriginalNetWorth INT;

	SELECT NetWorthInMillions Into OriginalNetWorth
    FROM Actors 
	WHERE Id = ActorId;

	SET Increase = OriginalNetWorth + Increase;	
END**
DELIMITER ;

-- Query 7
SET @IncreasedWorth = 50;
CALL IncreaseInNetWorth(@IncreasedWorth, 11);
SELECT @IncreasedWorth;

-- Query 8
DELIMITER **
CREATE PROCEDURE GenderCountByNetWroth(
	IN NetWorth INT,
	OUT MaleCount INT,
	OUT FemaleCount INT)
BEGIN
        SELECT COUNT(*) INTO MaleCount
        FROM Actors
        WHERE NetWorthInMillions >= NetWorth
              AND Gender = 'Male';

	SELECT COUNT(*) INTO FemaleCount
        FROM Actors
        WHERE NetWorthInMillions >= NetWorth
              AND Gender = 'Female';
END**
DELIMITER ;

-- Query 9
CALL GenderCountByNetWroth(500, @Male, @Female);
SELECT @Male, @Female;