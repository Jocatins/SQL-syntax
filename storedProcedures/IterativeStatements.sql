-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE PrintMaleActors(
       OUT str  VARCHAR(255))
BEGIN
  DECLARE TotalRows INT DEFAULT 0;
  DECLARE CurrentRow INT;
  DECLARE fname VARCHAR (25);
  DECLARE lname VARCHAR (25);
  DECLARE gen VARCHAR (10);

  SET CurrentRow = 1;
  SET str =  '';

  SELECT COUNT(*) INTO TotalRows 
  FROM Actors;

  Print_loop: LOOP
    IF CurrentRow > TotalRows THEN
      LEAVE Print_loop;
    END IF;

    SELECT Gender INTO gen 
    FROM Actors 
    WHERE Id = CurrentRow;

    IF gen NOT LIKE 'Male' THEN
      SET CurrentRow = CurrentRow + 1;
      ITERATE Print_loop;
    ELSE
      SELECT FirstName INTO fname 
      FROM Actors 
      WHERE Id = CurrentRow;

      SELECT SecondName INTO lname 
      FROM Actors 
      WHERE Id = CurrentRow;

      SET  str = CONCAT(str,fname,' ',lname,', ');
      SET CurrentRow = CurrentRow + 1;
    END IF;
  END LOOP Print_loop;
End **
DELIMITER ;

-- Query 2
CALL PrintMaleActors(@namestr);
SELECT @namestr AS MaleActors;

-- Query 3
DROP PROCEDURE PrintMaleActors;

DELIMITER **

CREATE PROCEDURE PrintMaleActors(
       OUT str  VARCHAR(255))
BEGIN

  DECLARE TotalRows INT DEFAULT 0;
  DECLARE CurrentRow INT;
  DECLARE fname VARCHAR (25);
  DECLARE lname VARCHAR (25);
  DECLARE gen VARCHAR (10);

  SET CurrentRow = 1;
  SET str =  '';

  SELECT COUNT(*) INTO TotalRows 
  FROM Actors;

  Print_loop: WHILE CurrentRow < TotalRows DO
    SELECT Gender INTO gen 
    FROM Actors 
    WHERE Id = CurrentRow;

    IF gen LIKE 'Male' THEN
      SELECT FirstName INTO fname 
      FROM Actors 
      WHERE Id = CurrentRow;

      SELECT SecondName INTO lname 
      FROM Actors 
      WHERE Id = CurrentRow;

      SET  str = CONCAT(str,fname,' ',lname,', ');
    END IF;
	
    SET CurrentRow = CurrentRow + 1;
  END WHILE Print_loop;
End **
DELIMITER ;

-- Query 4
CALL PrintMaleActors(@namestr);
SELECT @namestr AS MaleActors;

-- Query 5
DROP PROCEDURE PrintMaleActors;
DELIMITER **
CREATE PROCEDURE PrintMaleActors(
       OUT str  VARCHAR(255))
BEGIN
  DECLARE TotalRows INT DEFAULT 0;
  DECLARE CurrentRow INT;
  DECLARE fname VARCHAR (25);
  DECLARE lname VARCHAR (25);
  DECLARE gen VARCHAR (10);

  SET CurrentRow = 1;
  SET str =  '';

  SELECT COUNT(*) INTO TotalRows 
  FROM Actors;

  Print_loop: REPEAT 
    SELECT Gender INTO gen 
    FROM Actors 
    WHERE Id = CurrentRow;

    IF gen LIKE 'Male' THEN
      SELECT FirstName INTO fname 
      FROM Actors 
      WHERE Id = CurrentRow;

      SELECT SecondName INTO lname 
      FROM Actors 
      WHERE Id = CurrentRow;

      SET  str = CONCAT(str,fname,' ',lname,', ');
    END IF;
	
    SET CurrentRow = CurrentRow + 1;
    UNTIL CurrentRow > TotalRows
  END REPEAT Print_loop;
End **
DELIMITER ;

-- Query 6
CALL PrintMaleActors(@namestr);
SELECT @namestr AS MaleActors;