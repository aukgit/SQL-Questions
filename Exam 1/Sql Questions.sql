   -- Write a SQL statement that returns the quantity of items ordered each day
   SELECT o.Order_Date, Sum(od.Quantity) AS [Quantity]
FROM Order_Items od
INNER JOIN
dbo.Orders o ON (o.Order_Id = od.Order_Id)
GROUP BY o.Order_Date;

-- 2.       Modify the SQL statement to limit the results to orders placed last week 
-- you can use only MSDN documentation to search the date related functions  but CANNOT copy snippets from internet  

DECLARE @currentWeekDay AS INT=  DATEPART(WEEKDAY, GETDATE());

DECLARE @LastWeekEndingDate AS Date;
DECLARE @LastWeekStartingDate AS Date;
SET @LastWeekEndingDate = DATEADD(DAY,-(@currentWeekDay),GETDATE());
SET @LastWeekStartingDate = DATEADD(DAY,-6,@LastWeekEndingDate);

SELECT @LastWeekEndingDate, @LastWeekStartingDate;

SELECT o.Order_Date, Sum(od.Quantity) AS [Quantity], COUNT(od.Quantity) AS [Records]
FROM Order_Items od
INNER JOIN
dbo.Orders o ON (o.Order_Id = od.Order_Id)
WHERE o.Order_Date BETWEEN @LastWeekStartingDate AND @LastWeekEndingDate
GROUP BY o.Order_Date;

-- How would you modify the SQL statement to limit results to days where fewer than 2600 items were sold?

DECLARE @currentWeekDay AS INT=  DATEPART(WEEKDAY, GETDATE());

DECLARE @LastWeekEndingDate AS Date; 
DECLARE @LastWeekStartingDate AS Date;
SET @LastWeekEndingDate = DATEADD(DAY,-(@currentWeekDay),GETDATE());
SET @LastWeekStartingDate = DATEADD(DAY,-6,@LastWeekEndingDate);

SELECT @LastWeekEndingDate, @LastWeekStartingDate;
  
 -- How would you modify the SQL statement to limit results to days where fewer than 2600 items were sold

SELECT o.Order_Date, Sum(od.Quantity) AS [Quantity], COUNT(od.Quantity) AS [Records]
FROM Order_Items od
INNER JOIN
dbo.Orders o ON (o.Order_Id = od.Order_Id)
WHERE CAST(o.Order_Date AS DATE) >= @LastWeekStartingDate AND CAST(o.Order_Date AS DATE) <= @LastWeekEndingDate
GROUP BY o.Order_Date
HAVING Sum(od.Quantity) <= 2600;

-- 4.       How would you modify the SQL statement to return days where no orders were placed? 
 -- You cannot use internet  for this question 
 --  Modify the SQL statement to limit the results to orders placed last week 
-- you can use only MSDN documentation to search the date related functions  but CANNOT copy snippets from internet 
DECLARE @currentWeekDay AS INT=  DATEPART(WEEKDAY, GETDATE());

DECLARE @LastWeekEndingDate AS Date; 
DECLARE @LastWeekStartingDate AS Date;
SET @LastWeekEndingDate = DATEADD(DAY,-(@currentWeekDay),GETDATE());
SET @LastWeekStartingDate = DATEADD(DAY,-6,@LastWeekEndingDate);

SELECT @LastWeekEndingDate, @LastWeekStartingDate;
DECLARE @tempTable  TABLE  (
 D1 DATE
);

DECLARE @DatePointer AS Date =  @LastWeekStartingDate;

WHILE(@DatePointer <=@LastWeekEndingDate) begin
INSERT INTO @tempTable
        ( D1 )
VALUES  ( @DatePointer  -- D1 - date
          )
  SET @DatePointer = DATEADD(DAY, 1, @DatePointer);
END

  --SELECT * FROM @tempTable;
 -- How would you modify the SQL statement to limit results to days where fewer than 2600 items were sold

SELECT [@tempTable].D1 AS Date1 FROM @tempTable
 EXCEPT 
 SELECT CAST(o.Order_Date AS DATE) AS Date1
FROM Order_Items od
INNER JOIN
dbo.Orders o ON (o.Order_Id = od.Order_Id) 
WHERE CAST(o.Order_Date AS DATE) >= @LastWeekStartingDate AND CAST(o.Order_Date AS DATE) <= @LastWeekEndingDate
GROUP BY o.Order_Date
;