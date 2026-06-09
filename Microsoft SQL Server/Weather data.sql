-- creation of database
CREATE DATABASE WeatherData;
GO
-- start database
USE WeatherData;
GO
CREATE TABLE City (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
)

INSERT INTO City (Name) VALUES
('Warszawa'),
('Kraków'),
('Łódź'),
('Gdańsk');

CREATE TABLE Reading (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CityId INT NOT NULL,
    FOREIGN KEY (CityId) REFERENCES City(Id),
    Temperature DECIMAL (4,2) NOT NULL,
    Humidity INT NOT NULL,
    WindSpeed INT NOT NULL,
    Precipitation DECIMAL(4,1) NOT NULL,
    RecordedAt DATETIME2 NOT NULL
)

INSERT INTO Reading (CityId, Temperature, Humidity, WindSpeed, Precipitation, RecordedAt) VALUES 
-- Warszawa
-- Winter
(1, -2.50, 85, 25, 1.2, '2025-12-10 06:00:00'),
(1, -0.50, 80, 20, 0.0, '2025-12-20 12:00:00'),
(1, -5.00, 90, 15, 2.5, '2026-01-05 18:00:00'),
(1, -3.20, 88, 30, 0.8, '2026-01-25 06:00:00'),
(1, 1.50, 75, 12, 0.0, '2026-02-12 12:00:00'),
(1, -1.00, 82, 18, 1.0, '2026-02-28 18:00:00'),
-- Spring
(1, 5.00, 70, 15, 0.0, '2026-03-10 06:00:00'),
(1, 8.50, 65, 22, 3.4, '2026-03-22 12:00:00'),
(1, 12.00, 60, 10, 0.0, '2026-04-05 18:00:00'),
(1, 14.50, 55, 14, 0.0, '2026-04-18 06:00:00'),
(1, 18.00, 50, 12, 1.5, '2026-05-03 12:00:00'),
(1, 21.30, 48, 8, 0.0, '2026-05-20 18:00:00'),
-- Summer
(1, 22.00, 45, 11, 0.0, '2026-06-11 06:00:00'),
(1, 26.50, 30, 16, 0.0, '2026-06-25 12:00:00'),
(1, 29.00, 70, 25, 12.4, '2026-07-08 18:00:00'),
(1, 24.00, 65, 14, 2.0, '2026-07-22 06:00:00'),
(1, 31.50, 45, 10, 0.0, '2026-08-04 12:00:00'),
(1, 27.00, 70, 9, 1.7, '2026-08-19 18:00:00'),
-- Fall
(1, 16.00, 65, 12, 0.0, '2026-09-05 06:00:00'),
(1, 19.50, 58, 15, 0.0, '2026-09-18 12:00:00'),
(1, 11.00, 75, 20, 2.1, '2026-10-10 18:00:00'),
(1, 8.50, 80, 18, 0.5, '2026-10-24 06:00:00'),
(1, 5.00, 85, 35, 5.6, '2026-11-08 12:00:00'),
(1, 2.10, 92, 22, 1.8, '2026-11-23 18:00:00'),

-- Kraków
-- Winter
(2, -4.00, 90, 10, 0.5, '2025-12-11 12:00:00'),
(2, -2.00, 85, 8, 2.0, '2025-12-21 18:00:00'),
(2, -7.50, 92, 5, 0.0, '2026-01-06 06:00:00'),
(2, -3.00, 89, 12, 4.1, '2026-01-26 12:00:00'),
(2, 0.50, 80, 15, 0.5, '2026-02-13 18:00:00'),
(2, -2.30, 84, 11, 0.0, '2026-02-27 06:00:00'),
-- Spring
(2, 4.20, 75, 14, 1.0, '2026-03-09 12:00:00'),
(2, 9.00, 60, 25, 0.0, '2026-03-23 18:00:00'),
(2, 11.50, 64, 18, 0.0, '2026-04-06 06:00:00'),
(2, 16.00, 52, 12, 0.0, '2026-04-19 12:00:00'),
(2, 17.50, 58, 10, 2.2, '2026-05-04 18:00:00'),
(2, 22.00, 50, 7, 0.0, '2026-05-21 06:00:00'),
-- Summer
(2, 23.50, 40, 9, 0.0, '2026-06-12 12:00:00'),
(2, 25.00, 62, 14, 4.5, '2026-06-26 18:00:00'),
(2, 30.20, 50, 11, 0.0, '2026-07-09 06:00:00'),
(2, 33.00, 40, 13, 0.0, '2026-07-23 12:00:00'),
(2, 26.00, 68, 30, 15.0, '2026-08-05 18:00:00'),
(2, 24.50, 55, 8, 0.0, '2026-08-20 06:00:00'),
-- Fall
(2, 17.20, 62, 10, 0.0, '2026-09-06 12:00:00'),
(2, 18.00, 60, 12, 0.0, '2026-09-19 18:00:00'),
(2, 12.50, 72, 14, 0.0, '2026-10-11 06:00:00'),
(2, 7.00, 85, 9, 3.0, '2026-10-25 12:00:00'),
(2, 4.50, 88, 16, 0.8, '2026-11-09 18:00:00'),
(2, 1.00, 95, 7, 0.0, '2026-11-24 06:00:00'),

