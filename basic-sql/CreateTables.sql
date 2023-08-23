

-- Query 1
CREATE TABLE Actors (
FirstName VARCHAR(20),
SecondName VARCHAR(20),
DoB DATE,
Gender ENUM('Male','Female','Other'),
MaritalStatus ENUM('Married', 'Divorced', 'Single'),
NetWorthInMillions DECIMAL);

-- Query 2
SHOW TABLES;

-- We can inspect the Actors table we just created using the following command:

-- Query 3
DESC Actors;

-- Query 1
CREATE TABLE Actors (
Id INT AUTO_INCREMENT,
FirstName VARCHAR(20) NOT NULL,
SecondName VARCHAR(20) NOT NULL,
DoB DATE NOT NULL,
Gender ENUM('Male','Female','Other') NOT NULL,
MaritalStatus ENUM('Married', 'Divorced', 'Single', 'Unknown') DEFAULT "Unknown",
NetWorthInMillions DECIMAL NOT NULL,
PRIMARY KEY (Id));

-- Query 2
CREATE TABLE IF NOT EXISTS Actors (
Id INT AUTO_INCREMENT,
FirstName VARCHAR(20) NOT NULL,
SecondName VARCHAR(20) NOT NULL,
DoB DATE NOT NULL,
Gender ENUM('Male','Female','Other') NOT NULL,
MaritalStatus ENUM('Married', 'Divorced', 'Single', 'Unknown') DEFAULT "Unknown",
NetWorthInMillions DECIMAL NOT NULL,
PRIMARY KEY (Id));