create database lesson3_hw
go
use lesson3_hw

--1-- BULK INSERT - in SQL server is a command for getting or loading the data from memory files. In this command will be used for files like CSV or text file into SQL Server table.
--2-- File Formants that can be imported to SQL Server: .txt, MSexcel, CSV, XML

--3--4--
create table Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL (10,2), CategoryID int )
INSERT INTO Products VALUES (1, 'PEN', 5.22, 2), (2, 'BOOK', 10.62, 3 ),(3, 'NOTEBOOK', 8.22, 4)

SELECT * FROM Products

--5--
-- NULL VALUES is unknown data that records empty space or zero 
-- NOT NULL mandates that a field must always contain a specific value, disallowing empty or undefined states.

--6--
Alter table products
add constraint ProductName unique (ProductName)
--7--
-- is a single line comment, used for short explanation and make easier to understand
/*is multiple line comment and it used for longer explanation for example block of codes, we use multiple line comments for explain different query in one comment*/

--8--
ALTER TABLE Products
ADD CategoryID INT
--9--
CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(40) UNIQUE)

--10-- The IDENTITY column in SQL Server serves the purpose of automatically generating unique, sequential integer values for a column within a table. This property is particularly useful for creating primary keys or other unique identifiers where a natural key  does not exist or is impractical.
--11--
bulk insert sales
from '"C:\Users\user\Desktop\sales.txt"'
with (
fieldterminator = ',',
rowterminator = '\n',
firstrow = 2
)
--12--
Alter table Products 
ADD constraint FK_Products foreign key (CategoryID) references categories(CategoryID)
--13-- 

--PRIMARY KEY:A primary key is a column of a table that uniquely identifies each tuple (row) in that table.  Only one primary key is allowed to be used in a table.
--UNIQUE KEY:constraints also identify an individual tuple uniquely in a relation or table. A table can have more than one unique key, unlike a primary key
--14--
ALTER TABLE Products
ADD CONSTRAINT Check_Price
CHECK (Price > 0)
--15--
ALTER TABLE Products
ADD Stock INT NOT NULL
--16--
UPDATE Products
SET Price = ISNULL(Price, 0)

--17-- A FOREIGN KEY constraint is used to enforce a relationship between two tables.It ensures that a value in one table (child) must exist in another table (parent).
--It maintains referential integrity in the database.



--18--
CREATE TABLE Customers (CustomerID INT PRIMARY KEY,Name NVARCHAR(100),Age INT CHECK (Age >= 18))
--19--
CREATE TABLE Products1 (ProductID INT IDENTITY(100, 10) PRIMARY KEY,ProductName NVARCHAR(100),Price DECIMAL(10,2))
--20--
CREATE TABLE OrderDetails (OrderID INT ,ProductID INT ,Quantity INT ,PRIMARY KEY (OrderID, ProductID))
--21--ISNULL replaces null values with given a kind of replacement value, ex: SELECT ISNULL(NULL, 'No Value')
--22--

CREATE TABLE Employees ( EmpID INT PRIMARY KEY, FirstName VARCHAR(100),LastName VARCHAR(100),Email VARCHAR(200) UNIQUE)
--23--
CREATE TABLE Customers1 (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




