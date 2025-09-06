
CREATE DATABASE Lesson4
USE Lesson4
--1--
CREATE TABLE Employees (EmpID INT PRIMARY KEY, FirstName VARCHAR(40),LastName VARCHAR(40),DepartmentName VARCHAR(40), Age INT, Salary DECIMAL(10,2))
SELECT top (5) [EmpID], [LastName], [FirstName], [Age] from [Lesson4].[dbo].[Employees]
--2--
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(40), CategoryID INT,Price DECIMAL(10,2), Category Varchar(40))
SELECT DISTINCT Category from Products
--3--
SELECT Price from Products
WHERE Price > 100
--4--
CREATE TABLE Customers1 (ProductID INT PRIMARY KEY, Name VARCHAR(40), Department VARCHAR(40),)
SELECT * FROM department
WHERE NAME LIKE 'H%'
--5--
SELECT *
FROM Products
ORDER BY Price ASC
--6--
SELECT * FROM Employees
WHERE SALARY >= 60000 or DepartmentName = 'HR'
--7--
SELECT ISNULL(Email, 'noemail@example.com') AS Email FROM Employees
--8--
SELECT * FROM Employees
WHERE Salary between 50 and 100
--9--
SELECT DISTINCT Category,ProductName from Products
--10--
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC
--11--
SELECT top (5) [ProductName] from Products 
ORDER BY Price DESC 
--12--
SELECT COALESCE (FirstName, NULL, LastName) AS f_NAME FROM Employees
--13--
SELECT DISTINCT Category, Price
FROM Products
--14--
SELECT * FROM Employees
WHERE (Age BETWEEN 30 and 40) or DepartmentName = 'Marketing'
--15--
SELECT * FROM Employees
 ORDER BY Salary  DESC OFFSET 11 ROWS FETCH NEXT 20 ROWS ONLY
 --16--
 SELECT *FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC
--17--




