CREATE DATABASE PralineShop; -- creation of database
GO
USE PralineShop; -- start of database
GO

CREATE TABLE Package (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Price DECIMAL (4,2) NOT NULL,
)

INSERT INTO Package (Name, Price) VALUES
('None', 0.00),
('Bag', 2.5),
('Tin, box', 20.45),
('Tin, heart', 34.99),
('Tin, round', 60.55);
select * from Package;
update Package set Name = 'Paper, bag' where id = 2;

CREATE TABLE Praline (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    [Amount needed for 100g] DECIMAL (2) NOT NULL
)

INSERT INTO Praline (Name, [Amount needed for 100g]) VALUES
('Strawberry Fields', 7),
('Chocho Mix', 6),
('Cherry Cherry Lady', 5),
('Black Saturday', 8),
('advocat.', 4),
('Black Hole Sun', 5),
('Yellow Submarine', 8),
('Blehcipan', 8),
('Crystal Dolphin', 10),
('Coffee', 2),
('O Green World', 6),
('Who''s Ready For Arstotzka', 6),
('Way to many stuff', 1),
('I Me Mint', 10),
('|''m very Bad', 8),
('Pistachio Check', 7),
('Carmel Song', 4),
('Crunchy Street', 8),
('Artifical Hazelnut', 8),
('Come and get your refreshment', 7);

CREATE TABLE Ingredient (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
)

CREATE NONCLUSTERED INDEX IX_Ingredient_Name ON Ingredient(Name);

INSERT INTO Ingredient (Name) VALUES
('Dark chocholate'),
('Milk chocholate'),
('White chocholate'),
('Carmel'),
('Hazelnut'),
('Strawberry'),
('Cherry'),
('Orange'),
('Macha'),
('Coffee'),
('Advocat'),
('Puffed rice'),
('Marzipan'),
('Pistachio'),
('Salt'),
('Mint');

CREATE TABLE Composition ( 
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PralineId INT NOT NULL,
    FOREIGN KEY (PralineId) REFERENCES Praline(Id),
    IngredientId INT NOT NULL,
    FOREIGN KEY (IngredientId) REFERENCES Ingredient(Id)
)

INSERT INTO Composition (PralineId, IngredientId) VALUES
(1, 2), (1, 6), (1, 9),
(2, 1), (2, 2), (2, 3),
(3, 2), (3, 7),
(4, 1),
(5, 1), (5, 11),
(6, 1), (6, 8),
(7, 3), (7, 8),
(8, 2), (8, 13),
(9, 2), (9, 4), (9, 15),
(10, 2), (10, 10), 
(11, 2), (11, 9), (11, 16),
(12, 2), (12, 11), (12, 11), (12, 15), 
(13, 2), (13, 4), (13, 6), (13, 7), (13, 8), (13, 16), 
(14, 2), (14, 16), 
(15, 1), (15,15), (15,15), (15,15),
(16, 2), (16, 14),
(17, 2), (17, 4),
(18, 2), (18, 5), (18, 12),
(19, 2), (19, 5),
(20, 2), (20, 6), (20, 16);

CREATE TABLE Purchase (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Weight in grams] DECIMAL (8,2) NOT NULL,
    [Date of purchase] DATETIME2 NOT NULL,
    PackageId INT NOT NULL,
    FOREIGN KEY (PackageId) REFERENCES Package(Id)
)

CREATE NONCLUSTERED INDEX IX_Purchase_WeightGrams ON Purchase([Weight in grams]);

GO
CREATE VIEW v_PurchaseWithPrice AS
SELECT 
    p.Id,
    p.[Weight in grams],
    p.[Date of purchase],
    pkg.Name AS PackageName,
    pkg.Price AS PackagePrice,
    CAST((p.[Weight in grams] / 1000.00) * 20.00 + pkg.Price AS DECIMAL(10,2)) AS TotalPrice
FROM Purchase p
JOIN Package pkg ON p.PackageId = pkg.Id;
GO

CREATE TABLE [Date] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Date] DATE NOT NULL,
)

CREATE NONCLUSTERED INDEX IX_Date_DateColumn ON [Date]([Date]);

INSERT INTO [Date] ( [Date] ) VALUES
('2026-06-06'),
('2026-06-07'),
('2026-06-08'),
('2026-06-09'),
('2026-06-10'),
('2026-06-11'),
('2026-06-12');

CREATE TABLE [Morning Delivery] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Weight DECIMAL (4,2) NOT NULL,
    PralineId INT NOT NULL,
    FOREIGN KEY (PralineId) REFERENCES Praline(Id),
    DateId INT NOT NULL,
    FOREIGN KEY (DateId) REFERENCES Date(Id)
)

