create database Lesson_20_hw

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');


SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s2.CustomerName = s.CustomerName
      AND MONTH(s2.SaleDate) = 3 AND YEAR(s2.SaleDate) = 2024
);


SELECT TOP(1) Product, TotalRevenue
FROM (
    SELECT Product, SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) t
ORDER BY TotalRevenue DESC;



SELECT MAX(Amount) AS SecondHighest
FROM (
  SELECT DISTINCT (Price * Quantity) AS Amount
  FROM #Sales
) t
WHERE Amount < (
  SELECT MAX(Price * Quantity) FROM #Sales
);



SELECT MonthYear, (
    SELECT SUM(Quantity)
    FROM #Sales s2
    WHERE CONCAT(YEAR(s2.SaleDate), RIGHT('0'+CONVERT(VARCHAR(2), MONTH(s2.SaleDate)),2)) = t.MonthYear
) AS TotalQuantity
FROM (
    SELECT DISTINCT CONCAT(YEAR(SaleDate), RIGHT('0'+CONVERT(VARCHAR(2), MONTH(SaleDate)),2)) AS MonthYear
    FROM #Sales
) t
ORDER BY MonthYear;


SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s2.Product = s.Product
      AND s2.CustomerName <> s.CustomerName
);


CREATE TABLE Fruits(Name varchar(50), Fruit varchar(50));
INSERT INTO Fruits VALUES
 ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
 ('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
 ('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
 ('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), ('Mario', 'Orange');

-- 6) Har bir odam uchun mevalarni individual darajada qaytarish (pivot)
-- Izoh: conditional aggregation yordamida Apple/Orange/Banana ustunlarini hosil qilamiz
SELECT
  Name,
  SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
  SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
  SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name
ORDER BY Name;


CREATE TABLE Family(ParentId int, ChildID int);
INSERT INTO Family VALUES (1,2),(2,3),(3,4);

WITH Rec AS (
  -- bosqich 1: to'g'ridan-to'g'ri ota-ongalar
  SELECT ParentId AS PID, ChildID AS CHID
  FROM Family
  UNION ALL
  -- rekursiya: avvalgi CHID uchun yana CHID larni topamiz
  SELECT r.PID, f.ChildID
  FROM Rec r
  JOIN Family f ON f.ParentId = r.CHID
)
SELECT DISTINCT PID, CHID
FROM Rec
ORDER BY PID, CHID;

-- -------------------------------
-- -------------------------------
IF OBJECT_ID('tempdb..#Orders') IS NOT NULL DROP TABLE #Orders;
CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);

INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
    SELECT 1 FROM #Orders o2
    WHERE o2.CustomerID = o.CustomerID AND o2.DeliveryState = 'CA'
  )
ORDER BY o.CustomerID, o.OrderID;


CREATE TABLE #residents(resid int identity, fullname varchar(50), address varchar(100));

INSERT INTO #residents (fullname, address) VALUES
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy name=Theo age=28'),
('', 'city=Tashkent country=Uzbekistan name=Rajabboy age=22');

-- Izoh: fullname bo'sh ('') yoki NULL bo'lsa address ichidagi name=... ni ajratib update qilamiz.
UPDATE #residents
SET fullname = SUBSTRING(address, namePos + LEN('name='),
                           CASE WHEN nextSpacePos = 0 THEN LEN(address) - (namePos + LEN('name=')) + 1
                                ELSE nextSpacePos - (namePos + LEN('name=')) END)
