USE Session2DB;

SELECT * FROM Employees;

SELECT * FROM Orders;

SELECT * FROM OrderDetails;

SELECT * FROM Products;

SELECT * FROM Suppliers;

SELECT * FROM Shippers;

-- Joins

-- 1. Get the firstname and lastname of the employees who placed orders between 15th August,1996 and 15th August,1997

SELECT DISTINCT e.FirstName, e.LastName
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1996-08-15' AND '1997-08-15';

-- 2. Get the distinct EmployeeIDs who placed orders before 16th October,1996

SELECT DISTINCT o.EmployeeID
FROM Orders o
WHERE o.OrderDate < '1996-10-16';

-- 3. How many products were ordered in total by all employees between 13th of January,1997 and 16th of April,1997.

SELECT SUM(od.Quantity) AS TotalProductsOrder
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-01-13' AND '1997-04-16';

-- 4. What is the total quantity of products for which Anne Dodsworth placed orders between 13th of January,1997 and 16th of April,1997.

SELECT SUM(od.Quantity) As TotalOrdersByAnneDodsworth
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE e.FirstName = 'Anne' AND e.LastName = 'Dodsworth' AND o.OrderDate BETWEEN '1997-01-13' AND '1997-04-16';

-- 5. How many orders have been placed in total by Robert King

SELECT COUNT(o.OrderId) AS NoOfOrdersByRobertKing
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE e.FirstName = 'Robert' AND e.LastName = 'King';

-- 6. How many products have been ordered by Robert King between 15th August,1996 and 15th August,1997

SELECT SUM(od.Quantity) AS TotalProductsOrderByRobertKing
FROM Employees e
JOIN Orders o ON e.EmployeeId = o.EmployeeId
JOIN OrderDetails od ON o.OrderId = od.OrderId
WHERE e.FirstName = 'Robert' AND e.LastName = 'King' AND o.OrderDate BETWEEN '1996-08-15' AND '1997-08-15';

-- 7. I want to make a phone call to the employees to wish them on the occasion of Christmas who placed orders between 13th of January,1997 and 16th of April,1997. I want the EmployeeID, Employee Full Name, HomePhone Number.

SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS EmployeeName, e.HomePhone
FROM Employees e
JOIN Orders o ON e.EmployeeId = o.EmployeeId
WHERE o.OrderDate BETWEEN '1997-01-13' AND '1997-04-16';

-- 8. Which product received the most orders. Get the product's ID and Name and number of orders it received.

SELECT TOP 1 p.productId, p.productName, COUNT(od.OrderId) AS NoOfOrders
FROM OrderDetails od
JOIN Products p ON p.ProductId = od.ProductId
GROUP BY p.productId, p.productName
ORDER BY NoOfOrders DESC;

-- 9. Which are the least shipped products. List only the top 5 from your list.

SELECT TOP 5 p.ProductID, p.ProductName, COUNT(DISTINCT od.OrderID) AS NoOfShipments
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE o.ShippedDate IS NOT NULL
GROUP BY p.ProductID, p.ProductName
ORDER BY NoOfShipments ASC;

-- 10. What is the total price that is to be paid by Laura Callahan for the order placed on 13th of January,1997

SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalPrice
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON od.OrderID = o.OrderID
WHERE e.FirstName = 'Laura' AND e.LastName = 'Callahan' AND o.orderDate = '1997-01-13';

-- 11. How many number of unique employees placed orders for Gorgonzola Telino or Gnocchi di nonna Alice or Raclette Courdavault or Camembert Pierrot in the month January,1997

SELECT DISTINCT COUNT( o.EmployeeId) AS UniqueEmps
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName In ('Gorgonzola Telino','Gnocchi di nonna Alice','Raclette Courdavault','Camembert Pierrot') AND o.OrderDate >= '1997-01-01' AND o.OrderDate < '1997-02-01';

-- 12. What is the full name of the employees who ordered Tofu between 13th of January,1997 and 30th of January,1997

SELECT DISTINCT e.FirstName + ' ' + e.LastName AS FullName
FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN OrderDetails od ON o.OrderId = od.OrderId
JOIN Products p ON p.ProductId = od.ProductId
WHERE p.ProductName = 'Tofu' AND o.OrderDate >= '1997-01-13' AND o.OrderDate < '1997-01-31';

-- 13. What is the age of the employees in days, months and years who placed orders during the month of August. Get employeeID and full name as well

SELECT DISTINCT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    DATEDIFF(DAY, e.BirthDate, GETDATE()) AS AgeInDays,
    DATEDIFF(MONTH, e.BirthDate, GETDATE()) AS AgeInMonths,
    DATEDIFF(YEAR, e.BirthDate, GETDATE()) AS AgeInYears
FROM Employees e
JOIN Orders o ON e.EmployeeId = o.EmployeeId
WHERE MONTH(o.OrderDate) = 8;