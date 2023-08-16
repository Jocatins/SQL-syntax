-- We can add multiple records using the INSERT statement.

INSERT INTO Actors ( 
FirstName, SecondName, DoB, Gender, MaritalStatus, NetworthInMillions) 

VALUES 

("Jennifer", "Aniston", "1969-11-02", "Female", "Single", 240.00),

("Angelina", "Jolie", "1975-06-04", "Female", "Single", 100.00),

("Johnny", "Depp", "1963-06-09", "Male", "Single", 200.00);

-- We can also use an alternative syntax to insert data into a table that doesn’t require listing out the column names.
-- For example:

INSERT INTO Actors 
VALUES (DEFAULT, "Dream", "Actress", "9999-01-01", "Female", "Single", 000.00);

-- When inserting a row into a table we can skip a column and instruct MySQL to populate it with the default value using the DEFAULT keyword.

INSERT INTO Actors VALUES (NULL, "Reclusive", "Actor", "1980-01-01", "Male", "Single", DEFAULT);


-- Another interesting aspect is we can insert a row with all default values. 
-- If a column doesn’t have a default value defined, it is assigned NULL as default.

-- Another way to add rows to a table is to use the column name and the value together. This alternative syntax makes use of the SET keyword:

INSERT INTO Actors SET DoB="1950-12-12", FirstName="Rajnikanth", SecondName="",  Gender="Male", NetWorthInMillions=50,  MaritalStatus="Married";