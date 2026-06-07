-- creation of database
CREATE DATABASE Disk;
GO
-- start database
USE Disk;
GO

-- creating tables and inserting rows into them
CREATE TABLE Author ( 
    id INT IDENTITY(1,1) PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL
)

INSERT INTO Author (nickname) VALUES
('Ancymon'),
('Storczyk'),
('Fred'),
('Grucha');

INSERT INTO Author (nickname) VALUES
('Abażur');

CREATE TABLE [File] (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    dateandtime DATETIME NOT NULL DEFAULT GETDATE(),
    type VARCHAR(20) NOT NULL DEFAULT 'txt',
    description VARCHAR(MAX) NULL,
    authorId INT,
    FOREIGN KEY (authorId) REFERENCES Author(Id)
)

INSERT INTO [File] (name, dateandtime, description, authorId) VALUES 
('super ważny plik', '2025-04-01 03:33:33', 'HAHAHA PRIMA APRILIS',1);

INSERT INTO [File] (name, description, authorId) VALUES 
('super wazny plik z dzisiejsza datą', 'nie ma pierwszego kwietia :C', 1);

INSERT INTO [File] (name, dateandtime, type, description, authorId) VALUES 
('ale tym razem naprawdę ważny plik', '2025-04-01', 'hehehehe', 'HAHAHAHA DALEJ DAŁEŚ SIĘ NABRAĆ', 1);

INSERT INTO [File] (name, dateandtime, type, description, authorId) VALUES 
('Lista zagadnień na egzamin','2026-06-04','pdf','
Kluczowe pojęcia bezpieczeństwa komputerowego
Zagrożenia i ataki 
Płaszczyzna ataku i drzewa ataku
Szyfry symetryczne blokowe i strumieniowe
Kody uwierzytelniania wiadomości
Funkcje skrótu i ich zastosowanie
Szyfry z kluczem publicznym — poufność i uwierzytelnianie
Podpis cyfrowy i koperta cyfrowa
Certyfikat klucza publicznego
Środki elektronicznego uwierzytelniania użytkowników
Uwierzytelnianie przez hasło
Uwierzytelnianie żetonowe
Metody biometryczne uwierzytelniania
Zdalne uwierzytelnianie użytkowników
Uznaniowa kontrola dostępu
Kontrola dostępu oparta o role
Ataki SQLi (wstrzykiwanie SQL)
Kontrola dostępu do bazy danych SQL
Rodzaje złośliwego oprogramowania ze względu na sposób propagacji
Schemat budowy wirusa
Strategie wykrywania złośliwego oprogramowania
Ataki DoS (odmowy dostępu) przez zalewanie
Ataki DoS (odmowy dostępu) na przepustowość sieci
Ataki DDoS (rozproszone DoS)
Ataki DoS ze wzmocnieniem i z odbiciem
Systemy wykrywania włamań oparte o host i sieciowe
Strategie wykrywania włamań
Rodzaje zapór sieciowych (firewalli)
Umiejscowienie firewalli w topologii sieci
Dodatkowe funkcje zapór sieciowych',2),
('Lista zakupów','2026-07-23','txt','Mleko x2, chleb x2, jogurt x3, kg pomidorów',2),
('Lista rzeczy do zrobienia','2026-07-23','txt','Odkurz, zrób zakupy',2),
('Linki do filmów na yt','2026-06-04','txt','
https://www.youtube.com/watch?v=3V7Rvo4Gvic 
https://www.youtube.com/watch?v=NnTycJg1MIo',2),
('Szczegółowe notatki na egzamin','2026-06-04','','docx',2);

UPDATE [File] set type = 'docx', DESCRIPTION = '' where id = 8; -- fixing the values ( made mistake in column order)

INSERT INTO [File] (name, dateandtime, authorId) VALUES 
('tajna instrukcja', '1999-01-01', 3),
('lokalizacja grobu', '1999-01-01', 3),
('nie chcę kopać grobu', '1999-01-01', 4),
('a sfeterek jest piękny', '1999-01-01', 4);

-- queries to introduce tables
-- show all tables in database
SELECT name FROM sys.tables;
-- show whole data in choosen tables
SELECT * FROM Author;
SELECT * FROM [File];
-- join with where codition
select * from Author, [File] 
where Author.id = [File].authorId;
-- join with join
select a.nickname, f.* from Author a
join [File] f on a.id = f.authorId;

-- queries for Author table
-- select nicknames that have 'a' in them
select nickname from Author where nickname like '%a%';

-- show longest nickname and its lenght
select top 1 with ties nickname, LEN(nickname) AS [length] from Author order by LEN(nickname) desc;

-- show nicknames that start on the most popular letter
select nickname from Author where substring(nickname,1,1) in (select top 1 with ties substring(nickname,1,1)
as letter from Author group by substring(nickname,1,1) order by count(*) desc);

-- queries for File table
-- show years of when file was added
select YEAR(dateandtime) as year from [File];

-- show files uploaded in the spawn of last year
select name, dateandtime from [File] where dateandtime between DATEADD(year, -1, GETDATE()) and GETDATE();
-- comparison operators version
select name, dateandtime from [File] where dateandtime >= DATEADD(year, -1, GETDATE()) and dateandtime <= GETDATE();

-- show files uploaded in the most active month and year
select name, dateandtime from [File] where FORMAT(dateandtime, 'yyyy-MM') in (
select top 1 FORMAT(dateandtime, 'yyyy-MM') from [File] group by FORMAT(dateandtime, 'yyyy-MM') order by COUNT(*) desc );
-- window function version
with MonthlyCounts as (
select name, dateandtime,
COUNT(*) OVER(partition by FORMAT(dateandtime, 'yyyy-MM')) as ActiveCount
from [File] ),
RankedMonths as (
select name, dateandtime,
DENSE_RANK() OVER(order by ActiveCount desc) as rank
from MonthlyCounts
)
select name, dateandtime from RankedMonths where rank = 1;

-- what type of file was most often uploaded in the year 1999 and month 1
select top 1 with ties type from [File] where YEAR(dateandtime) = 1999 and MONTH(dateandtime) = 1
group by type order by COUNT(*) desc;

-- show files whose name starts on the same letter their upload month starts on
-- this querry also shows us our collation is english based
select name, DATENAME(month, dateandtime) as month from [File] where substring((DATENAME(month, dateandtime)),1,1) = substring(name,1,1);

-- select showing date in different format, a test for next query
select dateandtime, CONVERT(varchar,dateandtime,112)FROM [File];
-- insert made for next query
INSERT INTO [File] (name, dateandtime, authorId) VALUES ('Mlecz', '2000-02-01', 2);
-- select file where name lenght equals sum of numbers in date of upload (the yyyy-mm-dd part, hours skipped)
select name, dateandtime, CONVERT(varchar,dateandtime,112) as 'Formated Date', LEN(name) AS [NameLength],
    (
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 1, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 2, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 3, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 4, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 5, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 6, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 7, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 8, 1) AS INT)
    ) as [DigitsSum]