-- Łódź
-- Winter
(3, -3.00, 87, 22, 0.0, '2025-12-12 18:00:00'),
(3, -1.20, 82, 18, 1.5, '2025-12-22 06:00:00'),
(3, -6.00, 91, 14, 0.9, '2026-01-07 12:00:00'),
(3, -4.50, 86, 28, 3.0, '2026-01-27 18:00:00'),
(3, 0.80, 78, 16, 0.0, '2026-02-14 06:00:00'),
(3, -2.00, 85, 20, 0.4, '2026-02-26 12:00:00'),
-- Spring
(3, 3.80, 72, 16, 0.0, '2026-03-08 18:00:00'),
(3, 7.90, 68, 20, 2.0, '2026-03-24 06:00:00'),
(3, 10.80, 62, 13, 0.5, '2026-04-07 12:00:00'),
(3, 15.10, 54, 15, 0.0, '2026-04-20 18:00:00'),
(3, 16.90, 60, 11, 4.0, '2026-05-05 06:00:00'),
(3, 20.50, 52, 9, 0.0, '2026-05-22 12:00:00'),
-- Summer
(3, 21.00, 64, 12, 0.0, '2026-06-13 18:00:00'),
(3, 24.80, 58, 14, 0.0, '2026-06-27 06:00:00'),
(3, 28.10, 55, 18, 1.2, '2026-07-10 12:00:00'),
(3, 30.90, 48, 15, 0.0, '2026-07-24 18:00:00'),
(3, 27.50, 62, 22, 8.3, '2026-08-06 06:00:00'),
(3, 25.00, 53, 10, 0.0, '2026-08-21 12:00:00'),
-- Fall
(3, 16.50, 64, 11, 0.0, '2026-09-07 18:00:00'),
(3, 18.20, 59, 14, 0.0, '2026-09-20 06:00:00'),
(3, 11.80, 76, 17, 1.1, '2026-10-12 12:00:00'),
(3, 8.00, 82, 15, 0.0, '2026-10-26 18:00:00'),
(3, 4.90, 86, 24, 4.2, '2026-11-10 06:00:00'),
(3, 1.80, 90, 19, 2.0, '2026-11-25 12:00:00'),

-- Gdańsk
-- Winter
(4, 1.00, 90, 35, 2.0, '2025-12-13 06:00:00'),
(4, 2.50, 88, 42, 4.5, '2025-12-23 12:00:00'),
(4, -1.50, 85, 28, 1.1, '2026-01-08 18:00:00'),
(4, -0.80, 89, 31, 0.0, '2026-01-28 06:00:00'),
(4, 2.00, 82, 22, 0.5, '2026-02-15 12:00:00'),
(4, 0.50, 86, 26, 1.2, '2026-02-25 18:00:00'),
-- Spring
(4, 3.00, 80, 24, 0.0, '2026-03-07 06:00:00'),
(4, 5.50, 75, 18, 1.8, '2026-03-25 12:00:00'),
(4, 8.20, 70, 15, 0.0, '2026-04-08 18:00:00'),
(4, 11.00, 68, 20, 0.0, '2026-04-21 06:00:00'),
(4, 14.00, 65, 14, 2.1, '2026-05-06 12:00:00'),
(4, 16.50, 62, 16, 0.0, '2026-05-23 18:00:00'),
-- Summer
(4, 19.00, 70, 15, 0.0, '2026-06-14 06:00:00'),
(4, 21.50, 68, 22, 0.5, '2026-06-28 12:00:00'),
(4, 24.00, 65, 17, 0.0, '2026-07-11 18:00:00'),
(4, 25.50, 60, 14, 0.0, '2026-07-25 06:00:00'),
(4, 23.00, 72, 28, 9.0, '2026-08-07 12:00:00'),
(4, 21.00, 66, 19, 0.0, '2026-08-22 18:00:00'),
-- Fall
(4, 15.80, 72, 20, 0.0, '2026-09-08 06:00:00'),
(4, 16.20, 70, 25, 0.8, '2026-09-21 12:00:00'),
(4, 12.00, 78, 32, 3.5, '2026-10-13 18:00:00'),
(4, 9.50, 82, 27, 1.2, '2026-10-27 06:00:00'),
(4, 6.80, 85, 38, 6.0, '2026-11-11 12:00:00'),
(4, 4.00, 89, 30, 2.5, '2026-11-26 18:00:00');



