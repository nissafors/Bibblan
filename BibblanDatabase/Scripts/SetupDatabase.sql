use master;
go

/* Exchange DBxxxx with your database name, 4 places*/ 
IF (EXISTS (SELECT * from sysdatabases WHERE name = 'DBLibrary'))
BEGIN
	DROP DATABASE DBLibrary
END
GO

IF (NOT EXISTS (SELECT * from sysdatabases WHERE name = 'DBLibrary'))
BEGIN
	CREATE DATABASE DBLibrary
END

