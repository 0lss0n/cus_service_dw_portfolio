/*
==========================
Skapa databas och scheman.
==========================

Syfte:
Detta skript skapar en ny databas med namnet 'DataLager' efter att ha kontrollerat om den redan finns.
Om databasen finns tas den bort och återskapas. Dessutom skapar skriptet tre scheman i databasen: 'brons', 'silver' och 'guld'.

Varning:
Om du kör det här skriptet raderas hela 'DataLager' om den finns.
Data i databasen kommer då att raderas permanent. Var försiktig och se till att du har korrekta säkerhetskopior innan du kör skriptet.
*/

USE master;
GO

-- Ta bort och återskapa 'DataLager'-databasen
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataLager')
BEGIN
  ALTER DATABASE DataLager SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataLager;
END;
GO

-- Skapa 'DataLager' databasen
CREATE DATABASE DataLager;
GO

USE DataLager;

-- Skapa Scheman
CREATE SCHEMA brons;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