-- indexes for better query searches optimalisation

-- Index on City Name to speed up queries with where c.Name = 'value'
CREATE NONCLUSTERED INDEX IX_City_Name ON City(Name);

-- Index on RecordedAt to speed up all date-based filtering, sorting, and functions like DATEPART
-- Temperature, WindSpeed, Humidity, Precipitation included so the index can answer queries without looking back at the table 
CREATE NONCLUSTERED INDEX IX_Reading_RecordedAt ON Reading(RecordedAt)
INCLUDE (Temperature, WindSpeed, Humidity, Precipitation);


-- introduction to tables in database
SELECT name FROM sys.tables;
SELECT * FROM City;
SELECT * FROM Reading;
select c.Name, r.* from City c
join Reading r on c.Id = r.CityId;


-- queries

-- horrendous query showing max and min values of data registered in databases and where and when they were registered
SELECT 
    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.Temperature = (SELECT MAX(Temperature) FROM Reading)) AS [MaxTempCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.Temperature = (SELECT MAX(Temperature) FROM Reading)) AS [MaxTempDate],
    (SELECT MAX(Temperature) FROM Reading) AS [MaxTemperature],
    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.Temperature = (SELECT MIN(Temperature) FROM Reading)) AS [MinTempCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.Temperature = (SELECT MIN(Temperature) FROM Reading)) AS [MinTempDate],
    (SELECT MIN(Temperature) FROM Reading) AS [MinTemperature],

    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.Humidity = (SELECT MAX(Humidity) FROM Reading)) AS [MaxHumCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.Humidity = (SELECT MAX(Humidity) FROM Reading)) AS [MaxHumDate],
    (SELECT MAX(Humidity) FROM Reading) AS [MaxHumidity],
    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.Humidity = (SELECT MIN(Humidity) FROM Reading)) AS [MinHumCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.Humidity = (SELECT MIN(Humidity) FROM Reading)) AS [MinHumDate],
    (SELECT MIN(Humidity) FROM Reading) AS [MinHumidity],

    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.WindSpeed = (SELECT MAX(WindSpeed) FROM Reading)) AS [MaxWSCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.WindSpeed = (SELECT MAX(WindSpeed) FROM Reading)) AS [MaxWSDate],
    (SELECT MAX(WindSpeed) FROM Reading) AS [MaxWindSpeed],
    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.WindSpeed = (SELECT MIN(WindSpeed) FROM Reading)) AS [MinWSDate],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.WindSpeed = (SELECT MIN(WindSpeed) FROM Reading)) AS [MinWSDate],
    (SELECT MIN(WindSpeed) FROM Reading) AS [MinWindSpeed],

    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.Precipitation = (SELECT MAX(Precipitation) FROM Reading)) AS [MaxPCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.Precipitation = (SELECT MAX(Precipitation) FROM Reading)) AS [MaxPDate],
    (SELECT MAX(Precipitation) FROM Reading) AS [MaxPrecipitation],
    (SELECT TOP 1 c.Name FROM Reading r JOIN City c ON r.CityId = c.Id WHERE r.Precipitation = (SELECT MIN(Precipitation) FROM Reading)) AS [MinCity],
    (SELECT TOP 1 r.RecordedAt FROM Reading r WHERE r.Precipitation = (SELECT MIN(Precipitation) FROM Reading)) AS [MinPDate],
    (SELECT MIN(Precipitation) FROM Reading) AS [MinPrecipitation];

