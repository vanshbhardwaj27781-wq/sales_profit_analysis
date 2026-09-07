CREATE DATABASE sales_profit_analysis;

USE sales_profit_analysis;

CREATE TABLE Customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50)
);

CREATE TABLE Products (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Product_Name VARCHAR(200),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50)
);

CREATE TABLE Order_Details (
    Order_Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
);

SHOW TABLES;

SELECT COUNT(*) AS Total_Rows
FROM sales_data;

SELECT *
FROM sales_data
LIMIT 10;

DESCRIBE sales_data;

ALTER TABLE Products
MODIFY Product_ID INT AUTO_INCREMENT;

INSERT INTO Products (Product_Name, Category, Sub_Category)
SELECT DISTINCT
    `Product Name`,
    Category,
    `Sub-Category`
FROM sales_data;

SELECT COUNT(*) AS Total_Products
FROM Products;

SELECT *
FROM Products
LIMIT 10;

INSERT INTO Customers (Customer_ID, Customer_Name, Segment)
SELECT DISTINCT
    `Customer ID`,
    `Customer Name`,
    Segment
FROM sales_data;

SELECT COUNT(*) AS Total_Customers
FROM Customers;

SELECT *
FROM Customers
LIMIT 10;

USE sales_profit_analysis;

INSERT INTO Orders
(
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Country,
    City,
    State,
    Postal_Code,
    Region
)
SELECT DISTINCT
    `Order ID`,
    STR_TO_DATE(`Order Date`, '%d-%b-%Y'),
    STR_TO_DATE(`Ship Date`, '%d-%b-%Y'),
    `Ship Mode`,
    `Customer ID`,
    Country,
    City,
    State,
    NULL,
    Region
FROM sales_data;

SELECT COUNT(*) AS Total_Orders
FROM Orders;

SELECT *
FROM Orders
LIMIT 10;

USE sales_profit_analysis;

CREATE TABLE Order_Details (
    Order_Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Product_ID INT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
);

SHOW TABLES;

INSERT INTO Order_Details
(
    Order_ID,
    Product_ID,
    Sales,
    Quantity,
    Discount,
    Profit
)
SELECT
    s.`Order ID`,
    p.Product_ID,
    s.Sales,
    s.Quantity,
    s.Discount,
    s.Profit
FROM sales_data AS s
JOIN Products AS p
    ON s.`Product Name` = p.Product_Name
    AND s.Category = p.Category
    AND s.`Sub-Category` = p.Sub_Category;
    
    SELECT COUNT(*) AS Total_Order_Details
FROM Order_Details;

SELECT *
FROM Order_Details
LIMIT 10;

SELECT
    o.Order_ID,
    o.Order_Date,
    c.Customer_Name,
    c.Segment,
    o.Region
FROM Orders o
JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
LIMIT 10;

SELECT 
    o.Order_ID,
    c.Customer_Name,
    p.Product_Name,
    p.Category,
    od.Sales,
    od.Quantity,
    od.Profit
FROM
    Order_Details od
        JOIN
    Orders o ON od.Order_ID = o.Order_ID
        JOIN
    Customers c ON o.Customer_ID = c.Customer_ID
        JOIN
    Products p ON od.Product_ID = p.Product_ID
LIMIT 10;

USE sales_profit_analysis;

SHOW TABLES;

SELECT COUNT(*) AS Total_Order_Details
FROM Order_Details;

SHOW TABLES;

USE sales_profit_analysis;

SHOW TABLES;

