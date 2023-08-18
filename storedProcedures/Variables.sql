-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE Summary()
BEGIN
	DECLARE TotalM, TotalF INT DEFAULT 0;
    DECLARE AvgNetWorth DEC(6,2) DEFAULT 0.0;
    
    SELECT COUNT(*) INTO TotalM
    FROM Actors
    WHERE Gender = 'Male';
    
    SELECT COUNT(*) INTO TotalF
    FROM Actors
    WHERE Gender = 'Female';
    
    SELECT AVG(NetWorthInMillions) INTO AvgNetWorth
    FROM Actors;
    
    SELECT TotalM, TotalF, AvgNetWorth;
END**
DELIMITER ;

-- Query 2
CALL Summary();