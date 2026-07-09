-- introduction to tables in database
SELECT name FROM sys.tables;
SELECT * FROM Package;
SELECT * FROM Praline;
SELECT * FROM Ingredient;
SELECT * FROM Composition;
SELECT * FROM Purchase;
SELECT * FROM v_PurchaseWithPrice;
SELECT * FROM [Date];
SELECT * FROM [Morning Delivery]; 
SELECT * FROM [Closing Stock]; 

-- package sql
-- show the most frequently used package
SELECT TOP 1 PackageName, COUNT(PackageName) AS TimesUsed FROM v_PurchaseWithPrice
GROUP BY PackageName ORDER BY TimesUsed DESC;

-- which material has the most shape options
-- i assume that the names of packages in table would be made in convention: 'Material, shape'
-- which would made the search of material easier as i only need to get the first word of name
-- function inspired by https://stackoverflow.com/questions/707610/extract-the-first-word-of-a-string-in-a-sql-server-query
-- modified to delete the comma
go
CREATE FUNCTION [Material name puller] (@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
    RETURN replace(SUBSTRING(@value, 1, (CHARINDEX(' ', @value + ' ') - 1)), ',', '')
END
go

with MaterialCTE as (
    SELECT [dbo].[Material name puller](Name) as [Material]
FROM Package
)
SELECT top 1 with ties [Material], count(*) as [Amount]
FROM MaterialCTE group by [Material] order by [Amount] desc;


-- praline sql

-- pralines with the most and the least ingredients
-- view for easier query creation
GO
CREATE VIEW v_PralineandIngredient AS
select p.Name as [PralineName], i.Name as [IngredientName] from Praline p
join Composition c on p.Id = c.PralineId
join Ingredient i on i.Id = c.IngredientId;
GO

select top 1 with ties PralineName, count(IngredientName) as Amount from v_PralineandIngredient group by PralineName order by Amount desc;
select top 1 with ties PralineName, count(IngredientName) as Amount from v_PralineandIngredient group by PralineName order by Amount;

-- pralines that have 3 ingredients
SELECT PralineName FROM v_PralineandIngredient
GROUP BY PralineName
HAVING COUNT(IngredientName) = 3;

-- pralines containing the same ingredient mutliple times
SELECT PralineName, IngredientName, count(*) as Amount FROM v_PralineandIngredient
GROUP BY PralineName, IngredientName
HAVING COUNT(*) >=2;

-- pralines that have choosen ingredient
DECLARE @QueryIngredient AS VARCHAR(50);
SET @QueryIngredient = 'Mint';
IF EXISTS (SELECT 1 FROM Ingredient WHERE Name = @QueryIngredient)
BEGIN
select PralineName from v_PralineandIngredient v
where v.IngredientName = @QueryIngredient;
END
ELSE
BEGIN
    SELECT 'Error: The specified ingredient does not exist in the database. Available ingredients below:' AS [Validation Message];
    select Name from Ingredient;
END

-- weight of each praline type
go
CREATE OR ALTER FUNCTION [Praline weight] (@value DECIMAL(5,2))
RETURNS DECIMAL(5,2)
AS
BEGIN RETURN CAST((100.00 / NULLIF(@value, 0)) AS DECIMAL(5,2));
END
go

select Name, [dbo].[Praline weight]([Amount needed for 100g]) as [Praline weight] from Praline;

-- pralines requiring the largest and smallest amounts to reach 100g, along with their weights
select top 1 with ties Name, [Amount needed for 100g], [dbo].[Praline weight]([Amount needed for 100g]) as [Praline weight] from Praline order by [Amount needed for 100g] desc;
select top 1 with ties Name, [Amount needed for 100g], [dbo].[Praline weight]([Amount needed for 100g]) as [Praline weight] from Praline order by [Amount needed for 100g];


-- transaction and delivery sql
-- the avarage transaction weight ( the company deal, which buys over 50kg each day, is an outlier and shall not be counted )
select avg([Weight in grams]) from v_PurchaseWithPrice where [Weight in grams] < 50000;

-- how much packages price influents total price
select PackagePrice, TotalPrice, cast((PackagePrice*100.0 /TotalPrice)as decimal(5,2)) as [Precentage influence] from v_PurchaseWithPrice;

-- the most suboptimal package selection
select top 1 PackagePrice, TotalPrice, cast((PackagePrice*100.0/TotalPrice) as decimal(5,2)) as [Precentage influence] from v_PurchaseWithPrice
order by [Precentage influence] desc;

-- the most popular praline of the week
GO
CREATE Or Alter VIEW v_PralineandStock AS
select p.Name as [PralineName], c.Weight, d.[Date], [Amount needed for 100g] from Praline p
join  [Closing Stock] c on p.Id = c.PralineId
join [Date] d on d.Id = c.DateId;
GO

select top 1 PralineName, SUM(5.00-Weight) as [Weight bought] from v_PralineandStock
group by PralineName order by [Weight bought] desc;

-- the most popular praline of each day
-- so once again my data was not prepared up to par and everyday the most popular praline is the same one :|
WITH PopPraline AS (
    SELECT PralineName, [Date], (5.00-Weight) as [Weight bought],
           DENSE_RANK() OVER (Partition by [Date] ORDER BY (5.00-Weight)  DESC) AS [rank]
    FROM v_PralineandStock
)
SELECT PralineName, [Date], [Weight bought]
FROM PopPraline WHERE [rank] = 1;

-- total weight of pralines sold every day
SELECT [Date], SUM(5.00-Weight) as [Sold weight] from v_PralineandStock
group by [Date] order by [Date] ASC;

-- day with the highest sales volume by weight
select top 1 [Date], SUM(5.00-Weight) as [Sold weight] from v_PralineandStock
group by [Date] order by [Sold weight] desc;

-- how many chocholate pralines were sold on monday, 8.06
-- in this query you may think that my previous query about most popular praline is wrong, but
-- i was determining popularity with weight and not pieces 
-- i checked and the math is correct
-- while Strawberry Fields sold 321 pieces, each weights 14,29g, which accumulates to 4587g
-- and advocat. with 190 pieces each 25g accumulates to 4750g
-- version by kind
SELECT [PralineName], FLOOR(((5.00-Weight)*1000.00)/[dbo].[Praline weight]([Amount needed for 100g])) as [Sold pieces]
from v_PralineandStock where [Date] = '2026-06-08';
-- total
SELECT Sum(FLOOR(((5.00-Weight)*1000.00)/[dbo].[Praline weight]([Amount needed for 100g]))) as [Sold pieces]
from v_PralineandStock where [Date] = '2026-06-08';

-- and here is the modified version that checkes the most popular praline by sold pieces, and once again it's the same praline everyday
WITH PopPraline AS (
    SELECT PralineName, [Date], FLOOR(((5.00-Weight)*1000.00)/[dbo].[Praline weight]([Amount needed for 100g])) as [Sold pieces],
           DENSE_RANK() OVER (Partition by [Date] ORDER BY FLOOR(((5.00-Weight)*1000.00)/[dbo].[Praline weight]([Amount needed for 100g])) DESC) AS [rank] -- ROW_NUMBER jeden najwyższy wynik DENSE_RANK dla remisów
    FROM v_PralineandStock
)
SELECT PralineName, [Date], [Sold pieces]
FROM PopPraline WHERE [rank] = 1;

-- most popular peak hours for transactions
SELECT top 1 with ties DATEPART(HOUR, [Date of purchase]) as [Purchase Hour], count(*) as [Amount of transactions] from purchase
group by DATEPART(HOUR, [Date of purchase]) order by [Amount of transactions] desc;

-- the earliest and latest transaction times
SELECT top 1 FORMAT( [Date of purchase],'HH:mm') as [Purchase Hour] from purchase order by [Purchase Hour];
SELECT FORMAT(Max( [Date of purchase]),'HH:mm') as [Purchase Hour] from purchase;
-- two in one version
SELECT 
    FORMAT(MIN([Date of purchase]), 'HH:mm') AS [Earliest Purchase],
    FORMAT(MAX([Date of purchase]), 'HH:mm') AS [Latest Purchase]
FROM Purchase;

-- number of times the final transaction of the day was made by a retail customer and not a B2B bulk purchase
WITH LastPurchases AS (
    SELECT 
        [Weight in grams], [Date of purchase],
        ROW_NUMBER() OVER ( partition by CAST([Date of purchase] AS DATE) order by [Date of purchase] DESC) AS [Rank]
    FROM Purchase
)
SELECT COUNT(*) as [Random Customer] FROM LastPurchases
WHERE [Rank] = 1  AND [Weight in grams] < 50000.00;

-- what day had the most transactions
-- due to a hardcoded constraint in the mock data generator, every day contains exactly 20 transactions
-- an oversight of bad data creation and management on my side
SELECT top 1 with ties CAST([Date of purchase] AS DATE) as [Date], count(*) as [Amount of transactions] from purchase
GROUP by CAST([Date of purchase] AS DATE) order by [Amount of transactions] desc;

-- is ai generated data correct? :
-- is Closing Stock of all praline types equal to weigth of all transactions made during the day
-- manual check of one day
select sum(((5-Weight)*1000)) from [Closing Stock] where DateId = 1;
--57100.00
select sum([Weight in Grams]) from Purchase where CAST([Date of purchase] AS DATE) = '2026-06-06'
--57095.50

WITH DailyPurchases AS (
    SELECT 
        CAST([Date of purchase] AS DATE) AS [Sales Date],
        CAST(SUM([Weight in grams]) AS DECIMAL(10,2)) AS [TotalTransactionsSum]
    FROM Purchase
    GROUP BY CAST([Date of purchase] AS DATE)
),
DailyStock AS (
    SELECT 
        d.[Date] AS [Stock Date],
        CAST(SUM((5.00 - c.Weight) * 1000) AS DECIMAL(10,2)) AS [TotalStockSum]
    FROM [Closing Stock] c
    JOIN [Date] d ON c.DateId = d.Id
    GROUP BY d.[Date]
)
SELECT 
    p.[Sales Date],
    s.[TotalStockSum] AS [Stock Sold Sum],
    p.[TotalTransactionsSum] AS [Transactions Sum],
    abs((p.[TotalTransactionsSum] - s.[TotalStockSum])) AS [Difference in Grams],
    CASE 
        WHEN p.[TotalTransactionsSum] = s.[TotalStockSum] THEN ''
        ELSE 'wrong' 
    END AS [Status]
FROM DailyPurchases p
JOIN DailyStock s ON p.[Sales Date] = s.[Stock Date]
ORDER BY p.[Sales Date];

-- is Morning Delivery equal to 5 - Closing Stock (previous day) to maintain the 5kg weight at the start of the day
GO
CREATE or alter VIEW v_DeliveryandStock AS
SELECT
    m.PralineId,
    (m.Weight) as [Delivery weight],
    (5-c.Weight) as [Stock weight],
    d.[Date] AS [Calendar Date]
FROM [Morning Delivery] m
Join [Closing Stock] c ON c.DateId = m.DateId-1 AND c.PralineId = m.PralineId
Join [Date] d ON d.Id = m.DateId
GO

select [Calendar Date], PralineId, [Delivery weight], [Stock weight],
case when  [Delivery weight] = [Stock weight] then '' else 'wrong'
end as [Status]
from v_DeliveryandStock where [Calendar Date] BETWEEN '2026-06-07' and '2026-06-11';