CREATE NONCLUSTERED INDEX IX_ClosingStock_Date_Praline ON [Closing Stock](DateId, PralineId); 

-- for simplicity i decided to have a fixed weight of 5kg every morning
-- i am aware that in real bussiness model we would not get more produce that is not popular
-- until we would sell most of it
INSERT INTO [Morning Delivery] ( Weight, DateId, PralineId ) VALUES
-- Day 1 (2026-06-06)
(5.00, 1, 1), (5.00, 1, 2), (5.00, 1, 3), (5.00, 1, 4), (5.00, 1, 5), (5.00, 1, 6), (5.00, 1, 7), (5.00, 1, 8), (5.00, 1, 9), (5.00, 1, 10),
(5.00, 1, 11), (5.00, 1, 12), (5.00, 1, 13), (5.00, 1, 14), (5.00, 1, 15), (5.00, 1, 16), (5.00, 1, 17), (5.00, 1, 18), (5.00, 1, 19), (5.00, 1, 20),
-- Day 2 (2026-06-07) 
(4.70, 2, 1), (3.50, 2, 2), (2.90, 2, 3), (3.20, 2, 4), (4.85, 2, 5), (2.60, 2, 6), (2.00, 2, 7), (3.80, 2, 8), (0.90, 2, 9), (0.70, 2, 10),
(3.00, 2, 11), (2.50, 2, 12), (3.10, 2, 13), (1.90, 2, 14), (3.60, 2, 15), (2.20, 2, 16), (4.05, 2, 17), (2.80, 2, 18), (1.50, 2, 19), (3.30, 2, 20),
-- Day 3 (2026-06-08) 
(4.80, 3, 1), (3.60, 3, 2), (3.00, 3, 3), (3.10, 3, 4), (4.90, 3, 5), (2.50, 3, 6), (2.10, 3, 7), (3.90, 3, 8), (0.80, 3, 9), (0.60, 3, 10),
(3.05, 3, 11), (2.55, 3, 12), (3.15, 3, 13), (2.00, 3, 14), (3.70, 3, 15), (2.30, 3, 16), (4.20, 3, 17), (2.90, 3, 18), (1.60, 3, 19), (3.40, 3, 20),
-- Day 4 (2026-06-09) 
(4.60, 4, 1), (3.40, 4, 2), (2.80, 4, 3), (3.30, 4, 4), (4.75, 4, 5), (2.70, 4, 6), (1.90, 4, 7), (3.70, 4, 8), (1.00, 4, 9), (0.80, 4, 10),
(2.90, 4, 11), (2.40, 4, 12), (3.05, 4, 13), (1.80, 4, 14), (3.50, 4, 15), (2.10, 4, 16), (3.90, 4, 17), (2.70, 4, 18), (1.40, 4, 19), (3.20, 4, 20),
-- Day 5 (2026-06-10) 
(4.85, 5, 1), (3.65, 5, 2), (3.05, 5, 3), (3.35, 5, 4), (4.95, 5, 5), (2.75, 5, 6), (2.15, 5, 7), (3.95, 5, 8), (0.85, 5, 9), (0.65, 5, 10),
(3.15, 5, 11), (2.65, 5, 12), (3.25, 5, 13), (2.05, 5, 14), (3.75, 5, 15), (2.35, 5, 16), (4.25, 5, 17), (2.95, 5, 18), (1.65, 5, 19), (3.45, 5, 20),
-- Day 6 (2026-06-11)
(4.65, 6, 1), (3.45, 6, 2), (2.85, 6, 3), (3.25, 6, 4), (4.80, 6, 5), (2.55, 6, 6), (1.95, 6, 7), (3.75, 6, 8), (0.95, 6, 9), (0.75, 6, 10),
(2.95, 6, 11), (2.45, 6, 12), (3.10, 6, 13), (1.85, 6, 14), (3.55, 6, 15), (2.15, 6, 16), (4.00, 6, 17), (2.75, 6, 18), (1.45, 6, 19), (3.25, 6, 20),
-- Day 7 (2026-06-12)
(4.75, 7, 1), (3.55, 7, 2), (2.95, 7, 3), (3.15, 7, 4), (4.85, 7, 5), (2.65, 7, 6), (2.05, 7, 7), (3.85, 7, 8), (0.85, 7, 9), (0.65, 7, 10),
(3.05, 7, 11), (2.55, 7, 12), (3.20, 7, 13), (1.95, 7, 14), (3.65, 7, 15), (2.25, 7, 16), (4.10, 7, 17), (2.85, 7, 18), (1.55, 7, 19), (3.35, 7, 20);

