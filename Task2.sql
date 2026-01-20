USE Session2DB;

SELECT * FROM Employees;

SELECT * FROM Orders;

-- Joins

-- 1. Get the firstname and lastname of the employees who placed orders between 15th August,1996 and 15th August,1997

SELECT DISTINCT e.FirstName, e.LastName
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1996-08-15' AND '1997-08-15';