--Data - raw, data will be useful information when given context, it can be images, text, charts, figures 
--Database is a collection of data
--Relational Database is structured database which includes data in tables consisting of columns and row.
-- SQL Server key features - SQL is mostly using data analysis and BI, performane, advanced security, high availablity, big data integration.
-- 2 mode of connecting to SQL Server - Windows Authentication and SQL Server Authentication.
--
CREATE DATABASE SchoolDB
USE SchoolDB
CREATE TABLE Students (StudentID INT, PRIMARY KEY, Name VARCHAR(50), Age INT)
SELECT * FROM Students


 --SQL is the language, SQL Server is the database management system that understands and executes that language, and SSMS is the tool used to visually interact with and manage SQL Server.
-- SQL Commands:
-- DQL - DATA QUERY LANGUAGE - SELECT
--DML - DATA MANIPULATION LANGUAGE - INSERT, UPDATE, DELETE
-- DATA DEIFNITION LANGUAGE - ALTER, CREATE, DROP, TRUNCATE
--DCL - DATA CONTROL LANGUAGE - REVOKE, GRANT 
-- TCL TRANSACTION CONTROL LANGUAGE - BEGIN TRAN, COMMIT TRAN, ROLL BACK TRAN 
