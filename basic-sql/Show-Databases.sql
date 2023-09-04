-- To Show databases

SHOW DATABASES;

-- to explore a particular database, we need to tell the DBMS that we want our queries directed to the database of our choice. 

use DataBase_Name;

-- The USE statements allow us to let MySQL know the database we want to interact with.

-- We can examine how the database was created using the following query:

SHOW CREATE DATABASE DataBase_Name;

-- to know what tables the database holds.

SHOW TABLES;

-- We can also explore the structure of a table using the DESCRIBE command. Let’s describe the table as follows with this 

DESCRIBE user; 

-- We can also use the SHOW statement to display how the table was created. For instance, the following query shows how the servers table was created:

SHOW CREATE TABLE servers;

-- We can display the column information for a table using the SHOW statement. For example:

SHOW COLUMNS FROM servers;

-- VARCHAR(20)
-- The number twenty within brackets specifies the maximum length of string we intend to store.
-- The absolute maximum for VARCHAR is 65,535 characters.
-- Instead of VARCHAR we could have used CHAR but the difference between CHAR and VARCHAR is that the former is fixed length whereas the latter is variable length.
-- If we specify CHAR(20), it will imply the name is always stored as twenty characters with spaces even if the name consists of only four characters.

create an Actors table

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

-- We can also use the IF EXISTS clause when creating a table, similar to the way we did when creating a database.

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