CREATE DATABASE SchoolDB
USE SchoolDB
---1---
CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))
--2---
INSERT INTO Employees (EmpID,Name,Salary) VALUES (1, 'Bob', 505.99)
INSERT INTO Employees VALUES (2, 'Zack', 804.79)
INSERT INTO Employees VALUES (3, 'Eric', 650.78)
SELECT * FROM Employees
---3---
UPDATE Employees
SET Salary = 7000.00
WHERE EmpID = 1
---4---
DELETE FROM Employees
SELECT * FROM Employees
---5---
--DELETE IS DATA MANIPULATION LANGUAGE COMMAND, IT USES FOR DELETE ALL DATA IN TABLE OR SPECIFIC ROWS OR COLUMNS BUT STRUCTURE REMAINS THE SAME 
--DROP IS DATA DEFINITION LANSUAGE COMMAND, IT USES FOR REMOVE THE DATA STRUCTURE 
--TRUNCATE IS DATA DEFINITION LANGUAGE COMMAND, all data in the table but structure remains the same 

---6---
ALTER TABLE Employees
ALTER COLUMN NAME VARCHAR(100)
---7---
ALTER TABLE Employees
ADD Department VARCHAR(50);
SELECT * FROM Employees
---8---
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT
---9---
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))
SELECT * FROM Departments
---10---
TRUNCATE TABLE Employees
SELECT * FROM Employees
---11---
INSERT INTO Departments (DepartmentID,DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'Bugxalteriya'
UNION ALL
SELECT 3, 'IT'
UNION ALL
SELECT 4, 'Security'
UNION ALL
SELECT 5, 'Sotuv bolimi';
SELECT * FROM Departments
---12---
UPDATE Employees
SET Department = 'Management'
WHERE Salary >5000
---13---
DELETE FROM Employees
---14---
ALTER TABLE Employees
DROP COLUMN Department
---15---
EXEC sp_rename 'Employees', 'StaffMembers'
---16---
DROP TABLE Departments
---17---
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(100),Category VARCHAR(100), Price DECIMAL(10,2))
SELECT * FROM Products
---18---
SELECT * FROM Products
ALTER TABLE Products 
ADD CONSTRAINT Check_POS
CHECK (Price > 0)
---19---
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50 WITH VALUES
---20---
EXEC sp_rename  'SchoolDB.dbo.Employees', 'ProductCategory', 'COLUMN'
SELECT * from Products
---21---

INSERT INTO Products (ProductID, ProductName, Category, Price )
VALUES (1, 'Laptop', 'Electronics', 1200.00)

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES (2, 'Pen', 'SchoolThings', 1.00)

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES (3, 'Phone', 'Electronics', 800.00)

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES (4, 'Notebook', 'SchoolThings', 2.50)

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES (5, 'Charger', 'Electronics', 102.0)

SELECT * FROM Products
---22---
SELECT * INTO Products_Backup
FROM Products;

---23---
EXEC sp_rename 'Products', 'Inventory'
---24---
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT
---25--- 
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, StockQuantity FROM Inventory
DROP TABLE Inventory
EXEC sp_rename 'Inventory_New', 'Inventory'