from [File]
where LEN(name) = (
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 1, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 2, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 3, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 4, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 5, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 6, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 7, 1) AS INT) +
    CAST(SUBSTRING(FORMAT(dateandtime, 'yyyyMMdd'), 8, 1) AS INT)
);

-- shows authors that made at least 4 txt files
-- check
select authorId, count (type) from [File] where type = 'txt' group by authorId;
-- final
select authorId from [File] where type = 'txt' group by authorId HAVING COUNT(type) >= 4;

-- most often used type of file
select top 1 with TIES type, count(type) as amount from [File] group by type
order by amount desc;

-- longest description
-- first in order version
SELECT TOP 1 name, LEN(description) AS length, description FROM [File] ORDER BY length DESC;
-- exact length version
SELECT name, LEN(description) AS length, description FROM [File]
WHERE LEN(description) = (SELECT MAX(LEN(description)) FROM [File]);

-- show whats the longest file name made by each author
select f.authorId, f.name, len(f.name) as lenght from [File] f where len(f.name) in 
(select max(len(s.name)) as maxlenname from [File] s where s.authorId = f.authorId);
-- window function version
WITH PositionsofFiles AS (
SELECT authorId, name, LEN(name) AS [length],
ROW_NUMBER() OVER(PARTITION BY authorId ORDER BY LEN(name) DESC) AS position
FROM [File]
)
SELECT authorId, name, [length]
FROM PositionsofFiles
WHERE position = 1;

-- shows how many files each author made 
select authorId, count(authorId) as 'file amount' from [File] group by authorId;

-- shows how many files of each type each author made 
select authorId, type, count(type) as amount from [File] group by authorId, type order by authorId;

-- show author nickname and their id
select distinct a.nickname, f.authorId from Author a JOIN [File] f ON a.id = f.authorId;

-- showing the author that haven't made any files
select a.nickname from Author a LEFT JOIN [File] f ON a.id = f.authorId where f.id IS null;

-- queries for both tables
-- select showing the author/s that made the most files
select top 1 with ties a.nickname, COUNT(f.id) as amount
from Author a join [File] f on a.id = f.authorId group by a.id, a.nickname
order by amount desc;

-- show nicknames and filenames where authors nickname and filename start on the same letter
-- this querry also shows us our collation is case nonsensitive
select distinct a.nickname, f.name from Author a
join [File] f on a.id = f.authorId where substring(nickname,1,1) = substring(name,1,1);

-- inserts made for next query
INSERT INTO Author (nickname) VALUES
('Diplodok'); -- 8 letters
INSERT INTO [File] (name, authorId) VALUES 
('Liście', 6), -- 6 letters             range 4,8 passes
('Kamienie', 6), -- 8 letters           range 6,10 passes
('Gałązki',6), -- 7 letters             range 5,9 passes
('Dippy',6), -- 5 letters               range 3,7 fails
('Carnegie Museum',6), -- 15 letters    range 12,17 fails
('Kimmeridgian',6); -- 12 letters       range 10,14 fails
 
-- select authors that have nickname similar length to file name
select distinct a.nickname, LEN(a.nickname) as [NicknameLength], f.name, 
LEN(f.name) AS [NameLength],
CONCAT(CAST(LEN(f.name) - 2 AS VARCHAR(50)), '-', CAST(LEN(f.name) + 2 AS VARCHAR(50))) as [range]
from Author a
join [File] f on a.id = f.authorId where len(nickname) between len(name)-2 and len(name)+2;