CREATE TABLE Order_Details (
    Order_Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Product_ID INT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

SHOW TABLES;

USE sales_profit_analysis;

SHOW TABLES;

USE sales_profit_analysis;

CREATE TABLE order_details (
    Order_Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Product_ID INT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

SHOW TABLES;

USE sales_profit_analysis;

INSERT INTO order_details
(
    Order_ID,
    Product_ID,
    Sales,
    Quantity,
    Discount,
    Profit
)
SELECT
    s.`Order ID`,
    p.Product_ID,
    s.Sales,
    s.Quantity,
    s.Discount,
    s.Profit
FROM sales_data AS s
JOIN products AS p
    ON s.`Product Name` = p.Product_Name
    AND s.Category = p.Category
    AND s.`Sub-Category` = p.Sub_Category;
    
SELECT COUNT(*) AS Total_Order_Details
FROM order_details;

SELECT *
FROM order_details
LIMIT 10;

USE sales_profit_analysis;

SHOW TABLES;

SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM order_details;

SELECT 
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM order_details;

SELECT 
    SUM(Quantity) AS Total_Quantity
FROM order_details;

SELECT 
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM order_details;

SELECT
    p.Category,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    SUM(od.Quantity) AS Total_Quantity
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

SELECT
    o.Region,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN orders o
    ON od.Order_ID = o.Order_ID
GROUP BY o.Region
ORDER BY Total_Sales DESC;

SELECT
    p.Category,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

SELECT
    c.Segment,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN orders o
    ON od.Order_ID = o.Order_ID
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;

SELECT
    p.Product_Name,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT
    p.Product_Name,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    ROUND(SUM(od.Sales), 2) AS Total_Sales
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

USE sales_profit_analysis;

SELECT
    DATE_FORMAT(o.Order_Date, '%Y-%m') AS Month,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN orders o
    ON od.Order_ID = o.Order_ID
GROUP BY DATE_FORMAT(o.Order_Date, '%Y-%m')
ORDER BY Month;

SELECT
    p.Product_Name,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Product_Name
HAVING SUM(od.Profit) < 0
ORDER BY Total_Profit ASC;

SELECT
    c.Customer_Name,
    c.Segment,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM order_details od
JOIN orders o
    ON od.Order_ID = o.Order_ID
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name, c.Segment
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT
    p.Sub_Category,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    SUM(od.Quantity) AS Total_Quantity
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Sub_Category
ORDER BY Total_Sales DESC;

USE sales_profit_analysis;

SELECT
    p.Category,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    ROUND((SUM(od.Profit) / SUM(od.Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM order_details od
JOIN products p
    ON od.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Profit_Margin_Percentage DESC;

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low Discount'
        WHEN Discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS Discount_Level,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Discount) * 100, 2) AS Average_Discount_Percentage
FROM order_details
GROUP BY Discount_Level
ORDER BY Total_Sales DESC;

WITH ProductSales AS (
    SELECT
        p.Category,
        p.Product_Name,
        SUM(od.Sales) AS Total_Sales
    FROM order_details od
    JOIN products p
        ON od.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product_Name
),
RankedProducts AS (
    SELECT
        Category,
        Product_Name,
        Total_Sales,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY Total_Sales DESC
        ) AS Product_Rank
    FROM ProductSales
)
SELECT
    Category,
    Product_Name,
    ROUND(Total_Sales, 2) AS Total_Sales,
    Product_Rank
FROM RankedProducts
WHERE Product_Rank <= 3
ORDER BY Category, Product_Rank;

SELECT
    c.Customer_Name,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    RANK() OVER (
        ORDER BY SUM(od.Sales) DESC
    ) AS Customer_Rank
FROM order_details od
JOIN orders o
    ON od.Order_ID = o.Order_ID
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Customer_Rank;

USE sales_profit_analysis;

SELECT
    c.Segment,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM customers c
JOIN orders o
    ON c.Customer_ID = o.Customer_ID
JOIN order_details od
    ON o.Order_ID = od.Order_ID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;

SELECT
    o.State,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM orders o
JOIN order_details od
    ON o.Order_ID = od.Order_ID
GROUP BY o.State
ORDER BY Total_Sales DESC;

SELECT
    p.Sub_Category,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit
FROM products p
JOIN order_details od
    ON p.Product_ID = od.Product_ID
GROUP BY p.Sub_Category
ORDER BY Total_Profit DESC
LIMIT 10;

SELECT
    o.Order_ID,
    c.Customer_Name,
    ROUND(SUM(od.Sales), 2) AS Order_Sales,
    ROUND(SUM(od.Profit), 2) AS Order_Profit
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
JOIN order_details od
    ON o.Order_ID = od.Order_ID
GROUP BY o.Order_ID, c.Customer_Name
ORDER BY Order_Sales DESC
LIMIT 10;

SELECT
    o.Order_ID,
    c.Customer_Name,
    ROUND(SUM(od.Sales), 2) AS Sales,
    ROUND(SUM(od.Profit), 2) AS Profit
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
JOIN order_details od
    ON o.Order_ID = od.Order_ID
GROUP BY o.Order_ID, c.Customer_Name
HAVING SUM(od.Profit) < 0
ORDER BY Profit ASC;

USE sales_profit_analysis;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Missing_Profit,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Missing_Quantity
FROM order_details;

SELECT
    Order_ID,
    Product_ID,
    COUNT(*) AS Duplicate_Count
FROM order_details
GROUP BY Order_ID, Product_ID
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS Loss_Making_Records
FROM order_details
WHERE Profit < 0;

SELECT 
    COUNT(*) AS Unmatched_Orders
FROM
    order_details od
        LEFT JOIN
    orders o ON od.Order_ID = o.Order_ID
WHERE
    o.Order_ID IS NULL;
    
    SELECT
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    COUNT(DISTINCT o.Customer_ID) AS Total_Customers,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    SUM(od.Quantity) AS Total_Quantity,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    ROUND((SUM(od.Profit) / SUM(od.Sales)) * 100, 2) AS Profit_Margin
FROM orders o
JOIN order_details od
    ON o.Order_ID = od.Order_ID;



