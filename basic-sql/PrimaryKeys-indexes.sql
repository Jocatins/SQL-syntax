-- We can use the following query to display the indexes on a table:

ANALYZE TABLE Actors;
SHOW INDEX FROM Actors;

-- Query 3
INSERT INTO Actors (Id, FirstName, SecondName,DoB, Gender, MaritalStatus, NetWorthInMillions) VALUES (15, "First","Row", "1999-01-01", "Male", "Single",0.00);
INSERT INTO Actors (Id, FirstName, SecondName,DoB, Gender, MaritalStatus, NetWorthInMillions) VALUES (13, "Second","Row", "1999-01-01", "Male", "Single",0.00);
INSERT INTO Actors (Id, FirstName, SecondName,DoB, Gender, MaritalStatus, NetWorthInMillions) VALUES (12, "Third","Row", "1999-01-01", "Male", "Single",0.00);

-- You can view the available storage engines as follows:

SHOW ENGINES;