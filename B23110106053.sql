-- Create Tables

CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Cars (
    CarID SERIAL PRIMARY KEY,
    Model VARCHAR(50),
    Brand VARCHAR(50),
    Year INT,
    Price NUMERIC(12,2),
    Color VARCHAR(30),
    InventoryCount INT
);

CREATE TABLE Salespersons (
    SalespersonID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    HireDate DATE
);

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    CarID INT REFERENCES Cars(CarID),
    SaleDate DATE,
    SalePrice NUMERIC(12,2),
    SalespersonID INT REFERENCES Salespersons(SalespersonID)
);

CREATE TABLE ServiceRecords (
    RecordID SERIAL PRIMARY KEY,
    CarID INT REFERENCES Cars(CarID),
    ServiceDate DATE,
    ServiceType VARCHAR(50),
    Cost NUMERIC(12,2),
    TechnicianID INT
);


-- Insert Sample Data


-- Customers
INSERT INTO Customers (CustomerName, City, State, JoinDate) VALUES
('Ali Khan', 'Karachi', 'Sindh', '2022-01-15'),
('Sara Ahmed', 'Lahore', 'Punjab', '2022-03-20'),
('John Doe', 'Islamabad', 'ICT', '2023-05-12'),
('Fatima Noor', 'Multan', 'Punjab', '2023-08-05'),
('Bilal Saeed', 'Quetta', 'Balochistan', '2024-02-01');

-- Cars
INSERT INTO Cars (Model, Brand, Year, Price, Color, InventoryCount) VALUES
('Civic', 'Honda', 2023, 45000, 'White', 5),
('City', 'Honda', 2022, 30000, 'Black', 8),
('Corolla', 'Toyota', 2023, 40000, 'Silver', 6),
('Fortuner', 'Toyota', 2023, 80000, 'Black', 3),
('Model S', 'Tesla', 2024, 120000, 'Red', 2),
('Model 3', 'Tesla', 2024, 60000, 'Blue', 4),
('Swift', 'Suzuki', 2023, 20000, 'White', 7),
('Alto', 'Suzuki', 2023, 15000, 'Gray', 10);

-- Salespersons
INSERT INTO Salespersons (Name, Department, HireDate) VALUES
('Ahmed Raza', 'Sales', '2021-02-10'),
('Maria Khan', 'Sales', '2020-06-15'),
('Omar Malik', 'Luxury Sales', '2019-09-20');

-- Sales
INSERT INTO Sales (CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1, 1, '2023-06-01', 45000, 1),
(2, 4, '2023-07-15', 80000, 3),
(3, 5, '2024-01-10', 120000, 3),
(4, 2, '2023-09-05', 30000, 2),
(5, 3, '2023-10-22', 40000, 1),
(1, 6, '2024-02-18', 60000, 2),
(3, 7, '2024-03-12', 20000, 1),
(4, 8, '2024-04-25', 15000, 2),
(2, 1, '2024-05-10', 46000, 1),
(5, 4, '2024-06-18', 81000, 3);

-- Service Records
INSERT INTO ServiceRecords (CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1, '2024-03-01', 'Oil Change', 200, 101),
(2, '2024-03-15', 'Engine Check', 800, 102),
(3, '2024-04-01', 'Tire Replacement', 600, 103),
(4, '2024-04-20', 'Brake Service', 400, 104),
(5, '2024-05-05', 'Battery Replacement', 900, 105),
(6, '2024-05-25', 'Oil Change', 250, 101),
(7, '2024-06-10', 'Engine Check', 850, 102),
(8, '2024-06-15', 'Tire Replacement', 700, 103);


-- Part 1 – Basic Aggregate Functions

-- 1
SELECT COUNT(*) AS TotalCustomers FROM Customers;
-- 2
SELECT AVG(SalePrice) AS AverageSalePrice FROM Sales;
-- 3
SELECT MAX(SalePrice) AS MostExpensiveCar FROM Sales;
-- 4
SELECT SUM(InventoryCount) AS TotalInventory FROM Cars;
-- 5
SELECT MIN(SaleDate) AS EarliestSaleDate, MAX(SaleDate) AS LatestSaleDate FROM Sales;


-- Part 2 – GROUP BY Exercises

-- 1
SELECT Brand, COUNT(Model) AS ModelCount FROM Cars GROUP BY Brand;
-- 2
SELECT sp.SalespersonID, sp.Name, SUM(s.SalePrice) AS TotalSales
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY sp.SalespersonID, sp.Name;
-- 3
SELECT c.Model, AVG(s.SalePrice) AS AvgSalePrice
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model;
-- 4
SELECT ServiceType, AVG(Cost) AS AvgServiceCost
FROM ServiceRecords
GROUP BY ServiceType;
-- 5
SELECT Brand, Color, COUNT(*) AS CarCount
FROM Cars
GROUP BY Brand, Color;


-- Part 3 – HAVING Clause Exercises

-- 1
SELECT Brand, COUNT(Model) AS ModelCount
FROM Cars
GROUP BY Brand
HAVING COUNT(Model) > 5;
-- 2
SELECT c.Model, COUNT(*) AS TimesSold
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model
HAVING COUNT(*) > 10;
-- 3
SELECT sp.SalespersonID, sp.Name, AVG(s.SalePrice) AS AvgSalePrice
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY sp.SalespersonID, sp.Name
HAVING AVG(SalePrice) > 50000;
-- 4
SELECT EXTRACT(MONTH FROM SaleDate) AS SaleMonth, COUNT(*) AS TotalSales
FROM Sales
GROUP BY EXTRACT(MONTH FROM SaleDate)
HAVING COUNT(*) > 20;
-- 5
SELECT ServiceType, AVG(Cost) AS AvgServiceCost
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 500;





