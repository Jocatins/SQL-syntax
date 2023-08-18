-- The lesson queries are reproduced below for convenient copy/paste into the terminal. 

-- Query 1
DELIMITER **
CREATE PROCEDURE PrintMaleActors(
       OUT str  VARCHAR(255))
BEGIN
  DECLARE fName VARCHAR(25);
  DECLARE lName VARCHAR(25);
  DECLARE LastRowFetched INTEGER DEFAULT 0;
  DEClARE Cur_MaleActors CURSOR FOR 
    SELECT FirstName, SecondName 
    FROM Actors 
    WHERE Gender = 'Male';
  DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET LastRowFetched = 1;

  SET str =  '';
  OPEN Cur_MaleActors;

  Print_loop: LOOP
    FETCH Cur_MaleActors INTO fName, lName;
    IF LastRowFetched = 1 THEN
      LEAVE Print_loop;
    END IF;
    SET  str = CONCAT(str,fName,' ',lName,', ');
  END LOOP Print_loop;

  CLOSE Cur_MaleActors;
  SET LastRowFetched = 0;
END **
DELIMITER ;

-- Query 2
CALL PrintMaleActors(@namestr);
SELECT @namestr AS MaleActors;