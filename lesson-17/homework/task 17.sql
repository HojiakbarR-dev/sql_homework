CREATE DATABASE Lesson_17_HW


DROP TABLE IF EXISTS RegionSales;
GO
CREATE TABLE RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);


SELECT * FROM RegionSales

;
WITH Regions AS (
  SELECT DISTINCT Region
  FROM RegionSales
),
Distributors AS (
  SELECT DISTINCT Distributor
  FROM RegionSales
),
AllCombos AS (
  SELECT r.Region, d.Distributor
  FROM Regions r
  CROSS JOIN Distributors d
)
SELECT A.Region,
	   A.Distributor,
	   COALESCE(RS.Sales, 0) AS SALES
FROM AllCombos A LEFT JOIN RegionSales RS ON RS.Region = A.Region
								AND RS.Distributor = A.Distributor
ORDER BY a.Region, a.Distributor

--2--
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

SELECT E.name
FROM Employee E
 JOIN (
	SELECT managerId FROM Employee
	WHERE managerId IS NULL
	GROUP BY managerId
	HAVING COUNT(*) >= 5
 ) AS M 
ON E.id = M.managerId

--3--
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT P.product_name,
	   SUM(O.unit) AS Unit
FROM Orders O 
JOIN Products P ON O.product_id = P.product_id
WHERE O.order_date >= '2020-02-01' AND O.order_date < '2020-03-01'
GROUP BY P.product_name
HAVING SUM(O.unit) >= 100


--4--
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

SELECT CustomerID, Vendor
FROM (
    SELECT 
        CustomerID,
        Vendor,
        SUM([Count]) AS TotalCount,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) ranked
WHERE rnk = 1;

--5--
DECLARE @CHECK_PRIME INT = 91;
DECLARE @I INT = 2;
DECLARE @PRIME INT = 2;

WHILE @I >= @CHECK_PRIME / 2
BEGIN
	IF @CHECK_PRIME % @I = 0
	begin 
		SET @PRIME = 0;
		BREAK
	END
	SET @I = @I +1;
END 


IF @Prime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--6--
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

SELECT 
  Device_id,
  no_of_location,
  Locations AS max_signal_location,
  total_signals AS no_of_signals
FROM (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count,
        COUNT(DISTINCT Locations) OVER (PARTITION BY Device_id) AS no_of_location,
        SUM(COUNT(*)) OVER (PARTITION BY Device_id) AS total_signals,
        RANK() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rnk
    FROM Device
    GROUP BY Device_id, Locations
) t
WHERE rnk = 1;

--7--
CREATE TABLE Employee1 (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID


);


--8--
| Ticket ID | Number |
|-----------|--------|
| A23423    | 25     |
| A23423    | 45     |
| A23423    | 78     |
| B35643    | 25     |
| B35643    | 45     |
| B35643    | 98     |
| C98787    | 67     |
| C98787    | 86     |
| C98787    | 91     |

-- Step 1: Create the table
CREATE TABLE Numbers (
    Number INT
);

-- Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);


-- Step 1: Create the Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

-- Step 2: Insert the data into the table
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

SELECT 
    SUM(
        CASE 
            WHEN matched = total_winning THEN 100
            WHEN matched > 0 THEN 10
            ELSE 0
        END
    ) AS total_winnings
FROM (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT n.Number) AS matched,
        (SELECT COUNT(*) FROM Numbers) AS total_winning
    FROM Tickets t
    LEFT JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID
) AS result;

--9--
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);


SELECT 
    ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
    Spend_date,
    Platform,
    SUM(Total_Amount) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
FROM (
    -- Case 1: Platform = 'Mobile only'
    SELECT 
        Spend_date,
        'Mobile' AS Platform,
        User_id,
        SUM(Amount) AS Total_Amount
    FROM Spending
    WHERE Platform = 'Mobile'
    GROUP BY Spend_date, User_id

    UNION ALL

    -- Case 2: Platform = 'Desktop only'
    SELECT 
        Spend_date,
        'Desktop' AS Platform,
        User_id,
        SUM(Amount) AS Total_Amount
    FROM Spending
    WHERE Platform = 'Desktop'
    GROUP BY Spend_date, User_id

    UNION ALL

    -- Case 3: Platform = 'Both' (users who used both Desktop and Mobile)
    SELECT 
        Spend_date,
        'Both' AS Platform,
        User_id,
        SUM(Amount) AS Total_Amount
    FROM Spending
    GROUP BY Spend_date, User_id
    HAVING COUNT(DISTINCT Platform) = 2
) AS Combined
GROUP BY Spend_date, Platform
ORDER BY Spend_date, Platform;


--10--
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);


WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT 
    g.Product,
    1 AS Quantity
FROM Grouped g
JOIN Numbers n 
    ON n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);

