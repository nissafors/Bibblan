ALTER DATABASE BibblanDatabase SET OFFLINE
GO

ALTER DATABASE BibblanDatabase MODIFY FILE (NAME = BibblanDatabase, FILENAME = 'C:\Users\othe1492\Source\Repos\Bibblan\BibblanDatabase\Database\BibblanDatabase.mdf');
ALTER DATABASE BibblanDatabase MODIFY FILE (NAME = BibblanDatabase_log, FILENAME = 'C:\Users\othe1492\Source\Repos\Bibblan\BibblanDatabase\Database\BibblanDatabase_log.ldf');
GO

ALTER DATABASE BibblanDatabase SET ONLINE
GO

--SELECT name, physical_name AS CurrentLocation, state_desc
--FROM sys.master_files
--WHERE database_id = DB_ID(N'BibblanDatabase');