CREATE TABLE [Closing Stock] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Weight DECIMAL (4,2) NOT NULL,
    PralineId INT NOT NULL,
    FOREIGN KEY (PralineId) REFERENCES Praline(Id),
    DateId INT NOT NULL,
    FOREIGN KEY (DateId) REFERENCES Date(Id)
)

INSERT INTO [Closing Stock] ( weight, DateId, PralineId ) VALUES
-- Day 1 (2026-06-06)
(0.30, 1, 1), (1.50, 1, 2), (2.10, 1, 3), (1.80, 1, 4), (0.15, 1, 5), (2.40, 1, 6), (3.00, 1, 7), (1.20, 1, 8), (4.10, 1, 9), (4.30, 1, 10),
(2.00, 1, 11), (2.50, 1, 12), (1.90, 1, 13), (3.10, 1, 14), (1.40, 1, 15), (2.80, 1, 16), (0.95, 1, 17), (2.20, 1, 18), (3.50, 1, 19), (1.70, 1, 20),
-- Day 2 (2026-06-07)
(0.20, 2, 1), (1.40, 2, 2), (2.00, 2, 3), (1.90, 2, 4), (0.10, 2, 5), (2.50, 2, 6), (2.90, 2, 7), (1.10, 2, 8), (4.20, 2, 9), (4.40, 2, 10),
(1.95, 2, 11), (2.45, 2, 12), (1.85, 2, 13), (3.00, 2, 14), (1.30, 2, 15), (2.70, 2, 16), (0.80, 2, 17), (2.10, 2, 18), (3.40, 2, 19), (1.60, 2, 20),
-- Day 3 (2026-06-08)
(0.40, 3, 1), (1.60, 3, 2), (2.20, 3, 3), (1.70, 3, 4), (0.25, 3, 5), (2.30, 3, 6), (3.10, 3, 7), (1.30, 3, 8), (4.00, 3, 9), (4.20, 3, 10),
(2.10, 3, 11), (2.60, 3, 12), (1.95, 3, 13), (3.20, 3, 14), (1.50, 3, 15), (2.90, 3, 16), (1.10, 3, 17), (2.30, 3, 18), (3.60, 3, 19), (1.80, 3, 20),
-- Day 4 (2026-06-09)
(0.15, 4, 1), (1.35, 4, 2), (1.95, 4, 3), (1.65, 4, 4), (0.05, 4, 5), (2.25, 4, 6), (2.85, 4, 7), (1.05, 4, 8), (4.15, 4, 9), (4.35, 4, 10),
(1.85, 4, 11), (2.35, 4, 12), (1.75, 4, 13), (2.95, 4, 14), (1.25, 4, 15), (2.65, 4, 16), (0.75, 4, 17), (2.05, 4, 18), (3.35, 4, 19), (1.55, 4, 20),
-- Day 5 (2026-06-10)
(0.35, 5, 1), (1.55, 5, 2), (2.15, 5, 3), (1.75, 5, 4), (0.20, 5, 5), (2.45, 5, 6), (3.05, 5, 7), (1.25, 5, 8), (4.05, 5, 9), (4.25, 5, 10),
(2.05, 5, 11), (2.55, 5, 12), (1.90, 5, 13), (3.15, 5, 14), (1.45, 5, 15), (2.85, 5, 16), (1.00, 5, 17), (2.25, 5, 18), (3.55, 5, 19), (1.75, 5, 20),
-- Day 6 (2026-06-11)
(0.25, 6, 1), (1.45, 6, 2), (2.05, 6, 3), (1.85, 6, 4), (0.15, 6, 5), (2.35, 6, 6), (2.95, 6, 7), (1.15, 6, 8), (4.15, 6, 9), (4.35, 6, 10), 
(1.95, 6, 11), (2.45, 6, 12), (1.80, 6, 13), (3.05, 6, 14), (1.35, 6, 15), (2.75, 6, 16), (0.90, 6, 17), (2.15, 6, 18), (3.45, 6, 19), (1.65, 6, 20),
-- Day 7 (2026-06-12)
(0.30, 7, 1), (1.50, 7, 2), (2.10, 7, 3), (1.80, 7, 4), (0.10, 7, 5), (2.40, 7, 6), (3.00, 7, 7), (1.20, 7, 8), (4.10, 7, 9), (4.30, 7, 10),
(2.00, 7, 11), (2.50, 7, 12), (1.85, 7, 13), (3.10, 7, 14), (1.40, 7, 15), (2.80, 7, 16), (0.95, 7, 17), (2.20, 7, 18), (3.50, 7, 19), (1.70, 7, 20);

