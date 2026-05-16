/*
=====================================================================
Create Database and Schemas
=====================================================================

Script Purpose:
  This scipt creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schema
  within the database: 'bronxe', 'silver' and 'gold'.

WARNING:
  Running this script will drop the entire 'DataWarehouse' database if it exists.
  All data in the database will be permanantely deleted. Proceed with caution
  and ensure you have the proper backups before running the script.
*/


USE master;

--- Drop and  recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE anem = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse
END;
GO

-- Create the 'DataWarehouse' databse
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