-- bit nicer solution, separate queries
-- highest temperature
WITH RankedMaxTemp AS (
    SELECT c.Name, r.RecordedAt, r.Temperature,
           ROW_NUMBER() OVER (ORDER BY r.Temperature DESC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, Temperature AS [MaxTemperature] 
FROM RankedMaxTemp WHERE [rank] = 1;

-- lowest temperature
WITH RankedMinTemp AS (
    SELECT c.Name, r.RecordedAt, r.Temperature,
           ROW_NUMBER() OVER (ORDER BY r.Temperature ASC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, Temperature AS [MinTemperature] 
FROM RankedMinTemp WHERE [rank] = 1;

-- highest wind speed
WITH RankedMaxWind AS (
    SELECT c.Name, r.RecordedAt, r.WindSpeed,
           ROW_NUMBER() OVER (ORDER BY r.WindSpeed DESC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, WindSpeed AS [MaxWindSpeed] 
FROM RankedMaxWind WHERE [rank] = 1;

-- lowest wind speed
WITH RankedMinWind AS (
    SELECT c.Name, r.RecordedAt, r.WindSpeed,
           ROW_NUMBER() OVER (ORDER BY r.WindSpeed ASC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, WindSpeed AS [MinWindSpeed] 
FROM RankedMinWind WHERE [rank] = 1;

-- highest humidity
WITH RankedMaxHum AS (
    SELECT c.Name, r.RecordedAt, r.Humidity,
           ROW_NUMBER() OVER (ORDER BY r.Humidity DESC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, Humidity AS [MaxHumidity] 
FROM RankedMaxHum WHERE [rank] = 1;

-- lowest humidity
WITH RankedMinHum AS (
    SELECT c.Name, r.RecordedAt, r.Humidity,
           ROW_NUMBER() OVER (ORDER BY r.Humidity ASC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, Humidity AS [MinHumidity] 
FROM RankedMinHum WHERE [rank] = 1;

-- highest precipitation
WITH RankedMaxPrec AS (
    SELECT c.Name, r.RecordedAt, r.Precipitation,
           ROW_NUMBER() OVER (ORDER BY r.Precipitation DESC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, Precipitation AS [MaxPrecipitation] 
FROM RankedMaxPrec WHERE [rank] = 1;

-- lowest precipitation ( aka no precipitation and due to many non rainy days we choose the first one that happend)
WITH RankedMinPrec AS (
    SELECT c.Name, r.RecordedAt, r.Precipitation,
           ROW_NUMBER() OVER (ORDER BY r.Precipitation ASC, r.RecordedAt ASC) AS [rank]
    FROM City c JOIN Reading r ON c.Id = r.CityId
)
SELECT Name AS [City], RecordedAt, Precipitation AS [MinPrecipitation] 
FROM RankedMinPrec WHERE [rank] = 1;




-- show max temperature in cities
select c.Name, r.Temperature  FROM City c 
join Reading r on c.Id = r.CityId  where r.Temperature = ( select MAX(s.Temperature) from Reading s where s.CityId = r.CityId );

-- show max and min temperature in cities
SELECT c.Name, MAX(r.Temperature) AS MaxTemperature, MIN(r.Temperature) AS MinTemperature
FROM City c JOIN Reading r ON c.Id = r.CityId GROUP BY c.Name;

-- query announcing if spring is coming (limited to March and early April)
-- using separate when clauses to prevent showing "Spring is coming" at the end of April when spring has already arrived
select c.Name, r.Temperature, FORMAT(RecordedAt,'dd/MM/yyyy') as [Date],
case
when r.Temperature > 8 and DATEPART(MONTH, RecordedAt) = 3 then 'Spring is coming :D'
when r.Temperature > 8 and DATEPART(MONTH, RecordedAt) = 4 and DATEPART(DAY, RecordedAt) <= 10  then 'Spring is coming :D'
else ''
end as [Awaiting Spring]
from City c
join Reading r on c.Id = r.CityId ORDER BY r.RecordedAt ASC;

-- query that oversimplifies Beaufort wind force scale
select c.Name, FORMAT(RecordedAt,'dd/MM/yyyy') as [Date], r.WindSpeed,
case
when r.WindSpeed <= 15 then 'calm'
when r.WindSpeed <= 30 then 'breeze'
else 'gale'
end as [Wind force]
from City c
join Reading r on c.Id = r.CityId ORDER BY r.RecordedAt ASC;

--query showing how many gals each city had
with WindForce as (
    select c.Name, FORMAT(RecordedAt,'dd/MM/yyyy') as [Date], r.WindSpeed,
case
when r.WindSpeed <= 15 then 'calm'
when r.WindSpeed <= 30 then 'breeze'
else 'gale'
end as [Wind force]
from City c
join Reading r on c.Id = r.CityId
)
select Name, case  
when COUNT(case when [Wind force] = 'gale' then 1 end) > 0 
            then CAST(COUNT(case when [Wind force] = 'gale' then 1 end) as VARCHAR(10))
        else 'no gales registered' 
    end as [GaleDaysCount]
FROM WindForce 
GROUP BY Name 
ORDER BY COUNT(case when [Wind force] = 'gale' then 1 end) DESC;

-- query showing previous temperature next to actual date
select c.Name, r.Temperature, 
COALESCE( CAST(LAG(r.Temperature) OVER (PARTITION BY c.Name ORDER BY r.RecordedAt) AS VARCHAR(20)),  'No previous data' ) AS PreviousTemperature
from City c
join Reading r on c.Id = r.CityId order BY r.CityId ASC, r.RecordedAt ASC;

-- query showing where and when temperature was higher than declared temperature
DECLARE @QueryTemperature AS DECIMAL (4,2);
SET @QueryTemperature = 20.00;
select c.Name, FORMAT(r.RecordedAt, 'dd/MM/yyyy HH:mm') as [Recorded at], r.Temperature from City c
join Reading r on c.Id = r.CityId where r.Temperature > @QueryTemperature order by r.RecordedAt ASC;

-- query reviewing the temperature in Warsaw during winter
select c.Name, r.Temperature, FORMAT(RecordedAt,'dd/MM/yyyy') as [Date],
case
when r.Temperature <= -2.5 then 'Nice winter C:'
else 'Meh winter :/'
end as [Winter review]
from City c 
join Reading r on c.Id = r.CityId 
where c.Name = 'Warszawa' and DATEPART(MONTH, r.RecordedAt) IN (12, 1, 2)
ORDER BY r.RecordedAt ASC;


-- query showing the highest Temperature depending on City declared in variable, in this case Gdańsk
DECLARE @QueryCity AS VARCHAR(50);
SET @QueryCity = 'Gdańsk';
IF EXISTS (SELECT 1 FROM City WHERE Name = @QueryCity)
BEGIN
select @QueryCity AS [City], Max(r.Temperature) as MaxTemperature from City c
join Reading r on c.Id = r.CityId
where c.Name = @QueryCity;
END
ELSE
BEGIN
    SELECT 'Error: The specified city does not exist in the database.' AS [Validation Message];
    select 'This are the avaliable cities:'
    select Name from City;
END


-- query checking weather for a declared city and the closest registered date
-- i am aware that i can't redeclare the variable, 
-- but due to lack of knowledge how this script would be used (all at once, separate queries)
-- i decided to put second declaration near query for comfort of using it
DECLARE @QueryCity AS VARCHAR(50); 
DECLARE @TargetDate AS DATETIME2;
SET @QueryCity = 'Gdańsk';
SET @TargetDate = '2026-07-07 17:00:00';

IF EXISTS (SELECT 1 FROM City WHERE Name = @QueryCity)
BEGIN
    SELECT TOP 1 
        c.Name AS [City],
        r.Temperature,
        r.Humidity,
        r.WindSpeed as [Wind speed],
        r.Precipitation, 
        FORMAT(r.RecordedAt, 'dd/MM/yyyy HH:mm') AS [Actual Recorded At],
        @TargetDate AS [Searched Date],
        ABS(DATEDIFF(MINUTE, r.RecordedAt, @TargetDate)) AS [Difference In Minutes]
    FROM City c
    JOIN Reading r ON c.Id = r.CityId
    WHERE c.Name = @QueryCity
    ORDER BY ABS(DATEDIFF(MINUTE, r.RecordedAt, @TargetDate)) ASC;
END
ELSE
BEGIN
    SELECT 'Error: The specified city does not exist in the database.' AS [Validation Message];    
    select 'This are the avaliable cities:'
    select Name from City;
END



-- preparing variables for next query
DECLARE @SeasonsTable TABLE (MonthId INT, SeasonName VARCHAR(10));
INSERT INTO @SeasonsTable VALUES 
(3, 'Spring'), (4, 'Spring'), (5, 'Spring'),
(6, 'Summer'), (7, 'Summer'), (8, 'Summer'),
(9, 'Fall'), (10, 'Fall'), (11, 'Fall'),
(1, 'Winter'), (2, 'Winter'), (12, 'Winter');

DECLARE @ChosenSeason AS VARCHAR(10);
SET @ChosenSeason = 'Spring'; -- available options: Spring, Summer, Fall, Winter

-- query showing average temperature in cities in choosen season
with SeasonalAverage as (
    SELECT c.Name, 
    AVG(r.Temperature) AS [Average temperature]
FROM City c
join Reading r on c.Id = r.CityId
join @SeasonsTable s on DATEPART(MONTH, r.RecordedAt) = s.MonthId
where s.SeasonName = @ChosenSeason
GROUP BY c.Name
)
SELECT Name, [Average temperature]
FROM SeasonalAverage;


-- another copy paste of variables this time i use v2 to differiate between them
DECLARE @SeasonsTablev2 TABLE (MonthId INT, SeasonName VARCHAR(10));
INSERT INTO @SeasonsTablev2 VALUES 
(3, 'Spring'), (4, 'Spring'), (5, 'Spring'),
(6, 'Summer'), (7, 'Summer'), (8, 'Summer'),
(9, 'Fall'), (10, 'Fall'), (11, 'Fall'),
(1, 'Winter'), (2, 'Winter'), (12, 'Winter');

DECLARE @ChosenSeasonv2 AS VARCHAR(10);
SET @ChosenSeasonv2 = 'Spring';

-- query showing highest average temperature
with SeasonalAverage as (
    SELECT c.Name, 
    AVG(r.Temperature) AS [Average temperature]
FROM City c
join Reading r on c.Id = r.CityId
join @SeasonsTablev2 s on DATEPART(MONTH, r.RecordedAt) = s.MonthId
where s.SeasonName = @ChosenSeasonv2
GROUP BY c.Name
),
HighestAverage AS (
    SELECT Name, 
           [Average temperature] AS [Highest Average Temperature],
           ROW_NUMBER() OVER (ORDER BY [Average temperature] DESC) AS rank
    FROM SeasonalAverage
)
SELECT Name, [Highest Average Temperature]
FROM HighestAverage
WHERE rank = 1;



-- query checking if the sum of calm winds is higher or lower than the highers registered wind force
with WindForce as (
    select r.WindSpeed, case when r.WindSpeed <= 5 then r.WindSpeed else 0 end as [Calm Wind]
from Reading r
),
Sumator as (
    select max(WindSpeed) as [Max Wind], sum([Calm Wind]) as [Sum of Calm Winds]
from WindForce  
)
select case when [Max Wind] < [Sum of Calm Winds] then 'The sum of calm winds is higher than the highest wind' 
else 'The sum of calm winds is lower than the highest wind' end as [Verdict]
from Sumator;

-- optimized version 
with Adder as (
    select max(WindSpeed) as [Max Wind], sum(case when r.WindSpeed <= 5 then r.WindSpeed else 0 end) as [Sum of Calm Winds]
from Reading r
)
select case when [Max Wind] < [Sum of Calm Winds] then 'The sum of calm winds is higher than the highest wind' 
else 'The sum of calm winds is lower than the highest wind' end as [Verdict]
from Adder;


-- query checking if low humidity days compare to low/non precipitation days
with Analiser as (
select  sum(case when r.Humidity <= 40 then 1 else 0 end) as [Low Humidity],
        sum(case when r.Precipitation <= 0.5 then 1 else 0 end) as [Low Precipitation]
from Reading r  
)
select case when [Low Humidity] between [Low Precipitation] - 5 and [Low Precipitation] + 5 then 'Yes' 
else 'No' end as [Verdict]
from Analiser;



-- cleanup
-- USE master;
-- GO
-- ALTER DATABASE WeatherData SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- GO
-- DROP DATABASE WeatherData;
-- GO