-- due to my overstatement of how much produce i can sell in 20 transactions everyday (i should have had the fixed weight of 1kg instead of 5kg)
-- which would be usually in between 50-250g per transaction
-- lets pretend that i have a deal with a company that buys more than 50kg of pralines everyday
-- Day 1: 2026-06-06
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(55.50, '2026-06-06 08:15:23', 1), (140.00, '2026-06-06 09:40:12', 2), (95.00, '2026-06-06 10:11:45', 4),
(180.25, '2026-06-06 11:25:30', 3), (210.00, '2026-06-06 12:05:14', 1), (145.50, '2026-06-06 12:50:55', 2),
(240.00, '2026-06-06 13:15:00', 3), (190.80, '2026-06-06 13:42:18', 1), (250.00, '2026-06-06 14:02:10', 4),
(235.00, '2026-06-06 14:15:35', 2), (245.00, '2026-06-06 14:30:22', 3), (220.50, '2026-06-06 14:48:59', 1),
(215.00, '2026-06-06 15:10:41', 4), (230.00, '2026-06-06 15:22:12', 2), (248.90, '2026-06-06 15:35:04', 3),
(195.00, '2026-06-06 15:52:19', 1), (160.00, '2026-06-06 16:05:33', 4), (115.00, '2026-06-06 16:20:47', 2),
(53598.10, '2026-06-06 16:45:00', 1),
(125.95, '2026-06-06 16:50:11', 1);

-- Day 2: 2026-06-07
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(45.00, '2026-06-07 08:30:15', 2), (110.50, '2026-06-07 09:15:44', 4), (88.00, '2026-06-07 10:45:22', 1),
(150.00, '2026-06-07 11:10:59', 3), (205.50, '2026-06-07 12:14:36', 5), (130.00, '2026-06-07 12:40:12', 4),
(245.00, '2026-06-07 13:22:50', 5), (175.20, '2026-06-07 13:55:04', 3), (250.00, '2026-06-07 14:05:18', 2),
(240.00, '2026-06-07 14:18:42', 4), (235.80, '2026-06-07 14:38:11', 1), (225.00, '2026-06-07 14:55:30', 5),
(222.00, '2026-06-07 15:02:55', 2), (238.00, '2026-06-07 15:18:14', 4), (241.10, '2026-06-07 15:32:47', 1),
(180.00, '2026-06-07 15:48:02', 3), (155.00, '2026-06-07 16:12:39', 2), (105.00, '2026-06-07 16:28:51', 4),
(53688.10, '2026-06-07 16:50:00', 1),
(120.80, '2026-06-07 16:58:10', 3);

-- Day 3: 2026-06-08
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(55.00, '2026-06-08 08:45:12', 4), (95.00, '2026-06-08 09:22:30', 1), (102.50, '2026-06-08 10:15:18', 3),
(165.00, '2026-06-08 11:35:44', 2), (198.00, '2026-06-08 12:02:11', 5), (140.20, '2026-06-08 12:55:50', 1),
(230.00, '2026-06-08 13:08:14', 3), (185.00, '2026-06-08 13:49:25', 4), (250.00, '2026-06-08 14:01:03', 5),
(248.00, '2026-06-08 14:14:55', 1), (242.00, '2026-06-08 14:28:40', 3), (221.30, '2026-06-08 14:45:12', 4),
(218.00, '2026-06-08 15:05:23', 2), (232.00, '2026-06-08 15:20:59', 1), (245.50, '2026-06-08 15:40:18', 3),
(190.00, '2026-06-08 15:55:41', 4), (142.00, '2026-06-08 16:08:12', 1), (112.00, '2026-06-08 16:22:34', 2),
(109.40, '2026-06-08 16:30:50', 3),
(52519.10, '2026-06-08 16:53:00', 1);

