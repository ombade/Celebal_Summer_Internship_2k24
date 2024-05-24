use AdventureWorksLT2022
Go

-- 1) List of All customers
Select * from SalesLT.Customer;

--2) list of all customers where company name is ending with N
SELECT * FROM SalesLT.Customer
WHERE CompanyName LIKE '%N';

--3) list all customer who live in Berlin or londan
SELECT *
FROM SalesLT.Customer 
INNER JOIN SalesLT.CustomerAddress
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
INNER JOIN SalesLT.Address
ON SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID
WHERE SalesLT.Address.City IN ('Berlin', 'London');

-- 4) list all the Customer who live in Uk or Usa
SELECT *
FROM SalesLT.Customer 
INNER JOIN SalesLT.CustomerAddress
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
INNER JOIN SalesLT.Address
ON SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID
WHERE SalesLT.Address.CountryRegion IN ('Berlin', 'London');


--5) list of all products sorted by the product name 
SELECT * 
FROM SalesLT.Product
ORDER BY Name;

-- 6) lis tall the products where product name start with an A
SELECT * 
FROM SalesLT.Product
WHERE Name LIKE 'A%';

--7) list of Customer who ever placed an order
select * from SalesLT.Customer
Inner join SalesLT.SalesOrderHeader
On SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;


---8) list of Customers who live in london and have bought chai
select * from SalesLT.Customer
Inner join SalesLT.SalesOrderHeader
On SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
Inner join SalesLT.SalesOrderDetail
On SalesLT.SalesOrderDetail.ProductID = SalesLT.SalesOrderHeader.

-- 9) list of Customer who never placed order
SELECT c.*
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NULL;


--10) list all customer who ordered Tofu
SELECT DISTINCT c.*
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
JOIN SalesLT.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN SalesLT.Product AS p ON sod.ProductID = p.ProductID
WHERE p.Name = 'Tofu';


-- 11 Detials of first order of system 
SELECT soh.SalesOrderID, soh.OrderDate, c.*, sod.*
FROM SalesLT.SalesOrderHeader AS soh
JOIN SalesLT.Customer AS c ON soh.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.OrderDate = (
    SELECT MIN(OrderDate)
    FROM SalesLT.SalesOrderHeader
);


-- 12 ) find the most expensive order date 
SELECT TOP 1 OrderDate
FROM (
    SELECT OrderDate, SUM(UnitPrice * OrderQty) AS TotalAmount
    FROM SalesLT.SalesOrderHeader AS soh
    JOIN SalesLT.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY OrderDate
) AS OrderAmounts
ORDER BY TotalAmount DESC;


--13. For each order get the OrderID and Average quantity of items in that order
SELECT SalesOrderID AS OrderID, AVG(OrderQty) AS AverageQuantity
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID;


--14. For each order get the orderID, minimum quantity and maximum quantity for that order
SELECT 
    SalesOrderID AS OrderID,
    MIN(OrderQty) AS MinQuantity,
    MAX(OrderQty) AS MaxQuantity
FROM 
    SalesLT.SalesOrderDetail
GROUP BY 
    SalesOrderID;
--15. Get a list of all managers and total number of employees who report to them.
SELECT 
    ManagerID,
    COUNT(EmployeeID) AS TotalEmployees
FROM 
    Employees
GROUP BY 
    ManagerID;

--16. Get the OrderiD and the total quantity for each order that has a total quantity of greater than 300
SELECT 
    SalesOrderID AS OrderID,
    SUM(OrderQty) AS TotalQuantity
FROM 
    SalesOrderDetail
GROUP BY 
    SalesOrderID
HAVING 
    SUM(OrderQty) > 300;

--17. list of all orders placed on or after 1996/12/31
SELECT 
    *
FROM 
   SalesLT.SalesOrderHeader
WHERE 
     SalesLT.SalesOrderHeader.OrderDate >= '1996-12-31';

--18. list of all orders shipped to Canada
SELECT 
    *
FROM 
    Orders
WHERE 
    ShipCountry = 'Canada';

--19. list of all orders with order total > 200
SELECT 
    *
FROM 
    Orders
WHERE 
    OrderTotal > 200;

--20. List of countries and sales made in each country
SELECT 
    ShipCountry,
    SUM(OrderTotal) AS TotalSales
FROM 
    Orders
GROUP BY 
    ShipCountry;

--21. List of Customer ContactName and number of orders they placed
SELECT 
    ContactName,
    COUNT(OrderID) AS TotalOrders
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY 
    ContactName;

--22. List of customer contactnames who have placed more than 3 orders
SELECT 
    ContactName
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY 
    ContactName
