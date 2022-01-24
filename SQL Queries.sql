--Database to use.
USE Master
GO

--Check if a table exists and create one if its not in the DB.
 IF NOT EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(SCHEMA_ID) = 'dbo' AND NAME = 'Employees')
	--Creates a users table.
	CREATE TABLE Employees
	(
		Age INT NULL,
		Address VARCHAR(250) NULL,
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		FirstName VARCHAR(50) NOT NULL,
		LastName VARCHAR(50) NOT NULL,
	)

-- ALternative for the above to check if a table exists.
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'Employees'

--Inserts data into the tables
INSERT INTO Employees(FirstName, LastName) VALUES ('Charde', 'Marshall');
INSERT INTO Employees(FirstName, LastName, Age) VALUES ('Garrett ', 'Winters',24);
INSERT INTO Employees(FirstName, LastName, Age) VALUES ('Tatyana', 'Fitzpatrick', 21);
INSERT INTO Employees(FirstName, LastName) VALUES ('Gloria', 'Little');
INSERT INTO Employees(FirstName, LastName,Age) VALUES ('Afrifa', 'Evette',18);
INSERT INTO Employees(FirstName, LastName,Age) VALUES ('Adu', 'Ivy', 45);
INSERT INTO Employees(FirstName, LastName, Age) VALUES ('Opoku', 'Berlinda', 32);


 --Updates age column for the given employee, If its null
	UPDATE dbo.Employees
	SET Age = 40
	WHERE ID = 1 AND AGE IS NULL

--Simple select on where condition
SELECT * from Employees WHERE AGE IS NULL 

--Conditional check for age column, add a new column that hold the age group
/* Print as role based on the condition
	Intern , Age < 21
	Software Developer, Age 21- 29
	Manager, Age  29 - 45
	Director Age > 45
*/
SELECT *,
	CASE 
		WHEN e.Age <= 21 THEN 'Intern'
		WHEN e.Age > 21 AND e.Age <= 29 THEN 'Software Developer'
		WHEN e.Age > 29 AND e.Age< 45 THEN 'Manager'
		ELSE 'Director'
	END AS Role
from Employees e
WHERE AGE IS NOT NULL

/*Print the Count of employees whose age is between the age 20-40*/
SELECT 
	COUNT(*)AGE
FROM Employees
WHERE AGE IS NOT NULL AND AGE >= 20 AND AGE <=40

/*Print 
	- age along with the numbers of people of each age 
	- of age abvoe 40
*/
SELECT AGE, COUNT(*)AGE FROM Employees
GROUP BY AGE
HAVING COUNT(*) >= 1

SELECT AGE, COUNT(*)AGE FROM Employees
WHERE Age > 40
GROUP BY AGE
HAVING COUNT(*) >= 1

 -- Ascending order by age all employees
SELECT * FROM Employees 
ORDER BY AGE ASC



/* 
- Change Column Name
- Change Column Type
-
*/
 


/* Changes entire FirstName column data to 'First Name' without where*/
Update Employees
SET FirstName = 'First Name'
--WHERE ID = 7

/*
Truncate Vs Delete
*/

-- Truncate delets all the data in a table and cannot ,No WHERE Clause on Truncate
TRUNCATE Table Employees

-- Deletes records if matches either of the conditions
DELETE FROM Employees where ID = 2 OR FirstName = 'Mounika'
