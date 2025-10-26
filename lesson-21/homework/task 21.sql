CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

--1) Assign a row number to each sale 
--based on the SaleDate--

select  SaleID,
	ProductName,
	SaleDate,
	SaleAmount, 
	ROW_NUMBER() over (order by SaleDate) as SaleRowNumber
from ProductSales
order by SaleDate

/*2) Rank products based on the total quantity
sold — same rank for same amounts without skipping numbers*/

SELECT
  ProductName,
  TotalQuantity,
  DENSE_RANK() OVER (ORDER BY TotalQuantity DESC) AS QuantityRank
FROM (
  SELECT ProductName, SUM(Quantity) AS TotalQuantity
  FROM ProductSales
  GROUP BY ProductName
) t
ORDER BY TotalQuantity DESC;

--3--
WITH RankedSales AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC, SaleDate) AS rn
  FROM ProductSales
)
SELECT SaleID, CustomerID, ProductName, SaleDate, SaleAmount, Quantity
FROM RankedSales
WHERE rn = 1;

--4--
SELECT
  SaleID,
  SaleDate,
  SaleAmount AS CurrentAmount,
  LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales
ORDER BY SaleDate;

--5--
SELECT
  SaleID,
  SaleDate,
  SaleAmount AS CurrentAmount,
  LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
ORDER BY SaleDate;

--6--
SELECT
  SaleID,
  SaleDate,
  SaleAmount,
  LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate)
ORDER BY SaleDate;

--7--
SELECT
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;

--8--
SELECT
  SaleID,
  SaleDate,
  SaleAmount AS CurrentAmount,
  LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextAmount,
  CASE
    WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NULL THEN NULL
    WHEN SaleAmount = 0 THEN NULL
    ELSE ROUND( (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount, 2 )
  END AS PctChange_To_Next
FROM ProductSales
ORDER BY SaleDate;

--9--
SELECT
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  CASE
    WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NULL THEN NULL
    WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) = 0 THEN NULL
    ELSE CAST(SaleAmount AS DECIMAL(12,4)) / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
  END AS Ratio_To_Prev
FROM ProductSales
ORDER BY ProductName, SaleDate;

--10--
SELECT
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  SaleAmount - FIRST_VALUE(SaleAmount) OVER (
    PARTITION BY ProductName
    ORDER BY SaleDate
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS DiffFromFirstSaleAmount
FROM ProductSales
ORDER BY ProductName, SaleDate;

--11--
WITH WithPrev AS (
  SELECT
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmt
  FROM ProductSales
)
SELECT ProductName
FROM WithPrev
GROUP BY ProductName
HAVING SUM(CASE WHEN PrevAmt IS NOT NULL AND SaleAmount <= PrevAmt THEN 1 ELSE 0 END) = 0;

--12--
SELECT
  SaleID,
  SaleDate,
  SaleAmount,
  SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM ProductSales
ORDER BY SaleDate;

--13--

SELECT
  SaleID,
  SaleDate,
  SaleAmount,
  AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg_Last3
FROM ProductSales
ORDER BY SaleDate;

--14--
SELECT
  SaleID,
  SaleDate,
  SaleAmount,
  SaleAmount - AVG(SaleAmount) OVER () AS DiffFromOverallAvg
FROM ProductSales
ORDER BY SaleDate;



---employees
CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');


--15--
WITH Ranked AS (
  SELECT
    EmployeeID, Name, Department, Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
  FROM Employees1
)
SELECT EmployeeID, Name, Department, Salary, SalaryRank
FROM Ranked
WHERE SalaryRank IN (
  SELECT SalaryRank
  FROM Ranked
  GROUP BY SalaryRank
  HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Department, EmployeeID;

--16--
SELECT EmployeeID, Name, Department, Salary
FROM (
  SELECT *,
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptSalaryRank
  FROM Employees1
) t
WHERE DeptSalaryRank <= 2
ORDER BY Department, Salary DESC;

--17--
SELECT EmployeeID, Name, Department, Salary
FROM (
  SELECT *,
    RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rnk
  FROM Employees1
) t
WHERE rnk = 1
ORDER BY Department;

--18--
SELECT
  EmployeeID,
  Name,
  Department,
  HireDate,
  Salary,
  SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningDeptSalary
FROM Employees1
ORDER BY Department, HireDate;

--19--
SELECT
  EmployeeID,
  Name,
  Department,
  Salary,
  SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees1
ORDER BY Department, EmployeeID;

--20--
SELECT
  EmployeeID,
  Name,
  Department,
  Salary,
  AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees1
ORDER BY Department, EmployeeID;


--21--
SELECT
  EmployeeID,
  Name,
  Department,
  Salary,
  AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary,
  Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1
ORDER BY Department, EmployeeID;

--22--
SELECT
  EmployeeID,
  Name,
  HireDate,
  Salary,
  AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg_3Centered
FROM Employees1
ORDER BY HireDate;

--23--
SELECT SUM(Salary) AS Sum_Last3Hired
FROM (
  SELECT TOP (3) Salary
  FROM Employees1
  ORDER BY HireDate DESC
) t;