HAVING 
    COUNT(OrderID) > 3;

--23. List of discontinued products which were ordered between 1/1/1997 and 1/1/1998
SELECT 
    DISTINCT ProductName
FROM 
    Products
JOIN 
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE 
    Discontinued = 1
AND 
    OrderDate BETWEEN '1997-01-01' AND '1998-01-01';

--24. List of employee firsname, lastName, superviser FirstName, LastName
SELECT 
    E.FirstName AS EmployeeFirstName,
    E.LastName AS EmployeeLastName,
    M.FirstName AS SupervisorFirstName,
    M.LastName AS SupervisorLastName
FROM 
    Employees AS E
JOIN 
    Employees AS M ON E.ReportsTo = M.EmployeeID;

--25. List of Employees id and total sale condcuted by employee
SELECT 
    EmployeeID,
    SUM(OrderTotal) AS TotalSales
FROM 
    Orders
GROUP BY 
    EmployeeID;

--26. list of employees whose FirstName contains character a
SELECT 
    *
FROM 
    Employees
WHERE 
    FirstName LIKE '%a%';

--27. List of managers who have more than four people reporting to them.
SELECT 
    ManagerID
FROM 
    Employees
GROUP BY 
    ManagerID
HAVING 
    COUNT(EmployeeID) > 4;

--28. List of Orders and ProductNames
SELECT 
    O.OrderID,
    P.ProductName
FROM 
    OrderDetails AS OD
JOIN 
    Orders AS O ON OD.OrderID = O.OrderID
JOIN 
    Products AS P ON OD.ProductID = P.ProductID;

--29. List of orders place by the best customer
SELECT 
    *
FROM 
    Orders
WHERE 
    CustomerID = (SELECT CustomerID FROM Customers ORDER BY TotalOrders DESC LIMIT 1);

--30. List of orders placed by customers who do not have a Fax number
SELECT 
    *
FROM 
    Orders
WHERE 
    CustomerID NOT IN (SELECT CustomerID FROM Customers WHERE Fax IS NOT NULL);

--31. List of Postal codes where the product Tofu was shipped
SELECT 
    DISTINCT ShipPostalCode
FROM 
    Orders
JOIN 
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
WHERE 
    ProductName = 'Tofu';

--32. List of product Names that were shipped to France
SELECT 
    DISTINCT ProductName
FROM 
    Orders
JOIN 
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
WHERE 
    ShipCountry = 'France';

--33. List of Product Names and Categories for the supplier 'Specialty Biscuits, Ltd.'
SELECT 
    ProductName,
    CategoryName
FROM 
    Products
JOIN 
    Categories ON Products.CategoryID = Categories.CategoryID
WHERE 
    SupplierID = (SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Specialty Biscuits, Ltd.');

--34. List of products that were never ordered
SELECT 
    *
FROM 
    Products
WHERE 
    ProductID NOT IN (SELECT DISTINCT ProductID FROM OrderDetails);

--35. List of products where units in stock is less than 10 and units on order are 0.
SELECT 
    *
FROM 
    Products
WHERE 
    UnitsInStock < 10 AND UnitsOnOrder = 0;

--36. List of top 10 countries by sales
SELECT 
    ShipCountry,
    SUM(OrderTotal) AS TotalSales
FROM 
    Orders
GROUP BY 
    ShipCountry
ORDER BY 
    TotalSales DESC
LIMIT 10;

--37. Number of orders each employee has taken for customers with CustomerIDs between A and AO
SELECT 
    EmployeeID,
    COUNT(OrderID) AS TotalOrders
FROM 
    Orders
WHERE 
    CustomerID BETWEEN 'A' AND 'AO'
GROUP BY 
    EmployeeID;

--38. Orderdate of most expensive order
SELECT 
    OrderDate
FROM 
    Orders
ORDER BY 
    OrderTotal DESC
LIMIT 1;

--39. Product name and total revenue from that product
SELECT 
    ProductName,
    SUM(OrderTotal) AS TotalRevenue
FROM 
    OrderDetails
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY 
    ProductName;

--40. Supplierid and number of products offered
SELECT 
    SupplierID,
    COUNT(ProductID) AS NumberOfProducts
FROM 
    Products
GROUP BY 
    SupplierID;

--41. Top ten customers based on their business
SELECT 
    CustomerID,
    SUM(OrderTotal) AS TotalBusiness
FROM 
    Orders
GROUP BY 
    CustomerID
ORDER BY 
    TotalBusiness DESC
LIMIT 10;

--42. What is the total revenue of the company.
SELECT 
    SUM(OrderTotal) AS TotalRevenue
FROM 
    Orders;
