
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
--17--
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(40), CategoryID INT,Price DECIMAL(10,2), Category Varchar(40))
SELECT * FROM Products
WHERE ProductName LIKE '%e%'
--18--
CREATE TABLE Employees (EmpID INT PRIMARY KEY, FirstName VARCHAR(40),LastName VARCHAR(40),DepartmentName VARCHAR(40), Age INT, Salary DECIMAL(10,2))
ALter table Employees
ADD  Department Varchar(45)
SELECT * FROM Employees
WHERE Department in ('HR', 'IT', 'Finance')
--19--
ALter table Employees
ADD  City Varchar(45), PostalCode int 
SELECT * FROM Customers
ORDER BY City ASC, Postalcode DESC

--20--
SELECT TOP (5) *
FROM Products
ORDER BY SaleAmount DESC
--21--
SELECT FirstName + ' ' + LastName AS FullName
FROM Employees
--22--
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50
--23--
SELECT *
FROM Products
WHERE Price < 0.10 * (SELECT AVG(Price) FROM Products);
--24--
SELECT * FROM Employees
WHERE Age < 30 and department in  ('HR', 'IT')
--25--
SELECT * FROM Customers
WHERE Email LIKE '%@gmail.com%'
--26--
SELECT employee_name, salary
FROM Employees
WHERE salary > ALL (SELECT salary FROM Employees WHERE department = 'Sales')

--27-- 
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(day, -180, (SELECT MAX(OrderDate) FROM Orders)) AND (SELECT MAX(OrderDate) FROM Orders)