FROM (
  SELECT resid, address,
         CHARINDEX('name=', address) AS namePos,
         -- topilgan name= keyin keladigan bo'shliq yoki 0
         CASE WHEN CHARINDEX(' ', address, CHARINDEX('name=', address)) = 0 THEN 0
              ELSE CHARINDEX(' ', address, CHARINDEX('name=', address)) END AS nextSpacePos
  FROM #residents
) src
WHERE #residents.resid = src.resid
  AND (ISNULL(#residents.fullname,'') = '' )
  AND src.namePos > 0;

-- Ko'rish
SELECT * FROM #residents;


CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

-- Rekursiv CTE orqali Tashkent'dan boshlanib barcha yo'llarni topamiz (qat'iy: cycle dan qochish uchun path ni saqlaymiz)
WITH Paths AS (
  SELECT
    DepartureCity,
    ArrivalCity,
    CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS FullRoute,
    Cost,
    CAST(DepartureCity + '>' + ArrivalCity AS VARCHAR(MAX)) AS PathNodes
  FROM #Routes
  WHERE DepartureCity = 'Tashkent'
  UNION ALL
  SELECT
    r.DepartureCity,
    r.ArrivalCity,
    CAST(p.FullRoute + ' - ' + r.ArrivalCity AS VARCHAR(MAX)),
    p.Cost + r.Cost,
    p.PathNodes + '>' + r.ArrivalCity
  FROM Paths p
  JOIN #Routes r ON r.DepartureCity = p.ArrivalCity
  WHERE CHARINDEX('>' + r.ArrivalCity, p.PathNodes) = 0 -- cycle dan saqlash
)
SELECT FullRoute AS [Route], Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost;

-- Agar faqat eng arzon va eng qimmatni olish kerak bo'lsa:
SELECT TOP(1) FullRoute AS [Route], Cost FROM Paths WHERE ArrivalCity='Khorezm' ORDER BY Cost ASC;
SELECT TOP(1) FullRoute AS [Route], Cost FROM Paths WHERE ArrivalCity='Khorezm' ORDER BY Cost DESC;

-- -------------------------------
-- 11) Ranking puzzle: insertion tartibiga qarab guruh/raqam berish
-- Izoh: Vals='Product' bo'lgan joylar yangi group boshlaydi. Biz qator bo'yicha Product bloklarini numeratsiya qilamiz.
IF OBJECT_ID('tempdb..#RankingPuzzle') IS NOT NULL DROP TABLE #RankingPuzzle;
CREATE TABLE #RankingPuzzle (ID INT, Vals VARCHAR(10));
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),(2,'a'),(3,'a'),(4,'a'),(5,'a'),(6,'Product'),(7,'b'),(8,'b'),(9,'Product'),(10,'c');

SELECT *,
  SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductGroup
FROM #RankingPuzzle
ORDER BY ID;


CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

SELECT EmployeeID, EmployeeName, Department, SalesAmount,
       AVG(SalesAmount) OVER (PARTITION BY Department) AS DeptAvg
FROM #EmployeeSales
WHERE SalesAmount > AVG(SalesAmount) OVER (PARTITION BY Department)
ORDER BY Department, SalesAmount DESC;


SELECT es.EmployeeID, es.EmployeeName, es.Department, es.SalesAmount, es.SalesMonth, es.SalesYear
FROM #EmployeeSales es
WHERE EXISTS (
  SELECT 1 FROM #EmployeeSales es2
  WHERE es2.SalesMonth = es.SalesMonth AND es2.SalesYear = es.SalesYear
    AND es2.SalesAmount < es.SalesAmount
)
AND es.SalesAmount = (
  SELECT MAX(SalesAmount) FROM #EmployeeSales es3
  WHERE es3.SalesMonth = es.SalesMonth AND es3.SalesYear = es.SalesYear
)
ORDER BY es.SalesYear, es.SalesMonth;


WITH Months AS (
  SELECT DISTINCT SalesYear, SalesMonth FROM #EmployeeSales
)
SELECT e.EmployeeID, e.EmployeeName
FROM #EmployeeSales e
GROUP BY e.EmployeeID, e.EmployeeName
HAVING NOT EXISTS (
  SELECT 1 FROM Months m
  WHERE NOT EXISTS (
    SELECT 1 FROM #EmployeeSales es
    WHERE es.EmployeeID = e.EmployeeID AND es.SalesYear = m.SalesYear AND es.SalesMonth = m.SalesMonth
  )
)
ORDER BY e.EmployeeID;


CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

IF OBJECT_ID('dbo.Orders') IS NOT NULL DROP TABLE dbo.Orders;
CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

-- 15) Mahsulotlar nomlarini o'rtacha narxdan qimmat bo'lganlarni oling
SELECT Name, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 16) Stock miqdori eng katta stock dan kam bo'lgan mahsulotlar
SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

-- 17) 'Laptop' bilan bir xil kategoriyadagi mahsulotlar
SELECT p2.Name
FROM Products p1
JOIN Products p2 ON p2.Category = p1.Category
WHERE p1.Name = 'Laptop' AND p2.ProductID <> p1.ProductID;

-- 18) Electronics kategoriyasidagi eng past narxdan qimmat bo'lgan productlarni oling
SELECT Name, Price
FROM Products
WHERE Price > (
  SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

-- 19) Har bir mahsulot o'z kategoriyasining o'rtacha narxidan qimmat bo'lsa
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
  SELECT AVG(p2.Price) FROM Products p2 WHERE p2.Category = p.Category
);

-- 20) Kamida bir marta buyurtma qilingan mahsulotlarni toping
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON o.ProductID = p.ProductID;

-- 21) Buyurtma qilingan mahsulotlarni o'rtacha buyurtma qty dan katta bo'lganlarni toping
SELECT p.Name, SUM(o.Quantity) as TotalQty
FROM Products p
JOIN Orders o ON o.ProductID = p.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
  SELECT AVG(TotalQ) FROM (
    SELECT SUM(Quantity) AS TotalQ FROM Orders GROUP BY ProductID
  ) x
);

-- 22) Hech qachon buyurtma qilinmagan mahsulotlar
SELECT Name FROM Products p
WHERE NOT EXISTS (SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID);

-- 23) Jami buyurtma miqdori bo'yicha eng yuqori mahsulotni oling
SELECT TOP(1) p.Name, SUM(o.Quantity) AS TotalOrdered
FROM Products p
JOIN Orders o ON o.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;


