CREATE DATABASE Lesson_16_HW
GO 
USE Lesson_16_HW



CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);



------Derived table, CTE------

--1--
-- create the table
CREATE TABLE dbo.Numbers (n INT PRIMARY KEY);

-- populate 1..1000 with a recursive CTE
;WITH NumbersCTE AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM NumbersCTE
    WHERE n < 1000
)
INSERT INTO Numbers(n)
SELECT n FROM NumbersCTE
OPTION (MAXRECURSION 0);

--2--
SELECT  e.EmployeeID,
		CONCAT(e.FirstName, ' ', E.LastName) AS EmployeeName,
		s.TotalSales 
FROM Employees E JOIN 
	(SELECT EmployeeID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY EmployeeID) AS S 
			ON E.EmployeeID = S.EmployeeID;

--3--
WITH SALARY_CTE AS(
SELECT AVG(Salary) Avg_Salary FROM Employees
) 
SELECT Avg_Salary FROM SALARY_CTE

--4--
SELECT P.ProductID,
	   P.ProductName,
	   S.Max_Sale
FROM Products P 
JOIN (SELECT ProductID, MAX(SalesAmount) AS Max_Sale FROM Sales
	   GROUP BY ProductID) AS S ON P.ProductID = S.ProductID;

--5--
WITH DoubleCTE AS (
    SELECT 1 AS Num
    UNION ALL
    SELECT Num * 2
    FROM DoubleCTE
    WHERE Num * 2 < 1000000
)
SELECT Num
FROM DoubleCTE;

--6--
WITH SalesCountCTE AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    CONCAT(e.FirstName, ' ', E.LastName) AS EmployeeName,
    s.TotalSales
FROM Employees e
JOIN SalesCountCTE s
    ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 5;

--7--
WITH ProductSalesCTE AS (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT 
    p.ProductID,
    p.ProductName,
    ps.TotalSales
FROM Products p
JOIN ProductSalesCTE ps
    ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

--8--
WITH AvgSalaryCTE AS (
    SELECT 
        AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', E.LastName) AS EmployeeName,
    e.Salary
FROM Employees e
CROSS JOIN AvgSalaryCTE a
WHERE e.Salary > a.AvgSalary;

------------MEDIUM----------
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', E.LastName) AS EmployeeName,
    s.OrderCount
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) s
    ON e.EmployeeID = s.EmployeeID
ORDER BY s.OrderCount DESC
FETCH NEXT 5 ROWS ONLY;

--2--
SELECT 
    p.CategoryID,
    SUM(s.TotalSales) AS CategorySales
FROM Products p
JOIN (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) s
    ON p.ProductID = s.ProductID
GROUP BY p.CategoryID;

--3--
WITH FactorialCTE AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, (Num + 1) * Factorial
    FROM FactorialCTE
    WHERE Num < (SELECT MAX(Num) FROM Numbers1)
)
SELECT Num, Factorial
FROM FactorialCTE


--4--
;WITH SplitCTE AS (
    -- Anchor member: start with the first character of each string
    SELECT
        Id,
        SUBSTRING(String, 1, 1) AS Character,
        1 AS Position,
        String
    FROM Example

    UNION ALL

    -- Recursive member: move to the next character
    SELECT
        Id,
        SUBSTRING(String, Position + 1, 1) AS Character,
        Position + 1 AS Position,
        String
    FROM SplitCTE
    WHERE Position < LEN(String)
)
SELECT 
    Id,
    Character,
    Position
FROM SplitCTE
ORDER BY Id, Position
OPTION (MAXRECURSION 0);

--5--
WITH MonthlySales AS (
    SELECT 
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesDifference AS (
    SELECT 
        ms1.SaleYear,
        ms1.SaleMonth,
        ms1.TotalSales,
        (ms1.TotalSales - ISNULL(ms2.TotalSales, 0)) AS SalesDifference
    FROM MonthlySales ms1
    LEFT JOIN MonthlySales ms2
        ON (ms1.SaleYear = ms2.SaleYear AND ms1.SaleMonth = ms2.SaleMonth + 1)
        OR (ms1.SaleYear = ms2.SaleYear + 1 AND ms1.SaleMonth = 1 AND ms2.SaleMonth = 12)
)
SELECT *
FROM SalesDifference
ORDER BY SaleYear, SaleMonth;

--6--
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', E.LastName) AS EmployeeName,
    q.SaleYear,
    q.SaleQuarter,
    q.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        YEAR(SaleDate) AS SaleYear,
        DATEPART(QUARTER, SaleDate) AS SaleQuarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
) AS q
    ON e.EmployeeID = q.EmployeeID
WHERE q.TotalSales > 45000
ORDER BY q.SaleYear, q.SaleQuarter, CONCAT(e.FirstName, ' ', E.LastName) ;


--------Difficult tasks---

--1--
WITH FibonacciCTE (n, fib1, fib2)
AS
(
    SELECT 1 AS n, 0 AS fib1, 1 AS fib2
    UNION ALL
    SELECT n + 1,
           fib2,
           fib1 + fib2
    FROM FibonacciCTE
    WHERE n < 10  
)
SELECT n AS Position, fib1 AS Fibonacci_Number
FROM FibonacciCTE

--2--
SELECT Id, Vals
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND Vals NOT LIKE '%[^' + LEFT(Vals, 1) + ']%';

--3--
DECLARE @n INT = 5;

WITH NumbersCTE AS
(
    SELECT 1 AS Num, CAST('1' AS VARCHAR(50)) AS Seq
    UNION ALL
    SELECT Num + 1,
           Seq + CAST(Num + 1 AS VARCHAR(10))
    FROM NumbersCTE
    WHERE Num + 1 <= @n
)
SELECT Seq AS NumberSequence
FROM NumbersCTE;

---4--
select * from Employees
select * from Sales
SELECT e.EmployeeID, CONCAT(e.FirstName, ' ', E.LastName) AS EmployeeName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS s
ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales = (
    SELECT MAX(SUM(SalesAmount ))
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
);

--5--

select * from RemoveDuplicateIntsFromNames
WITH SplitDigits AS (
    SELECT 
        Value,
        SUBSTRING(Value, v.number, 1) AS Digit
    FROM RemoveDuplicateIntsFromNames
    JOIN master.dbo.spt_values v 
        ON v.type = 'P'
       AND v.number BETWEEN 1 AND LEN(Pawan_slug_name)
),
CountDigits AS (
    SELECT Pawan_slug_name, pawanname, COUNT(*) AS cnt
    FROM SplitDigits
    GROUP BY Value, Digit
    HAVING COUNT(*) > 1 
SELECT DISTINCT Value,
       STRING_AGG(Digit, '') WITHIN GROUP (ORDER BY Digit) AS CleanedValue
FROM CountDigits
GROUP BY Value;