-- Day 4: 2026-06-09
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(70.00, '2026-06-09 08:20:55', 3), (115.00, '2026-06-09 09:33:12', 1), (92.30, '2026-06-09 10:28:41', 2),
(172.00, '2026-06-09 11:42:04', 4), (202.00, '2026-06-09 12:20:19', 3), (150.00, '2026-06-09 12:48:55', 1),
(235.00, '2026-06-09 13:12:30', 2), (182.50, '2026-06-09 13:52:14', 4), (250.00, '2026-06-09 14:04:45', 3),
(244.00, '2026-06-09 14:22:11', 1), (239.00, '2026-06-09 14:41:02', 5), (228.40, '2026-06-09 14:58:33', 4),
(220.00, '2026-06-09 15:11:20', 3), (235.00, '2026-06-09 15:29:44', 5), (247.00, '2026-06-09 15:44:12', 5),
(199.00, '2026-06-09 15:58:01', 4), (168.00, '2026-06-09 16:11:50', 3), (118.00, '2026-06-09 16:26:18', 1),
(130.30, '2026-06-09 16:51:04', 4),
(56202.50, '2026-06-09 16:55:00', 1);

-- Day 5: 2026-06-10
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(82.00, '2026-06-10 08:12:40', 1), (122.50, '2026-06-10 09:50:23', 3), (99.00, '2026-06-10 10:33:14', 4),
(178.00, '2026-06-10 11:15:52', 2), (209.00, '2026-06-10 12:08:44', 1), (148.00, '2026-06-10 12:59:01', 3),
(241.00, '2026-06-10 13:18:22', 4), (188.50, '2026-06-10 13:45:59', 2), (250.00, '2026-06-10 14:02:18', 5),
(246.00, '2026-06-10 14:19:33', 3), (240.00, '2026-06-10 14:35:50', 4), (225.20, '2026-06-10 14:52:11', 2),
(219.00, '2026-06-10 15:08:40', 5), (233.00, '2026-06-10 15:22:15', 3), (246.50, '2026-06-10 15:39:58', 4),
(192.00, '2026-06-10 15:51:12', 2), (162.00, '2026-06-10 16:04:30', 1), (111.00, '2026-06-10 16:21:44', 3),
(129.20, '2026-06-10 16:49:05', 2),
(52778.10, '2026-06-10 16:52:00', 1);

-- Day 6: 2026-06-11
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(60.00, '2026-06-11 08:50:11', 2), (105.00, '2026-06-11 09:18:35', 4), (85.50, '2026-06-11 10:41:02', 1),
(160.00, '2026-06-11 11:22:49', 3), (195.00, '2026-06-11 12:11:05', 2), (135.40, '2026-06-11 12:44:30', 4),
(232.00, '2026-06-11 13:20:15', 1), (180.00, '2026-06-11 13:58:44', 3), (250.00, '2026-06-11 14:06:12', 5),
(243.00, '2026-06-11 14:17:50', 4), (237.00, '2026-06-11 14:32:18', 1), (223.00, '2026-06-11 14:49:55', 3),
(216.00, '2026-06-11 15:04:10', 2), (231.00, '2026-06-11 15:21:33', 4), (244.50, '2026-06-11 15:36:02', 5),
(191.00, '2026-06-11 15:54:21', 3), (158.00, '2026-06-11 16:09:44', 2), (108.00, '2026-06-11 16:25:12', 4),
(116.50, '2026-06-11 16:37:19', 1),
(54029.10, '2026-06-11 16:54:00', 1);

-- Day 7: 2026-06-12
INSERT INTO Purchase ([Weight in grams], [Date of purchase], PackageId) VALUES
(78.00, '2026-06-12 08:11:02', 4), (119.00, '2026-06-12 09:44:19', 1), (94.50, '2026-06-12 10:22:50', 3),
(175.00, '2026-06-12 11:31:04', 2), (206.00, '2026-06-12 12:07:55', 4), (142.00, '2026-06-12 12:51:12', 1),
(238.00, '2026-06-12 13:14:40', 3), (186.00, '2026-06-12 13:44:02', 4), (250.00, '2026-06-12 14:03:59', 2),
(245.00, '2026-06-12 14:21:14', 1), (241.00, '2026-06-12 14:38:50', 3), (224.50, '2026-06-12 14:54:12', 4),
(217.50, '2026-06-12 15:09:23', 2), (234.00, '2026-06-12 15:24:41', 1), (246.00, '2026-06-12 15:41:05', 5),
(193.00, '2026-06-12 15:52:50', 4), (161.00, '2026-06-12 16:06:18', 2), (110.00, '2026-06-12 16:24:33', 1),
(129.40, '2026-06-12 16:53:11', 2),
(53916.10, '2026-06-12 16:56:00', 1);

-- end of tables creation and inserts

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




-- cleanup
-- USE master;
-- GO
-- ALTER DATABASE PralineShop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- GO
-- DROP DATABASE PralineShop;
-- GO